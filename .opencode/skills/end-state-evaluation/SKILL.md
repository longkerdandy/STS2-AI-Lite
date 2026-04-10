---
name: end-state-evaluation
description: End-State Evaluation framework for optimal turn planning in Slay the Spire 2 combat — includes infinite loop sequence detection
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

1. **Infinite Loop Achieved** — If a sequence activates the infinite loop, it wins (guarantees kill of any enemy).
2. **Kill Achieved** — If any sequence kills an enemy, you MUST choose it. Kill = permanently remove future damage.
3. **Player Survival** — After enemy counter-attack, will you die? If yes, sequence is invalid.
4. **Net Damage Taken** — Among valid sequences, prefer lower total damage taken.
5. **Energy Usage** — Prefer sequences that use all energy (0 remaining).

**Hard Constraints (Never Violate):**
- If lethal incoming damage → must survive (block, potion, or kill)
- If kill possible → must kill
- If energy > 0 and playable cards exist → must continue playing
- If infinite loop achievable this turn → activate it (kills everything)

## Candidate Sequence Generation

### Step 1: Analyze Current State

```
- Player: hp, block, energy, powers (check for Corruption, Dark Embrace, Feel No Pain)
- Hand: all playable cards with costs, damage, effects
- Draw pile, Discard pile: remaining cards (for infinite assessment)
- Enemies: hp, block, intents, powers
- Potions: available (consider using in candidates)
- Infinite readiness: from run-state (Not Started / Building / Almost Ready / Infinite Ready)
```

### Step 2: Generate 2-5 Candidate Sequences

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

**Sequence E — Infinite Setup / Exhaust-to-Loop:** *(Only when readiness is "Almost Ready" or "Infinite Ready")*
- Play engine powers first (Dark Embrace, Feel No Pain, Corruption)
- Use energy generators (Offering, Bloodletting) for extra energy
- Exhaust non-loop cards (True Grit, Burning Pact, Second Wind, Brand)
- Assess: after all exhausts, is the active deck small enough to loop?
- If yes: this sequence wins (infinite = guaranteed kill)

For potion timing guidance, load `potion-timing` skill.

### Step 3: Simulate End-State for Each

For each sequence, mentally simulate:

```
1. Play all cards in order (track energy, block, enemy HP)
2. Account for exhaust triggers:
   - Feel No Pain active? Each exhaust → +3(4) block
   - Dark Embrace active? Each exhaust → +1 draw (may enable more plays)
   - Corruption active? All Skills cost 0 and exhaust
   - Charon's Ashes relic? Each exhaust → 3 AoE damage
3. Enemy turn: apply their intents (damage reduced by block)
4. Final state:
   - Player HP after damage?
   - Any enemies killed?
   - Energy remaining?
   - Block remaining (clears next turn)?
   - Active deck size (for infinite progress)?
```

**Example simulation (Normal):**
```
Sequence: Bash → Strike → Defend
Energy: 3 → 1 → 0 → 0
Enemy: 15HP → 7HP → 1HP → 1HP (alive)
Block: 0 → 0 → 0 → 5
Enemy attacks 8: 5 blocked, 3 HP lost
Final: Player -3 HP, enemy alive, energy 0
```

**Example simulation (Infinite Setup):**
```
Turn 2, powers active: Dark Embrace, Feel No Pain
Hand: True Grit, Burning Pact, Pommel Strike, Bloodletting, Shrug It Off, Strike
Energy: 3

Sequence E: Bloodletting (+2E, 5E total) → True Grit (1E, exhaust random → FNP +3 block, DE draw 1)
→ Burning Pact (1E, exhaust Strike → FNP +3 block, DE draw 1)
→ play drawn cards... continue exhausting
After: Active deck = Bloodletting, Pommel Strike, Shrug It Off + 1-2 others
Next turn: finish exhausting → loop begins
Score: 6+ block from FNP, 2 cards removed, progressing toward infinite
```

### Step 4: Apply Evaluation Priority

```
Sequence A: Kill enemy 1, -5 HP → Good
Sequence B: No kill, -0 HP → OK
Sequence C: No kill, -3 HP → Mediocre
Sequence E: No kill this turn, -5 HP, but infinite activates next turn → BEST
    (infinite = guaranteed kill of ALL enemies in future turns)
```

**Infinite priority rule:** An infinite setup sequence that activates the loop within 1-2 turns outranks a single kill, UNLESS:
- You will die before the loop activates (survival override)
- An enemy is about to do something catastrophic (massive scaling, summon, etc.)

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
- **Sequence with utility potion** — if extra energy/draw enables better plays (or enables loop)

For detailed potion timing, load `potion-timing` skill.

## Multi-Enemy Targeting

When multiple enemies, generate different targeting patterns:

**Candidate A:** All damage on Enemy 1
**Candidate B:** All damage on Enemy 2
**Candidate C:** Split damage (AoE or multi-target)

Let End-State Evaluation decide which is optimal.

**Don't pre-judge:**
- "Focus fire is always better" -- simulate and check
- "AoE is better with 3+ enemies" -- simulate and check
- If infinite loop is active, AoE from loop damage kills everything anyway

## Infinite-Specific Patterns

### Engine Setup Turn (Powers)
- **Sequence pattern:** Energy gen → Powers → Begin exhaust
- **Example:** Bloodletting → Dark Embrace → Feel No Pain → True Grit
- **Key:** Play powers BEFORE exhaust cards (so exhausts trigger draw/block)

### Mass Exhaust Turn
- **Sequence pattern:** Exhaust everything possible, let triggers refuel
- **Example:** Second Wind (exhaust all Skills, each triggers FNP block + DE draw)
- **With Corruption:** Every Skill costs 0 and exhausts → play ALL Skills first

### Loop Entry
- **Sequence pattern:** Exhaust remaining non-loop cards → begin cycling
- **Example:** Burning Pact (exhaust Iron Wave) → now active deck = Bloodletting + PS + Spite + SIO → LOOP
- **Key:** Verify net energy and net draw before committing

### Active Loop Execution
- **Sequence pattern:** Energy → Damage → Block → Draw (repeat)
- **Example:** Bloodletting → Pommel Strike → Spite → Shrug It Off → [cards return] → repeat
- **Key:** Always re-read state between cycles; don't assume hand contents

## Exhaust Build Patterns (Pre-Infinite)

### Exhaust for Value (Not Full Infinite)
- **Sequence pattern:** Exhaust card → triggers Feel No Pain (block) / Dark Embrace (draw)
- **Example:** True Grit (exhaust Defend) → +3 block from Feel No Pain + draw 1 from Dark Embrace
- **Use when:** "Building" or "Almost Ready" — get value from exhaust even without full loop

### Block from Exhaust
- **Sequence pattern:** Exhaust multiple cards → Feel No Pain stacks block → Body Slam (if in deck)
- **Example:** Second Wind (exhaust 3 Skills) → 15 block from SW + 9 from FNP → Body Slam for 24

## Other Archetype Patterns (Fallback)

### Strength Build
- **Sequence pattern:** Power first (Demon Form/Inflame) → multi-hit attacks
- **Example:** Inflame → Twin Strike → Whirlwind

### Block Build
- **Sequence pattern:** Build block → Body Slam (damage = block)
- **Example:** Defend + Shrug It Off → Body Slam

**Note:** These are patterns for generating candidates, not rules. Still evaluate via End-State.

## Common Mistakes to Avoid

### Greedy Efficiency
```
Wrong: "Strike has 6 damage/1 energy = 6 efficiency, better than Bash's 4"
Right: "Bash applies Vulnerable → future attacks deal +50%. Sequence: Bash → attacks = more total"
```

### Pre-Mature Defense
```
Wrong: "Enemy intends 8 damage, I must Defend"
Right: "If I kill enemy this turn, I take 0 future damage. Kill > Block"
```

### Energy Waste
```
Wrong: "End turn with 1 energy remaining, no good cards left"
Right: "Wait, I have a 0-cost card. Play it!"
```

### Fixed Play Order
```
Wrong: "Always buff before attacking"
Right: "Simulate both: buff→attack vs attack→buff. Which end-state is better?"
```

### Exhaust Too Slowly
```
Wrong: "I'll exhaust one card per turn with True Grit to be safe"
Right: "With Dark Embrace active, exhaust as many as possible — each exhaust draws a card to keep going"
```

### Ignoring Infinite Setup
```
Wrong: "I should play attacks for damage this turn" (while engine powers are in hand)
Right: "Spending 2 energy on Dark Embrace now = infinite damage in 2 turns. Setup first."
```

## Execution Flow

```
1. Get state (./sts2 state)
2. Check infinite readiness from run-state
3. Generate 2-5 candidate sequences (include infinite setup if applicable)
4. Simulate end-state for each (including exhaust triggers)
5. Apply Evaluation Priority (Infinite > Kill > Survival > Damage > Energy)
6. Select optimal sequence
7. Execute one card at a time
8. Confirm results, adjust if needed
9. End turn (verify energy = 0 or no playable cards)
   — OR if in infinite loop, keep playing until enemies die
10. Observe enemy actions
11. Repeat
```

## Quick Reference

| Priority | Criterion | Action |
|----------|-----------|--------|
| 1 | Infinite Loop Achieved | Activate loop — guarantees kill |
| 2 | Kill Achieved | Must choose if any sequence kills |
| 3 | Survival | After counter-attack, HP > 0 |
| 4 | Net Damage | Prefer less damage taken |
| 5 | Energy | Prefer 0 remaining energy |

## Related Skills

| Situation | Load Skill |
|-----------|------------|
| Unfamiliar enemy patterns | `threat-assessment` |
| Potion use timing | `potion-timing` |
| Full combat procedure | `combat-loop` |
