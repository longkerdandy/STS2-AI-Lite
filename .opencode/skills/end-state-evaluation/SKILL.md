---
name: end-state-evaluation
description: End-State Evaluation framework for optimal turn planning in Slay the Spire 2 combat
---

# End-State Evaluation

Use this skill when **planning a turn** — generate candidate play sequences, simulate their end-states, and select the optimal sequence.

## Core Principle

Instead of picking the "best" card one at a time, generate 2-4 candidate play sequences, simulate the end-state of each, and select the sequence that maximizes the outcome.

**Why this works:**
- Single-card efficiency can mislead
- Sequence matters: buff → attack differs from attack → buff
- End-state reveals true value: kill, survival, net damage taken

## Evaluation Priority (Strict Order)

When comparing candidate sequences, score by:

1. **Kill Achieved** — If any sequence kills an enemy, you MUST choose it. Kill = permanently remove future damage.
2. **Player Survival** — After enemy counter-attack, will you die? If yes, sequence is invalid.
3. **Net Damage Taken** — Among valid sequences, prefer lower total damage taken.
4. **Energy Usage** — Prefer sequences that use all energy (0 remaining).

**Hard Constraints (Never Violate):**
- If lethal incoming damage → must survive (block, potion, or kill)
- If kill possible → must kill
- If energy > 0 and playable cards exist → must continue playing

## Candidate Sequence Generation

### Step 1: Analyze Current State

```
- Player: hp, block, energy, powers
- Hand: all playable cards with costs, damage, effects
- Enemies: hp, block, intents, powers
- Potions: available (consider using in candidates)
```

### Step 2: Generate 2-4 Candidate Sequences

**Sequence A — Kill Focus:**
- All damage on lowest-HP enemy
- Ignore defense unless lethal incoming
- Include potion if enables kill

**Sequence B — Survival Focus:**
- Prioritize block cards
- Apply Weak/Vulnerable to reduce damage
- Use defensive potion if needed

**Sequence C — Balanced:**
- Mix of damage and block
- Consider buffs → attacks order
- Include 0-cost cards

**Sequence D — Potion Variation:**
- Same as A/B/C but with potion use
- Compare with/without potion

For potion timing guidance, load `potion-timing` skill.

### Step 3: Simulate End-State for Each

For each sequence, mentally simulate:

```
1. Play all cards in order (track energy, block, enemy HP)
2. Enemy turn: apply their intents (damage reduced by block)
3. Final state:
   - Player HP after damage?
   - Any enemies killed?
   - Energy remaining?
   - Block remaining (clears next turn)?
```

**Example simulation:**
```
Sequence: Bash → Strike → Defend
Energy: 3 → 1 → 0 → 0
Enemy: 15HP → 7HP → 1HP → 1HP (alive)
Block: 0 → 0 → 0 → 5
Enemy attacks 8: 5 blocked, 3 HP lost
Final: Player -3 HP, enemy alive, energy 0

Sequence: Bash → Strike (energy 3→1→0)
Enemy: 15 → 7 (Vulnerable applied)
Missing 1HP kill... add 0-cost card if available
```

### Step 4: Apply Evaluation Priority

```
Sequence A: No kill, -3 HP, energy 0 → Score: survival OK, no kill
Sequence B: No kill, -8 HP, energy 0 → Score: worse survival
Sequence C: KILL, -8 HP, energy 0 → Score: KILL ACHIEVED! (must pick)
Sequence D: KILL, -3 HP, energy 0 → Score: kill + better survival (best!)
```

**Decision:** Choose Sequence D (kill with potion, least damage taken)

## Special Constraints

### X-Cost Cards
- Must be last in any sequence (uses all remaining energy)
- Whirlwind, Tempest, Reinforced Body

### Ethereal Cards
- Must be played or lost at end of turn
- Include in all sequences

### Retained Cards
- Can be left unplayed (stay for next turn)
- Consider: play now vs save for better turn

### Potions in Sequences

Generate candidate sequences with AND without potions:
- **Sequence without potions** — baseline for comparison
- **Sequence with offensive potion** — if it enables kill or significant damage
- **Sequence with defensive potion** — if survival is threatened
- **Sequence with utility potion** — if extra energy/draw enables better plays

For detailed potion timing, load `potion-timing` skill.

## Multi-Enemy Targeting

When multiple enemies, generate different targeting patterns:

**Candidate A:** All damage on Enemy 1
**Candidate B:** All damage on Enemy 2
**Candidate C:** Split damage (AoE or multi-target)

Let End-State Evaluation decide which is optimal.

**Don't pre-judge:**
- "Focus fire is always better" ❌
- "AoE is better with 3+ enemies" ❌
- Simulate and let results speak ✅

## Archetype Patterns (for Candidate Ideas)

### Exhaust Build
- **Sequence pattern:** Exhaust card → triggers Feel No Pain (block) / Dark Embrace (draw)
- **Example:** True Grit (exhaust Defend) → +3 block from Feel No Pain

### Block Build
- **Sequence pattern:** Build block → Entrench (double) → Body Slam (damage = block)
- **Example:** Defend + Shrug It Off → Entrench → Body Slam

### Strength Build
- **Sequence pattern:** Power first (Demon Form/Inflame) → multi-hit attacks
- **Example:** Inflame → Twin Strike → Heavy Blade

**Note:** These are patterns for generating candidates, not rules. Still evaluate via End-State.

## Common Mistakes to Avoid

### ❌ Greedy Efficiency
```
Wrong: "Strike has 6 damage/1 energy = 6 efficiency, better than Bash's 4"
Right: "Bash applies Vulnerable → future attacks deal +50%. Sequence: Bash → Twin Strike = 8+7+7=22 damage"
```

### ❌ Pre-Mature Defense
```
Wrong: "Enemy intends 8 damage, I must Defend"
Right: "If I kill enemy this turn, I take 0 future damage. Kill > Block"
```

### ❌ Energy Waste
```
Wrong: "End turn with 1 energy remaining, no good cards left"
Right: "Wait, I have a 0-cost Shiv. Play it!"
```

### ❌ Fixed Play Order
```
Wrong: "Always buff before attacking"
Right: "Simulate both: buff→attack vs attack→buff. Which end-state is better?"
```

## Execution Flow

```
1. Get state (./sts2 state)
2. Generate 2-4 candidate sequences
3. Simulate end-state for each
4. Apply Evaluation Priority
5. Select optimal sequence
6. Execute one card at a time
7. Confirm results, adjust if needed
8. End turn (verify energy = 0 or no playable cards)
9. Observe enemy actions
10. Repeat
```

## Quick Reference

| Priority | Criterion | Action |
|----------|-----------|--------|
| 1 | Kill Achieved | Must choose if any sequence kills |
| 2 | Survival | After counter-attack, HP > 0 |
| 3 | Net Damage | Prefer less damage taken |
| 4 | Energy | Prefer 0 remaining energy |

## Related Skills

| Situation | Load Skill |
|-----------|------------|
| Unfamiliar enemy patterns | `threat-assessment` |
| Potion use timing | `potion-timing` |
| Full combat procedure | `combat-loop` |
