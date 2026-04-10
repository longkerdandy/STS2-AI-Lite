---
name: threat-assessment
description: Enemy intent analysis and threat prioritization for Slay the Spire 2 combat decisions
---

## Threat Assessment

Use this skill when **encountering unfamiliar enemies** or **complex multi-enemy situations** to analyze intents and prioritize threats.

## Intent Types

Enemies telegraph their next action through intents:

| Intent Type | Meaning | AI Response |
|-------------|---------|-------------|
| `Attack` | Will deal damage | Block or kill to prevent |
| `AttackBuff` | Damage + self-buff | High priority — growing threat |
| `AttackDebuff` | Damage + debuff player | High priority — compounds future turns |
| `AttackDefend` | Damage + gain block | Harder to kill this turn |
| `Buff` | Self-buff (Strength, etc.) | Kill before scaling gets out of hand |
| `Debuff` | Debuff player only | Moderate threat — Weak/Frail/Vulnerable |
| `Defend` | Gains block only | Low threat this turn — save damage |
| `DefendBuff` | Block + self-buff | Low immediate threat but growing |
| `Sleep` | Does nothing | Free turn to deal damage |
| `Stun` | Stunned, skips turn | Free turn |
| `Unknown` | Hidden intent | Assume moderate threat |

## Damage Calculation

```
For each alive enemy with Attack-type intents:
  per_hit_damage = intent.damage
  total_hits = intent.hits (default 1 if absent)
  raw_damage = per_hit_damage * total_hits

  # Check enemy powers
  If player has Vulnerable: effective_damage = raw_damage * 1.5
  If enemy has Weak power: effective_damage = raw_damage * 0.75
```

## Lethal Check Formula

```
total_incoming = sum of all enemy raw damage (after player Vulnerable, enemy Weak)
current_defense = player.block
survival_margin = player.hp + current_defense - total_incoming

If survival_margin <= 0: LETHAL THREAT — P0 priority
If survival_margin <= 10: HIGH RISK — strongly prefer blocking
If survival_margin > 10: SAFE — can play offensively
```

## Threat Priority Ranking

When multiple enemies are alive, rank them by threat:

**Tier 1 — Kill immediately if possible:**
- Enemy can be killed this turn AND is dealing significant damage
- Enemy with scaling buffs (Strength gain, Ritual, etc.) in early turns
- Minion-summoning enemies (kill before they flood the board)

**Tier 2 — High priority targets:**
- Highest damage-per-turn enemies
- Enemies about to use dangerous buffs (check `move_id` against known patterns)
- Enemies applying Frail/Weak/Vulnerable to player

**Tier 3 — Low priority:**
- Enemies with Defend/Block intents this turn (damage will be wasted on block)
- Low-damage enemies with no scaling
- Enemies that are sleeping or stunned

## Multi-Enemy Damage Assessment

```
Example: 3 enemies alive
  Jaw Worm: Attack 11 damage
  Louse A: Attack 6 damage
  Louse B: Buff (Curl Up)

Total incoming = 11 + 6 + 0 = 17
Player has 45 HP, 0 block
Survival margin = 45 + 0 - 17 = 28 (SAFE)

Decision: Play offensively. Consider killing Louse A (low HP) to remove 6 future damage.
```

## Power Threat Assessment

Watch for these dangerous enemy powers:

| Power | Effect | Urgency |
|-------|--------|---------|
| Ritual | Gains Strength each turn | HIGH — kill fast, scales exponentially |
| Metallicize | Gains block each turn | MEDIUM — harder to kill over time |
| Thorns | Deals damage when attacked | MEDIUM — avoid multi-hit attacks |
| Barricade | Block doesn't decay | LOW — enemy becomes tank |
| Strength | Increases all damage | HIGH — already scaling |
| Artifact | Blocks debuffs | MEDIUM — can't Weak/Vulnerable |
| Curiosity | Gains Strength when player plays Power | HIGH in power-heavy hands |
| Sharp Hide | Deals damage when player plays Attack | MEDIUM — factor into attack decisions |
| Angry | Gains Strength when damaged | MEDIUM — focus on one-shot kills |
| Enrage | Gains Strength when player plays Skill | MEDIUM — prefer attacks over skills |

## Infinite Deck Threat Adjustments

When run-state shows "Infinite Ready" or "Almost Ready", threat assessment changes:

### Reduced Urgency
- **Scaling enemies (Ritual, Strength gain)**: Less threatening — infinite loop will outscale any enemy once active. Focus on surviving setup turns.
- **High HP enemies**: No longer a problem — infinite deals unlimited damage. Don't waste potions on raw damage.
- **Multi-enemy encounters**: Actually easier with infinite (loop kills all simultaneously).

### Increased Urgency
- **High burst damage on turns 1-3**: Critical — you need 2-3 turns to set up the engine. Enemies that deal 30+ damage on turn 1 require potions or emergency block.
- **Debuff enemies (Frail, Weak)**: Frail reduces Feel No Pain's effective block. Weak reduces loop damage output. Prioritize killing debuffers.
- **Artifact on enemies**: Can't apply Weak/Vulnerable to reduce damage during setup. Pure block/HP to survive.

### Doormaker Boss (Act 3 — SPECIAL)

Doormaker has a mechanic that **prohibits card drawing** on certain turns. This directly counters infinite loops that depend on drawing cards.

**Threat level**: CRITICAL for infinite decks.

**Countermeasures:**
- Race to kill within turns 1-4 before the restriction activates
- Keep 0-cost cards in loop (Spite, Bloodletting, Pact's End) — playable without draw
- Pre-build massive block via Feel No Pain on the turn before restriction
- Use Impervious or block potions for the restricted turn
- Charon's Ashes provides passive damage even without playing cards

## Reading Enemy Patterns

For unfamiliar enemies, read `docs/enemies.md` to understand:
- HP range (how hard to kill)
- Move patterns (what comes after current intent)
- Special mechanics (phase changes, summons, etc.)

Key pattern to watch: Many enemies cycle through set move sequences. If you know the pattern, you can predict future turns and plan accordingly.

## Related Skills

| Situation | Load Skill |
|-----------|------------|
| Planning turns with threat info | `end-state-evaluation` |
| Full combat procedure | `combat-loop` |

## Game Knowledge References

| Need | Read File |
|------|-----------|
| Detailed enemy behavior | `docs/enemies.md` |
| Enemy HP and patterns | `docs/enemies.md` |
