---
name: combat-loop
description: Full combat loop and reward settlement procedure for Slay the Spire 2 — state parsing, turn execution, error recovery, combat-end detection, and post-combat reward claiming
---

## Combat Loop Procedure

Use this skill when **starting a full combat sequence** (e.g., via `/fight` command).

Execute this loop continuously until combat ends, then settle rewards.

### Step 0: Initialize/Read Run State (CRITICAL)

**Load the `run-state-management` skill** before every combat.

Check if the game is a **new run** by examining state:
- New character selected
- hp = max_hp AND gold = 99 AND starter deck only
- Act 1, Floor 0-1

**If new run detected:**
- Clear `run-state.md` and initialize with starter template
- Set Character, Act = 1, Ascension, Build = "Early Act 1 / Undecided"

**If continuing run:**
- Read `run-state.md` for current build archetype and strategy notes
- Use this information to inform combat decisions

Proceed to Step 1.

### Step 1: Read State

```bash
./sts2 state
```

Parse the JSON response. Check these preconditions before acting:

| Field | Required Value | If Not |
|-------|---------------|--------|
| `data.screen` | `"COMBAT"` | Stop — not in combat |
| `data.combat.is_player_turn` | `true` | Wait — enemy turn in progress |
| `data.combat.is_player_actions_disabled` | `false` or absent | Wait — actions disabled |
| `data.combat.is_combat_ending` | `false` or absent | Stop — combat is resolving |

### Step 2: Analyze the Board

Extract these values from the state:

```
Player:
  hp, max_hp, block, energy, max_energy
  hand[] — playable cards with cost, damage, block, type, keywords
  potions[] — available potions with slot, target_type
  powers[] — active buffs/debuffs
  relics[] — equipped relics

Enemies (alive only, where is_alive == true):
  For each enemy:
    combat_id, name, hp, max_hp, block
    intents[] — with type, damage (per-hit), hits
    powers[] — active buffs/debuffs
```

Calculate total incoming damage:
```
total_incoming = sum of (intent.damage * intent.hits) for each alive enemy with Attack intents
lethal_gap = total_incoming - player.block - player.hp
```

If `lethal_gap > 0`, the player will die this turn without intervention.

### Step 3: Plan the Full Turn

**Load the `end-state-evaluation` skill** for detailed turn planning procedures.

Plan ALL actions for this turn before executing any:

1. **Generate 2-4 candidate sequences** — different card orders, targeting patterns, with/without potions
2. **Simulate end-state** for each — enemy HP, player HP after counter-attack, energy remaining
3. **Apply Evaluation Priority** — Kill > Survival > Net damage > Energy usage
4. **Select optimal sequence**
5. **Verify Hard Constraints** — lethal handled? energy will be 0?

Output the plan as a numbered list before executing.

### Step 4: Execute Actions

Play cards one at a time:

For targeted cards (Attack cards, targeted skills):
```bash
./sts2 play_card <card_id> --target <combat_id>
```

For untargeted cards (self-buffs, AoE, skills without target):
```bash
./sts2 play_card <card_id>
```

For potions:
```bash
./sts2 use_potion <potion_id> --target <combat_id>   # targeted potions
./sts2 use_potion <potion_id>                         # self-targeted potions
```

After each action, briefly verify the result JSON:
- Check `results[]` for damage dealt, block gained, etc.
- If a kill occurred (`killed: true`), note the enemy is dead.

### Step 5: End Turn

When no more beneficial plays exist (energy exhausted or no good cards):

```bash
./sts2 end_turn
```

The response contains enemy turn results. Scan for:
- Damage taken by player
- Buffs/debuffs applied
- Enemies that died (from DoT, thorns, etc.)
- New powers gained by enemies

### Step 6: Repeat

Go back to Step 1. Run `./sts2 state` again to get the fresh state for the next turn.

### Combat End Detection

Combat ends when any of these occur:
- `is_combat_ending == true` in the state
- `screen != "COMBAT"` in the state
- All enemies are dead (`is_alive == false` for all)
- Player HP reaches 0

When combat ends, report the outcome to the user:
- Win: "Combat won. Player HP: X/Y."
- Loss: "Combat lost. Player died on turn N."

If the player won, proceed to Step 6.

### Step 6: Update Run State (Post-Combat)

**Load the `run-state-management` skill.**

After combat victory, update `run-state.md` with:
- Combat outcome summary (turns taken, damage taken)
- Any significant observations (new enemy patterns, deck weaknesses exposed)
- Archetype assessment (if signals strengthened or changed)

**Do NOT update archetype yet** — wait until after card rewards.

Proceed to Reward Settlement.

## Reward Settlement Procedure

After combat victory, the game transitions to the reward screen.

### Step 7: Confirm Reward Screen

```bash
./sts2 state
```

Verify `data.screen == "REWARD"`. If not on the reward screen, report to user and stop.

Read the `data.rewards.rewards[]` array.

### Step 8: Claim Non-Card Rewards

Process Gold, Potion, Relic, and SpecialCard rewards first:

```bash
./sts2 claim_reward --type gold                                  # Claim gold reward
./sts2 claim_reward --type potion --id <potion_id>               # Claim potion
./sts2 claim_reward --type relic --id <relic_id>                 # Claim relic
./sts2 claim_reward --type potion --id <potion_id> --nth 1       # Claim 2nd potion of same type
```

For each non-card reward:
- **Gold**: Always claim.
- **Relic**: Always claim.
- **Potion**: Claim if belt has space. If `POTION_BELT_FULL` error, skip this reward.
- **SpecialCard**: Always claim.

Before each claim, output 1 sentence explaining what is being claimed.

### Step 9: Handle Card Rewards

**Required:** Load the `card-reward` skill for structured card evaluation logic. Also read `docs/builds.md` for archetype strategy details.

For each reward with `type == "Card"`, evaluate the `card_choices[]` array using the card-reward skill's procedure.

To pick a card:
```bash
./sts2 choose_card --type card --card_id <card_id>          # Select from 1st card reward
./sts2 choose_card --type card --card_id <card_id> --nth 1  # Select from 2nd card reward
```

To skip (take nothing):
```bash
./sts2 skip_card --type card              # Skip 1st card reward
./sts2 skip_card --type card --nth 1      # Skip 2nd card reward
```

Before each decision, output 1 sentence explaining the choice.

### Step 10: Proceed

When all rewards have been claimed or skipped:

```bash
./sts2 proceed
```

Report a summary: rewards claimed (gold amount, potions, relics) and card chosen or skipped.

### Step 11: Final Run State Update (Post-Rewards)

**Load the `run-state-management` skill.**

After all rewards are processed, update `run-state.md` with:

**Always update:**
- Deck Size: current total count
- Relics: list current key relics
- Potions: list current potions
- Act: verify and update if transitioned

**Update if meaningful change occurred:**
- Build: if card pick committed to or shifted archetype
- Key Cards: if new archetype-defining card acquired
- Weaknesses: reassess current deck gaps
- Notes: timestamped observations about new pickups and strategy shifts

**Example format:**
```markdown
# Run State

## Character: The Ironclad
## Act: 1
## Ascension: 0

## Build: Exhaust + Block blend (committed)

## Key Cards: Feel No Pain, Corruption, Shrug It Off, Body Slam

## Deck Size: 18

## Relics: Burning Blood, Orichalcum, Dead Branch

## Potions: Fire Potion, Dexterity Potion

## Weaknesses: No consistent scaling outside Exhaust triggers

## Notes:
- [Act 1, Floor 12]: Acquired Corruption - Exhaust engine online
- [Act 1, Floor 12]: Picked Body Slam to convert block to damage
- Watch for: Dark Embrace (draw on Exhaust), Second Wind (exhaust to block)
```

This completes the combat + reward settlement cycle.

## Error Recovery

### Combat Errors

| Error | Action |
|-------|--------|
| `INVALID_CARD_INDEX` | Run `./sts2 state`, re-read hand, adjust indices |
| `TARGET_NOT_FOUND` | Run `./sts2 state`, check alive enemies, retarget |
| `CANNOT_PLAY_CARD` | Skip this card, try next planned action |
| `NOT_IN_COMBAT` | Stop loop, report to user |
| `COMBAT_ENDING` | Stop loop, report outcome |
| `CONNECTION_ERROR` | Stop loop, report connection failure |
| Exit code 4 (timeout) | Retry once, then stop |
| Exit code 5 (state changed) | Run `./sts2 state` to refresh, re-plan |

### Reward Errors

| Error | Action |
|-------|--------|
| `NOT_ON_REWARD_SCREEN` | Run `./sts2 state`, check current screen, stop if not on rewards |
| `INVALID_REWARD_INDEX` | Run `./sts2 state`, re-read reward list |
| `USE_CHOOSE_CARD` | Reward is a card reward — use `choose_card` or `skip_card` instead |
| `POTION_BELT_FULL` | Skip this potion reward, continue to next |
| `NOT_SUPPORTED` | Skip this reward, continue to next |
| `CLAIM_FAILED` | Run `./sts2 state` to refresh, retry once |
| `CONNECTION_ERROR` | Stop, report connection failure |

On any error, always re-run `./sts2 state` before continuing.

## Related Skills

| Situation | Load Skill |
|-----------|------------|
| Initialize/read run state | `run-state-management` |
| Planning individual turns | `end-state-evaluation` |
| Evaluating enemy threats | `threat-assessment` |
| Potion use timing | `potion-timing` |
| Card reward decisions | `card-reward` |

## Game Knowledge References

| Need | Read File |
|------|-----------|
| Unfamiliar cards | `docs/cards.md` |
| Unfamiliar enemies | `docs/enemies.md` |
| Unfamiliar relics | `docs/relics.md` |
| Unfamiliar potions | `docs/potions.md` |
| Build archetypes | `docs/builds.md` |
| CLI reference | `docs/cli-reference.md` |
