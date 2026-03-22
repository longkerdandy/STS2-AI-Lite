---
name: combat-loop
description: Full combat loop and reward settlement procedure for Slay the Spire 2 — state parsing, turn execution, error recovery, combat-end detection, and post-combat reward claiming
---

## Combat Loop Procedure

Execute this loop continuously until combat ends, then settle rewards.

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
  relics[] — equipped relics (check for combat-relevant effects)

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

Plan ALL actions for this turn before executing any. Consider:

1. **Survival first**: If lethal, plan block cards / defensive potions / kills to survive.
2. **Kill opportunities**: Can any enemy be killed? Calculate exact damage needed.
3. **Efficient plays**: Maximize damage-per-energy, play buffs before attacks.
4. **Potion timing**: Use potions only if the situation warrants it.
5. **0-cost cards**: Always play 0-cost cards if beneficial.

Output the plan as a numbered list before executing.

### Step 4: Execute Actions

Play cards one at a time. After each play, track index shifts:

```bash
# Playing from a 5-card hand: [0:Strike, 1:Defend, 2:Bash, 3:Strike, 4:Defend]
# If you play index 2 (Bash), the hand becomes:
# [0:Strike, 1:Defend, 2:Strike, 3:Defend]
# Old index 3 is now index 2, old index 4 is now index 3
```

For targeted cards (Attack cards, targeted skills):
```bash
./sts2 play_card <index> --target <combat_id>
```

For untargeted cards (self-buffs, AoE, skills without target):
```bash
./sts2 play_card <index>
```

For potions:
```bash
./sts2 use_potion <slot> --target <combat_id>   # targeted potions
./sts2 use_potion <slot>                         # self-targeted potions
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

If the player won, proceed to Reward Settlement (below).

## Reward Settlement Procedure

After combat victory, the game transitions to the reward screen. Execute this procedure to claim all rewards.

### Step 7: Confirm Reward Screen

```bash
./sts2 state
```

Verify `data.screen == "REWARD"`. If not on the reward screen (e.g., player died or screen transitioned unexpectedly), report to user and stop.

Read the `data.rewards.rewards[]` array. Each reward has an `index`, `type`, and type-specific fields.

### Step 8: Claim Non-Card Rewards

Process Gold, Potion, Relic, and SpecialCard rewards first:

```bash
./sts2 claim_reward <index>
```

For each non-card reward:
- **Gold**: Always claim.
- **Relic**: Always claim.
- **Potion**: Claim if belt has space. If `POTION_BELT_FULL` error, skip this reward.
- **SpecialCard**: Always claim (added directly to deck).

Before each claim, output 1 sentence explaining what is being claimed.

### Step 9: Handle Card Rewards

**Load the `card-reward` skill** for structured card evaluation logic. Also read `docs/builds.md` for archetype strategy details.

For each reward with `type == "Card"`, evaluate the `card_choices[]` array (typically 3 cards) using the card-reward skill's 5-step procedure:

1. **Identify build archetype** — Check `run-state.md` for prior assessment, or analyze deck composition.
2. **Evaluate each choice** — Score on archetype fit, S-tier status, weakness coverage, deck size.
3. **Apply act-specific adjustments** — Act 1 favors damage/AoE, Act 2 favors scaling, Act 3+ is selective.
4. **Pick or skip** — Take the highest-scoring card, or skip if all choices are negative.
5. **Update run state** — If the pick meaningfully shifts the deck's archetype or strategy, update `run-state.md`.

Read `docs/cards.md` if unfamiliar with any card in the choices.

To pick a card:
```bash
./sts2 choose_card <reward_index> <card_index>
```

To skip (take nothing):
```bash
./sts2 skip_card <reward_index>
```

Before each decision, output 1 sentence explaining the choice with reasoning (reference archetype and deck state).

### Step 10: Proceed

When all rewards have been claimed or skipped:

```bash
./sts2 proceed
```

Report a summary: rewards claimed (gold amount, potions, relics) and card chosen or skipped.

### Reward Error Recovery

| Error | Action |
|-------|--------|
| `NOT_ON_REWARD_SCREEN` | Run `./sts2 state`, check current screen, stop if not on rewards |
| `INVALID_REWARD_INDEX` | Run `./sts2 state`, re-read reward list |
| `USE_CHOOSE_CARD` | Reward is a card reward — use `choose_card` or `skip_card` instead |
| `POTION_BELT_FULL` | Skip this potion reward, continue to next |
| `NOT_SUPPORTED` | Skip this reward, continue to next |
| `CLAIM_FAILED` | Run `./sts2 state` to refresh, retry once |
| `CONNECTION_ERROR` | Stop, report connection failure |

### Error Recovery

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

On any error, always re-run `./sts2 state` before continuing.

### Long Combat Notes

For fights exceeding ~10 turns, write key state to a note file to preserve information across potential context compaction:

```
Use the Write tool to save to combat-notes.md:
- Turn number
- Player HP / Max HP
- Enemies remaining with HP
- Key powers/buffs active
- Potions remaining
```

This prevents information loss during extended fights.
