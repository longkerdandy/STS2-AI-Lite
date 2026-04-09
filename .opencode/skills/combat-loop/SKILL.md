---
name: combat-loop
description: Full combat loop procedure for Slay the Spire 2 — state parsing, turn execution, error recovery, and combat-end detection
---

## Combat Loop Procedure

Use this skill when **starting a full combat sequence** (e.g., via `/fight` command).

Execute this loop continuously until combat ends.

### Step 0: Read Run State

Read `run-state.md` for current build archetype and strategy notes. Use this to inform combat decisions (e.g., Exhaust decks can afford longer fights, Strength decks prioritize scaling).

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

When combat ends, report the outcome:
- Win: "Combat won. Player HP: X/Y. Turns: N."
- Loss: "Combat lost. Player died on turn N."

If the player won, update `run-state.md` Notes with combat observations (if significant), then **return control to the caller**. Reward settlement is handled separately by the Deck-Building Agent.

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
| Build archetypes | `docs/builds.md` |
| CLI reference | `docs/cli-reference.md` |
