---
name: combat-loop
description: Full combat loop procedure for Slay the Spire 2 — state parsing, turn execution, infinite loop detection, error recovery, and combat-end detection
---

## Combat Loop Procedure

Use this skill when **starting a full combat sequence** (e.g., via `/fight` command).

Execute this loop continuously until combat ends.

### Step 0: Read Run State

Read `run-state.md` for current build status:
- **Infinite Readiness level** — determines combat approach:
  - `Not Started` / `Building`: Play normally using end-state-evaluation
  - `Almost Ready`: Use exhaust cards for value but don't force the loop
  - `Infinite Ready`: Plan to exhaust-to-loop, then execute infinite cycle

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
  draw_pile[] — cards remaining to draw
  discard_pile[] — cards in discard
  exhaust_pile[] — cards exhausted this combat
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

#### Infinite Loop Assessment

If run-state readiness is "Infinite Ready" or "Almost Ready", also assess:

```
Active deck = hand + draw_pile + discard_pile (everything NOT in exhaust_pile)
Engine powers active? Check player.powers for:
  - Dark Embrace (draw per exhaust)
  - Feel No Pain (block per exhaust)
  - Corruption (skills cost 0 + exhaust)

Cards to exhaust = active deck cards that are NOT loop components
Loop components in active deck = cards that cycle (deal damage/block + draw/generate energy)
```

### Step 3: Plan the Full Turn

**Load the `end-state-evaluation` skill** for detailed turn planning procedures.

#### Normal Combat (Not Infinite Ready)

Plan ALL actions for this turn before executing any:

1. **Generate 2-4 candidate sequences** — different card orders, targeting patterns, with/without potions
2. **Simulate end-state** for each — enemy HP, player HP after counter-attack, energy remaining
3. **Apply Evaluation Priority** — Kill > Survival > Net damage > Energy usage
4. **Select optimal sequence**
5. **Verify Hard Constraints** — lethal handled? energy will be 0?

Output the plan as a numbered list before executing.

#### Infinite Combat (Infinite Ready)

Plan in two phases:

**Phase A — Setup (Turns 1-3):**
1. Play engine powers: Dark Embrace, Feel No Pain, Corruption (if in hand and affordable)
2. Use energy generators: Offering, Bloodletting (for extra energy to play powers)
3. Begin exhausting non-loop cards: True Grit, Burning Pact, Second Wind, Brand
4. Block as needed using Feel No Pain triggers or emergency block cards

**Phase B — Loop Execution (when active deck is thin enough):**
1. Identify the loop: which cards remain in hand+draw+discard?
2. Can they cycle? Check: net energy ≥ 0 per cycle, net draw ≥ active deck size
3. If YES: execute the loop repeatedly until all enemies are dead
4. If NOT YET: continue exhausting on this turn, wait for next turn

**Transition detection:** Move from Phase A to Phase B when:
- Active deck ≤ 8 cards AND all are loop-compatible, OR
- Corruption is active AND all Skills will auto-exhaust, OR
- You can see that playing all exhaust cards this turn will leave only loop components

Output the plan with phase label before executing.

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

**For selection potions** (Gambler's Brew, Liquid Memories, etc.):
```bash
# 1. Use potion - this may return selection_required or change screen
./sts2 use_potion GAMBLERS_BREW

# 2. If screen becomes POTION_SELECTION, use potion_select_card
./sts2 potion_select_card <card_id> [<card_id>...]   # Select specific cards
./sts2 potion_select_skip                             # Or skip if allowed

# 3. Always verify state returns to COMBAT
./sts2 state
```

After each action, briefly verify the result JSON:
- Check `results[]` for damage dealt, block gained, etc.
- If a kill occurred (`killed: true`), note the enemy is dead.
- If `status: "selection_required"` appears, handle potion selection before continuing.

#### Infinite Loop Execution

When executing the infinite loop (Phase B), follow this procedure:

1. **Identify remaining loop cards** — re-read state to confirm active deck composition
2. **Determine play order** — energy generators first (Bloodletting), then draw cards (Pommel Strike), then damage (attacks), then block (Shrug It Off)
3. **Execute one full cycle** — play all loop cards in order
4. **Re-read state** after the cycle completes: `./sts2 state`
5. **Check if enemies are dead** — if all dead, combat over
6. **If alive, repeat** — the loop cards should be back in hand/draw. Play another cycle.

**Important:** Re-read state between cycles. Don't assume card positions — always verify hand contents before each play.

**Loop safeguard:** If you've executed 5 cycles without killing and enemies are gaining HP/block faster than you deal damage, the loop may not be lethal. Stop looping, assess if a different approach is needed (e.g., use a potion, or find a different damage source).

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

**Note:** During infinite loop execution, you typically don't end turn until all enemies are dead. If you run out of energy mid-loop and need to pass, ensure Feel No Pain has generated enough block to survive the enemy turn.

### Step 6: Repeat

Go back to Step 1. Run `./sts2 state` again to get the fresh state for the next turn.

### Combat End Detection

Combat ends when any of these occur:
- `is_combat_ending == true` in the state
- `screen != "COMBAT"` in the state
- All enemies are dead (`is_alive == false` for all)
- Player HP reaches 0

When combat ends, report the outcome:
- Win: "Combat won. Player HP: X/Y. Turns: N."
- Loss: "Combat lost. Player died on turn N."

If the player won, update `run-state.md` Notes with combat observations (if significant), then **return control to the caller**. Reward settlement is handled separately by the Deck-Building Agent.

## Infinite Loop Detection Reference

### Loop-Compatible Cards

Cards that can be part of an infinite cycle (they deal damage/block AND cycle):

| Card | Cost | Cycle Mechanism | Damage/Block |
|------|------|-----------------|--------------|
| Bloodletting | 0 | +2(3)E = net energy gain | None (energy card) |
| Pommel Strike | 1 | Draw 1(2) | 9(10) damage |
| Shrug It Off | 1 | Draw 1 | 8(11) block |
| Spite | 0 | Draw 1 if lost HP | 6(9) damage |
| Flash of Steel | 0 | Draw 1 | 5(8) damage |
| Finesse | 0 | Draw 1 | 4(7) block |
| Headbutt | 1 | Put discard on draw | 9(12) damage |
| Offering | 0 | +2E, draw 3(5), exhaust | One-time boost |
| Battle Trance | 0 | Draw 3(4) | None (draw only) |

### Loop Viability Check

A loop is viable when:
1. **Net energy per cycle ≥ 0**: Sum of energy generated ≥ sum of card costs
2. **Net draw per cycle ≥ active deck size**: You draw back all cards each cycle
3. **Positive damage**: At least one card in the loop deals damage
4. **All enemies will eventually die**: Loop damage per cycle > enemy healing/block per turn

### Example Loop Analysis

```
Active deck: Bloodletting, Pommel Strike+, Spite, Shrug It Off, Headbutt
Energy per cycle: +2 (Bloodletting) - 1 (PS) - 0 (Spite) - 1 (SIO) - 1 (HB) = -1
This does NOT loop with 3 base energy! Need: Bloodletting+ (+3E) OR remove one 1-cost card.

Active deck: Bloodletting+, Pommel Strike+, Spite, Shrug It Off
Energy: +3 - 1 - 0 - 1 = +1 (OK!)
Draw: 2 (PS+) + 1 (Spite, if lost HP from BL) + 1 (SIO) = 4 draws, 4 cards. LOOPS!
Damage: 10 (PS) + 9 (Spite) = 19 per cycle. All enemies die eventually.
```

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

On any error, always re-run `./sts2 state` before continuing.

### CLI Error Logging

When encountering potential CLI MOD bugs or limitations, **record in `.opencode/logs/cli-errors.md`**:

| Issue Type | Log? | Notes |
|------------|------|-------|
| TIMEOUT on potion use | **YES** | Especially interactive potions (Gambler's Brew) |
| TUI blank line floods | **YES** | Visual glitch during debuff/potion animations |
| ACTION_CANCELLED after timeout | **YES** | State desync after error |
| Successful API but wrong visual | **YES** | API says ok:true but game shows different |
| POTION_SELECTION screen stuck | **YES** | TUI frozen during card selection |
| CANNOT_PLAY_CARD (energy/valid) | NO | Expected game logic |
| NOT_IN_COMBAT / COMBAT_ENDING | NO | Expected state transitions |

**Log format:**
```markdown
### YYYY-MM-DD: Description
- **Command**: What was executed
- **Error Type**: TIMEOUT / TUI_GLITCH / ACTION_CANCELLED
- **Context**: Turn X vs Enemy
- **Workaround**: How resolved
- **Status**: OPEN
```

See `cli-errors.md` for examples and full recovery protocols.

## Related Skills

| Situation | Load Skill |
|-----------|------------|
| Initialize/read run state | `run-state-management` |
| Planning individual turns | `end-state-evaluation` |
| Evaluating enemy threats | `threat-assessment` |
| Potion use timing | `potion-timing` |

## Game Knowledge References

| Need | Read File |
|------|-----------|
| Unfamiliar cards | `docs/cards.md` |
| Unfamiliar enemies | `docs/enemies.md` |
| Unfamiliar relics | `docs/relics.md` |
| Unfamiliar potions | `docs/potions.md` |
| Build strategy | `docs/builds.md` |
| CLI reference | `docs/cli-reference.md` |
