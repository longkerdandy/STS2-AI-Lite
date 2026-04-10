---
name: combat-loop
description: Full combat loop procedure for Slay the Spire 2 — state parsing, turn planning, infinite loop execution, error recovery, and combat-end detection
---

## Combat Loop Procedure

Use this skill when **starting a full combat sequence**. Execute this loop continuously until combat ends.

### Step 0: Read Run State

Read `run-state.md` for **Infinite Readiness**:
- `Not Started` / `Building`: Normal combat — use decision tree below
- `Almost Ready`: Exhaust for value but don't force the loop
- `Infinite Ready`: Plan exhaust-to-loop, then execute infinite cycle

### Step 1: Read State

```bash
./sts2 state
```

| Field | Required | If Not |
|-------|----------|--------|
| `screen` | `COMBAT` | Stop — not in combat |
| `is_player_turn` | `true` | Wait — enemy turn |
| `is_player_actions_disabled` | `false`/absent | Wait — actions disabled |
| `is_combat_ending` | `false`/absent | Stop — combat resolving |

### Step 2: Analyze the Board

Extract:
- **Player**: hp, block, energy, hand[], draw/discard/exhaust piles, potions, powers, relics
- **Enemies** (alive only): combat_id, name, hp, block, intents[], powers[]

**Lethal check** (always do this first):
```
total_incoming = sum(intent.damage * intent.hits) for each alive enemy with Attack intents
survival_margin = player.hp + player.block - total_incoming
If survival_margin <= 0 → LETHAL — must block, kill, or use potion
If survival_margin <= 10 → HIGH RISK — strongly prefer blocking
```

**Infinite assessment** (when readiness is Almost Ready / Infinite Ready):
```
Active deck = hand + draw_pile + discard_pile (NOT exhaust_pile)
Engine powers active? → Corruption, Dark Embrace, Feel No Pain
Cards still to exhaust = active deck cards that are NOT loop components
```

### Step 3: Plan the Turn

Use this **decision tree** (strict priority order):

```
1. LETHAL? → Block/kill/potion to survive (P0)
2. INFINITE READY + engine can activate? → Setup engine → exhaust → loop (P1)
3. CAN KILL an enemy? → Kill it — removes future damage (P2)
4. Otherwise → Balanced play: damage + block + exhaust for value (P3)
```

**Hard constraints:**
- Lethal incoming → must survive (block, potion, or kill the source)
- Kill possible → must kill (removing future damage is always correct)
- Energy > 0 and playable cards → must keep playing
- Infinite achievable this turn → activate it (guarantees kill of everything)

#### Normal Combat Plan (Not Infinite Ready)

Plan ALL actions before executing:
1. Check if any enemy can be killed (damage in hand ≥ enemy hp + block)
2. If lethal incoming, prioritize block cards / defensive potions
3. Play buff cards before attacks (Vulnerable → attacks = more total damage)
4. Use all energy — play 0-cost cards last if needed
5. For multi-enemy: prefer killing one to reduce future incoming damage

#### Infinite Combat Plan

**Phase A — Engine Setup (turns 1-3):**
1. Play engine powers: Dark Embrace, Feel No Pain, Corruption (if in hand)
2. Use energy generators: Offering, Bloodletting (for extra energy to play powers)
3. Exhaust non-loop cards: True Grit, Burning Pact, Second Wind, Brand
4. Block using Feel No Pain triggers or emergency block cards

**Phase B — Loop Execution (active deck thin enough):**
1. Identify remaining loop cards in hand+draw+discard
2. Verify: net energy ≥ 0 per cycle, net draw ≥ active deck size
3. Execute loop repeatedly until all enemies die
4. **Always re-read state between cycles** — never assume hand contents

**Transition A→B when:**
- Active deck ≤ 8 cards AND all loop-compatible, OR
- Corruption active AND all Skills will auto-exhaust, OR
- Playing all exhaust cards this turn leaves only loop components

#### Infinite Setup vs Kill Priority

Infinite setup overrides single kills UNLESS:
- You will die before the loop activates (P0 always wins)
- An enemy is about to do something catastrophic (massive scaling, summon wave)

#### Threat Adjustments for Infinite Decks

**Reduced urgency:** Scaling enemies (Ritual, Strength), high HP enemies, multi-enemy encounters — infinite loop outscales all of these.

**Increased urgency:** High burst damage turns 1-3 (need potions/block to survive setup), debuff enemies applying Frail (reduces Feel No Pain block), enemies with Artifact (can't apply Weak to reduce damage).

**Doormaker Boss (Act 3):** Three mechanics counter infinite: (1) HungerPower/GraspPower apply Weighted affliction to all cards (extra energy cost per card), (2) ScrutinyPower blocks draw effects (Dark Embrace, Pommel Strike, etc.), (3) Grasp deals 20/23 damage + Str/Dex debuff. Race to kill turns 1-4; Corruption nullifies Weighted on Skills; keep 0-cost cards (Spite, Bloodletting) playable; pre-build block via FNP before Scrutiny turn. Pattern: Open → Hunger → Scrutiny → Grasp → loop.

### Step 4: Execute Actions

Play cards one at a time:

```bash
./sts2 play_card <card_id> --target <combat_id>   # targeted cards
./sts2 play_card <card_id>                         # untargeted cards
./sts2 use_potion <potion_id> --target <combat_id> # targeted potions
./sts2 use_potion <potion_id>                      # self-targeted potions
```

After each action, check results[]: kills, damage dealt, block gained.

#### Infinite Loop Execution

When in Phase B:
1. Determine play order: energy generators → draw cards → damage → block
2. Execute one full cycle of all loop cards
3. Re-read state: `./sts2 state`
4. If enemies dead → combat over
5. If alive → repeat cycle

**Loop safeguard:** After 5 cycles without killing, stop and reassess. The loop may not be lethal (enemy healing/block > loop damage).

### Step 5: End Turn

```bash
./sts2 end_turn
```

Read enemy turn results: damage taken, buffs/debuffs applied, enemy deaths.

During infinite loop: don't end turn until enemies die. If out of energy mid-loop, ensure FNP block is enough to survive enemy turn.

### Step 6: Repeat

Go back to Step 1. Run `./sts2 state` for fresh state.

### Combat End Detection

Combat ends when: `is_combat_ending == true`, `screen != COMBAT`, all enemies dead, or player HP = 0.

Report: Win/loss, final HP, turns taken, whether infinite achieved.
Update `run-state.md` Notes with significant combat observations, then **return control to caller**.

## Infinite Loop Reference

### Loop-Compatible Cards

| Card | Cost | Cycle Mechanism | Value |
|------|------|-----------------|-------|
| Bloodletting | 0 | +2(3) energy | Energy generator |
| Pommel Strike | 1 | Draw 1(2) | 9(10) damage |
| Shrug It Off | 1 | Draw 1 | 8(11) block |
| Spite | 0 | Draw 1 if lost HP | 6(9) damage |
| Flash of Steel | 0 | Draw 1 | 5(8) damage |
| Finesse | 0 | Draw 1 | 4(7) block |
| Headbutt | 1 | Put discard on draw | 9(12) damage |
| Offering | 0 | +2E, draw 3(5), exhaust | One-time boost |
| Battle Trance | 0 | Draw 3(4) | Draw only |

### Loop Viability Check

A loop works when:
1. **Net energy ≥ 0** per cycle (energy generated ≥ card costs)
2. **Net draw ≥ active deck size** (draw back all cards each cycle)
3. **Positive damage** (at least one card deals damage)
4. **Enemies will die** (loop damage/cycle > enemy healing/block per turn)

## Error Recovery

| Error | Action |
|-------|--------|
| `CARD_NOT_FOUND` / `TARGET_NOT_FOUND` | `./sts2 state`, re-read hand/enemies, adjust |
| `CANNOT_PLAY_CARD` | Skip card, try next action |
| `NOT_IN_COMBAT` / `COMBAT_ENDING` | Stop loop, report outcome |
| `CONNECTION_ERROR` | Stop, report failure |
| Exit code 4 (timeout) | Retry once, then stop |
| Exit code 5 (state changed) | `./sts2 state` to refresh, re-plan |

On any error, always re-run `./sts2 state` before continuing.

### Bug Reporting

When encountering potential CLI MOD bugs (TIMEOUT, ACTION_CANCELLED, TUI glitches, state desync), file a structured report:

```
./sts2 report_bug --title "<short summary>" --description "<what happened vs expected>" --last-command "<the command>" --last-response '<json response>' --severity <low|medium|high|critical> --labels "<comma-separated>"
```

This auto-captures a game state snapshot. Use severity `high` for combat-breaking issues, `critical` for data loss or crashes.

## Game Knowledge References

| Need | Read File |
|------|-----------|
| Unfamiliar cards | `docs/cards.md` |
| Unfamiliar enemies | `docs/enemies.md` |
| Unfamiliar relics | `docs/relics.md` |
| Unfamiliar potions | `docs/potions.md` |
| Build strategy | `docs/builds.md` |
| Potion timing | Load `potion-timing` skill |
