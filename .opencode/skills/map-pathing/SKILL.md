---
name: map-pathing
description: Map node evaluation and path planning for Slay the Spire 2 — node type priority, risk assessment, and travelable node selection
---

# Map Pathing

Use this skill when the Game Master needs to choose a map node.

## Procedure

1. Read game state: `map.travelable_coords[]` and `map.nodes[]`
2. For each travelable coordinate, find the node type
3. Evaluate based on priority and current run state
4. Execute: `./sts2 choose_map_node <col> <row>`

## Node Type Priority

Priority depends on run phase and HP:

### Early Act (first 3-4 floors)
```
Priority: MONSTER > ELITE (if HP > 60%) > EVENT > SHOP > REST_SITE
Reasoning: Build deck quickly, get card rewards. Avoid elites if weak.
```

### Mid Act
```
Priority: ELITE (if HP > 50%) > MONSTER > EVENT > SHOP > REST_SITE
Reasoning: Elites give relics. Take fights for rewards.
```

### Pre-Boss (last 2 floors before boss)
```
Priority: REST_SITE > SHOP > EVENT > MONSTER > ELITE
Reasoning: Prepare for boss. Heal, upgrade, shop for key cards.
```

## HP Thresholds

| HP % | Adjustment |
|------|------------|
| > 70% | Follow standard priority |
| 50-70% | Avoid ELITE, prefer MONSTER |
| 30-50% | Prefer REST_SITE or EVENT |
| < 30% | Must REST_SITE if available |

## Path Planning

When multiple travelable nodes exist at the same priority:
- Prefer paths that lead to more diverse node types in subsequent rows
- Avoid paths that lead to consecutive elites (if HP is moderate)
- Consider which paths reach the shop before the boss

## Node Types Reference

| Type | Reward | Risk |
|------|--------|------|
| `MONSTER` | Card reward + gold | Low-moderate damage |
| `ELITE` | Card reward + gold + relic | High damage |
| `BOSS` | Relic selection | Very high damage |
| `SHOP` | Buy/remove cards | None |
| `REST_SITE` | Heal or upgrade | None |
| `TREASURE` | Free relic | None |
| `ANCIENT` | Ancient event | Varies |
| `UNKNOWN` | Random event | Varies |

## Output Format

```
[MAP Act 1 Floor 4: 3 travelable nodes. Choosing ELITE at (3,2) — HP 72/80 is healthy, need relic]
> ./sts2 choose_map_node 3 2
```
