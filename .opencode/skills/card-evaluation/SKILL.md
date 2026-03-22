---
name: card-evaluation
description: Card play order optimization and energy efficiency analysis for Slay the Spire 2 hand evaluation
---

## Card Evaluation

Optimize which cards to play and in what order for maximum turn value.

### Energy Efficiency

Calculate value-per-energy for each playable card:

```
For Attack cards:
  efficiency = card.damage / card.cost
  (0-cost attacks have infinite efficiency — always play if beneficial)

For Block cards:
  efficiency = card.block / card.cost
  (compare against incoming damage — wasted block is wasted energy)

For Power cards:
  efficiency = long-term value (hard to quantify, but generally high)
  (play early in combat for maximum benefit)
```

### Play Order Rules

The order you play cards matters. Follow these rules:

**1. Buffs before attacks**
- Play Strength-granting cards (Inflame, Spot Weakness) BEFORE attack cards
- Play Vulnerable-applying cards (Bash, Uppercut) BEFORE other attacks
- Play Weak-applying cards BEFORE the enemy attacks (end of turn)

**2. Draw cards first**
- Play draw cards (Battle Trance, Offering, Shrug It Off) early to see more options
- Exception: Don't draw if hand is already full (10 cards) — draws are wasted

**3. 0-cost cards are free value**
- Always play 0-cost cards unless they have a negative effect
- Flash of Steel, Anger (0-cost damage + draw/copy) are always worth playing
- Exception: Exhaust cards — only exhaust if the card is bad for the deck

**4. Exhaust cards situationally**
- True Grit, Fiend Fire, Second Wind exhaust cards — plan which cards to lose
- Exhaust Strikes and Defends in late game when better cards are available
- Never exhaust your only block card if facing lethal

**5. X-cost cards last**
- Cards with X cost (Whirlwind, etc.) spend all remaining energy
- Play all other cards first, then use X-cost with leftover energy

**6. Retain cards for next turn**
- Cards with Retain keyword stay in hand
- If you can't use a good Retain card efficiently this turn, save it

### Card Type Priority by Situation

**When facing lethal (P0):**
1. Block cards (Defend, Shrug It Off, Iron Wave, etc.)
2. Weak-applying cards (reduce incoming damage by 25%)
3. Kill cards (if killing an enemy removes enough damage)
4. Defensive potions

**When enemy is low HP (P1):**
1. Exact-kill attacks (don't overkill — waste of damage)
2. Multi-hit attacks for efficiency (Sword Boomerang, Twin Strike)
3. AoE for multiple low-HP enemies (Cleave, Whirlwind)

**When safe to attack (P2):**
1. Power cards (Demon Form, Inflame, Combust — long-term scaling)
2. Vulnerability application (50% more damage from attacks)
3. High damage-per-energy attacks
4. Strength-granting effects

**When nothing good to play (P3):**
1. 0-cost cards for free value
2. Exhaust weak cards (True Grit on Strikes)
3. Play Defend even if not needed (some relics trigger on block)

### Keyword Quick Reference

| Keyword | Effect | Decision Impact |
|---------|--------|----------------|
| Exhaust | Removed from combat after play | Permanent — consider carefully |
| Ethereal | Exhausted if in hand at end of turn | Must play or lose it |
| Innate | Drawn on turn 1 | No in-combat decision |
| Retain | Stays in hand next turn | Can save for better turn |
| Unplayable | Cannot be played | Skip — sometimes exhaustible |
| X Cost | Uses all remaining energy | Play last |

### Ironclad Archetype Patterns

Recognize the deck's archetype and play accordingly:

**Strength Build** (Demon Form, Inflame, Heavy Blade, Limit Break):
- Prioritize playing Strength-granting powers early
- Heavy Blade and multi-hit attacks scale with Strength
- Spot Weakness on attacking enemies for free Strength

**Exhaust Build** (Feel No Pain, Dark Embrace, Corruption, Sentinel):
- Exhaust aggressively for block (Feel No Pain) and draw (Dark Embrace)
- Corruption makes all Skills free but Exhausted — massive tempo
- Sentinel gives energy when Exhausted

**Block Build** (Barricade, Body Slam, Entrench, Impervious):
- Stack block across turns (Barricade prevents decay)
- Entrench doubles current block
- Body Slam deals damage equal to block — play after blocking

**Self-Damage Build** (Rupture, Brutality, Combust, Offering):
- Taking self-damage grants Strength (Rupture)
- Manage HP carefully — don't kill yourself
- Reaper heals based on damage dealt — combo with high Strength

### Hand Evaluation Template

For each turn, quickly assess:

```
1. Total energy available: [energy]
2. Playable cards: [list cards where can_play == true]
3. Total incoming damage: [calculated]
4. Block needed: [incoming - current_block, min 0]
5. Block available in hand: [sum of block values]
6. Damage available in hand: [sum of damage values]
7. Survival plan: [which cards to block with]
8. Offense plan: [which cards to attack with]
9. Leftover energy plan: [what to do with remaining energy]
```
