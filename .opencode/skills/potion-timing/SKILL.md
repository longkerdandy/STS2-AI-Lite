---
name: potion-timing
description: Potion usage timing and strategy for Slay the Spire 2 — when to use, save, or discard potions
---

## Potion Timing

Use this skill when **deciding whether to use a potion** in combat or when **evaluating potion rewards**.

Potions are single-use consumables with powerful effects. Using them at the right time is critical — wasted potions can't be recovered.

## Infinite Engine Context

Potion strategy changes based on Infinite Readiness (read `run-state.md`):

| Readiness | Potion Strategy |
|-----------|----------------|
| **Not Started / Building** | Standard potion usage — survive fights to keep collecting components |
| **Almost Ready** | Use defensive potions aggressively to survive until engine comes online. Save Energy Potions for the turn you set up the engine. |
| **Infinite Ready** | Potions matter most in the **setup phase** (turns 1-3 before loop starts). Once loop is running, potions are unnecessary. Use them early to survive setup. |

### Engine Setup Potions (High Value for Infinite)

| Potion | Infinite Value | When to Use |
|--------|---------------|-------------|
| **Energy Potion** (+2 Energy) | **Critical** | Turn where you play Corruption + Dark Embrace + other engine pieces. Extra energy enables full setup in one turn. |
| **Drawing Potion** (+3 Draw) | **Very High** | Early turns to find engine components faster. Draw into Corruption/Dark Embrace/Feel No Pain. |
| **Block Potion** (12 Block) | **High** | Setup turns when you're spending all energy on Powers instead of blocking. Buys time. |
| **Duplication Potion** | **High** | Duplicate Offering (5 cards + energy) or a key Power if you have 2. |
| **Dexterity Potion** (+2 Dex) | Low | Less valuable — once loop runs, Feel No Pain provides all block needed. |

### Pre-Loop Survival Priority

During turns 1-3 of a fight (before Infinite loop activates):
1. **Use defensive potions liberally** — Block Potion, Ancient Potion to survive while setting up
2. **Use Energy Potion on THE setup turn** — the turn you play Corruption + draw/exhaust Powers
3. **Use Drawing Potion on turn 1** — maximizes chance of finding engine pieces early
4. **Save offensive potions** — once loop runs, damage is unlimited; offensive potions are wasted

## When to Use Potions

**Use immediately when:**

1. **Facing lethal** — If incoming damage will kill you and you can't block enough, use defensive potions.

2. **Reaching lethal on a dangerous enemy** — If a potion enables killing a boss or elite that would otherwise survive and scale, use it.

3. **Boss fights** — Potions are meant to be used. Don't hoard through a boss fight.

4. **Belt is full and better potion available** — If potion belt is full (default 3 slots for Ironclad) and you find a better potion, use or discard the weakest one.

5. **Elite fights with high stakes** — Elites are dangerous and give good rewards. Potions help ensure clean wins.

## When to SAVE Potions

**Save potions when:**

1. **Easy normal fights** — Regular hallway fights against weak enemies don't warrant potion use.

2. **Early in a fight** — Don't use potions on turn 1 of a long fight unless immediately threatened.

3. **Boss approaching** — If the map shows a boss fight coming soon, save potions for it.

4. **Potion belt has room** — No need to use a potion just because you have it.

## Potion Categories and Timing

### Offensive Potions

| Potion | When to Use |
|--------|-------------|
| Fire Potion (20 dmg) | Kill threshold — finishes off an enemy that would survive |
| Explosive Potion (10 AoE) | Multiple low-HP enemies, or supplement AoE turn |
| Poison Potion (6 Poison) | Long fights where Poison ticks add up (bosses) |
| Strength Potion (+2 Str) | Before a big attack turn, especially multi-hit cards |
| Flex Potion (+5 Str temp) | Same turn use only — Strength disappears at turn end |
| Weak Potion (3 Weak) | Reduce enemy damage for multiple turns — use early |
| Vulnerable Potion (3 Vuln) | Before big damage turns — 50% more Attack damage |
| Fear Potion (3 Vulnerable) | Same as Vulnerable Potion |

### Defensive Potions

| Potion | When to Use |
|--------|-------------|
| Block Potion (12 Block) | Fill block gap when cards can't cover incoming damage |
| Ancient Potion (1 Artifact) | Before enemy applies dangerous debuff |
| Regeneration Potion (5 Regen) | Boss fights — heals 5 per turn for many turns |
| Fairy in a Bottle | Auto-triggers on death — keep until then |
| Dexterity Potion (+2 Dex) | Before heavy block turns — adds to all Block cards |

### Utility Potions

| Potion | When to Use |
|--------|-------------|
| Energy Potion (+2 Energy) | Big turns where extra energy enables multiple key plays |
| Drawing Potion (+3 Draw) | When hand is weak and more options would help |
| Duplication Potion | Copy a high-value card (e.g., Impervious for 10 block, or a big attack) |
| Distilled Chaos | When hand is bad — plays random cards from draw pile |
| Entropic Brew | Fills empty potion slots — use when belt is empty |
| Liquid Bronze (3 Thorns) | Multi-attack enemies (Spider, multi-hit bosses) |
| Smoke Bomb | Escape from fights — last resort |

## Potion Decision Flowchart

```
1. Am I facing lethal this turn?
   YES -> Use defensive potion(s) to survive
   NO  -> Continue

2. Can a potion enable killing a dangerous enemy this turn?
   YES -> Use offensive potion to secure the kill
   NO  -> Continue

3. Is this a boss or elite fight?
   YES -> Consider using potions aggressively
   NO  -> Continue (save for harder fights)

4. Is my potion belt full and I might find better potions?
   YES -> Use weakest potion now
   NO  -> Save all potions
```

### Infinite-Specific Flowchart

```
If Infinite Ready:
  1. Is this the setup turn (playing Corruption/Dark Embrace/Powers)?
     YES -> Use Energy Potion + Drawing Potion NOW
     NO  -> Continue

  2. Am I taking lethal during setup (before loop active)?
     YES -> Use defensive potions to survive setup phase
     NO  -> Continue

  3. Is the Infinite loop already running?
     YES -> Potions are unnecessary. Save for next fight.
     NO  -> Consider potions to accelerate reaching loop state
```

## Potion Interaction Rules

- **Flex Potion** and similar "temporary" buffs: Strength is lost at end of turn. Play ALL attacks AFTER using Flex, not before.
- **Strength Potion** (permanent): Can be used anytime, but best before heavy attack turns.
- **Duplication Potion**: Duplicate the BEST card — check which card gives most value.
- **Energy Potion**: Use BEFORE playing cards to maximize options.
- **Drawing Potion**: Use EARLY in turn to get more card options. Useless at end of turn with 0 energy.

## CLI Syntax

### Basic Potion Usage

```bash
# Self-targeted potions (buffs, draw, energy):
./sts2 use_potion <potion_id>

# Enemy-targeted potions (damage, debuffs):
./sts2 use_potion <potion_id> --target <combat_id>

# Check potions[].target_type to know if --target is needed
```

### Selection Potions (NEW)

Some potions require selecting cards after use. When using these, the game enters `POTION_SELECTION` screen.

**Usage workflow:**
```bash
# 1. Use the potion
./sts2 use_potion LIQUID_MEMORIES

# 2. Check state - screen should be "POTION_SELECTION"
./sts2 state

# 3. Select card(s) from the available options
./sts2 potion_select_card <card_id>                    # Select 1 card
./sts2 potion_select_card STRIKE --nth 0 BASH --nth 1  # Select multiple

# 4. Or skip if allowed
./sts2 potion_select_skip                              # Skip selection

# 5. Verify return to combat
./sts2 state
```

**Selection potion types:**
- `ATTACK_POTION`, `SKILL_POTION`, `POWER_POTION` - Choose 1 of 3 cards
- `COLORLESS_POTION` - Choose 1 of 3 (can skip)
- `LIQUID_MEMORIES` - Choose 1 from discard pile
- `DROPLET_OF_PRECOGNITION` - Choose 1 from draw pile
- `GAMBLERS_BREW` - Choose 0-N from hand (multi-select, can skip)
- `ASHWATER` - Choose 1-N from hand (multi-select)
- `TOUCH_OF_INSANITY` - Choose 1 from hand

**Important:** Selection potions may fail or cause TUI glitches. If `use_potion` times out or screen shows `POTION_SELECTION` but selection fails, document in `.opencode/logs/cli-errors.md`.

## Related Skills

| Situation | Load Skill |
|-----------|------------|
| Planning turns with potions | `end-state-evaluation` |
| Full combat procedure | `combat-loop` |

## Game Knowledge References

| Need | Read File |
|------|-----------|
| Detailed potion effects | `docs/potions.md` |
