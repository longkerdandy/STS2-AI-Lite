---
name: targeting-priority
description: Multi-enemy targeting strategy for Slay the Spire 2 — focus-fire vs spread, minion handling, and kill thresholds
---

## Targeting Priority

When multiple enemies are alive, choose targets carefully. Wrong targeting can cost the fight.

### Core Targeting Rules

**Rule 1: Kill Threshold**

Before each attack, check if any enemy can be killed:

```
For each alive enemy:
  kill_damage_needed = enemy.hp + enemy.block
  can_kill = (available_damage >= kill_damage_needed)

If can_kill: strongly prefer killing that enemy
  - Removes all future damage from that enemy permanently
  - More valuable than spreading damage across multiple enemies
```

**Rule 2: Focus Fire**

In general, focus damage on one enemy at a time:
- Dealing 20 damage to one enemy is better than 10 to two enemies
- A dead enemy deals 0 future damage; a damaged enemy deals full damage
- Exception: AoE cards (Cleave, Whirlwind) naturally spread — use them for multi-enemy value

**Rule 3: Target Selection Priority**

When multiple enemies are alive and no kill is available:

1. **Highest damage enemy** — Remove the biggest threat first
2. **Scaling enemy** — Enemy with Ritual/Strength gain escalates over time; kill before it's too late
3. **Debuffer** — Enemy applying Frail/Weak/Vulnerable compounds future turns
4. **Buffer** — Enemy gaining block/buffs is annoying but less urgent
5. **Lowest HP** (if tied) — Closer to kill threshold

### Minion Strategy

Minions are summoned by a main enemy. Targeting rules differ:

**Kill minions first when:**
- Minions deal significant damage (e.g., Slavers — each hits hard)
- Main enemy is high HP and will take many turns to kill anyway
- Minions have dangerous abilities (debuffs, heals, buffs to boss)

**Ignore minions and kill boss when:**
- Minions respawn endlessly (killing them is wasted effort)
- Boss is near death (finish it to end combat)
- Minions deal trivial damage

**Key minion encounters:**
- Taskmaster + Slaves: Kill slaves first (high damage), boss summons more
- Gremlin Leader: Kill gremlins; leader summons more but gremlins hit hard
- Reptomancer: Daggers deal massive damage if left alive — kill daggers ASAP
- Orb Walkers: Minions buff the main enemy — kill minions to stop scaling

### AoE vs Single-Target Decision

**Prefer AoE (Cleave, Whirlwind, Immolate) when:**
- 3+ enemies alive
- Multiple enemies at low HP (AoE could multi-kill)
- All enemies are attacking (AoE removes total damage most efficiently)

**Prefer single-target when:**
- 2 enemies with one high-threat and one low-threat
- One enemy is close to death (finish it off)
- You need exact damage on a specific target

### AoE Efficiency Calculation

```
AoE value = damage * number_of_alive_enemies
Single value = damage to one target

Example:
  Cleave deals 8 to ALL enemies
  Strike deals 6 to ONE enemy
  3 enemies alive:
    Cleave total = 8 * 3 = 24 damage for 1 energy
    Strike total = 6 damage for 1 energy
  -> Cleave is 4x more efficient
```

### Vulnerable Target Priority

When choosing which enemy to apply Vulnerable to:
- Apply to the enemy you plan to focus-fire (50% more damage on all future attacks)
- Apply to the highest-HP enemy (more attacks = more bonus damage)
- Apply to enemies that will live multiple turns (1-turn kills don't benefit)
- AoE Vulnerable (Shockwave) is extremely valuable against multiple enemies

### Block-Aware Targeting

When enemies have block:
- Check `enemy.block` before attacking
- If enemy has 15 block and your attack deals 10, you deal 0 HP damage
- Sometimes it's better to attack a different enemy with no block
- Multi-hit attacks chip through block more efficiently (block absorbs per-hit)

```
Example:
  Enemy A: 10 HP, 15 block (needs 25 damage to kill)
  Enemy B: 10 HP, 0 block (needs 10 damage to kill)
  -> Attack Enemy B first (kill with less total damage)
```

### Target Selection Flowchart

```
1. Can any enemy be killed this turn?
   YES -> Kill it (prioritize highest-threat kill)
   NO  -> Continue

2. Is any enemy scaling (Ritual, Strength gain)?
   YES -> Focus damage on scaling enemy
   NO  -> Continue

3. Are 3+ enemies alive and AoE available?
   YES -> Consider AoE for efficiency
   NO  -> Continue

4. Default: Attack highest-damage enemy
   (check intents to see who hits hardest)
```
