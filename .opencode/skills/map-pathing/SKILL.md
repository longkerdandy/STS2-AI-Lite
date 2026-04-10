---
name: map-pathing
description: Map node evaluation and path planning for Slay the Spire 2 — node type priority, risk assessment, and travelable node selection
---

# Map Pathing

Use this skill when the Game Master needs to choose a map node.

## Procedure

1. Read game state: `map.travelable_coords[]` and `map.nodes[]`
2. Read `run-state.md` for Infinite Readiness level
3. For each travelable coordinate, find the node type
4. Evaluate based on priority, HP, and Infinite Readiness
5. Execute: `./sts2 choose_map_node <col> <row>`

## Node Type Priority

Priority depends on run phase, HP, **and Infinite Readiness**.

### Early Act (first 3-4 floors)
```
Priority: MONSTER > ELITE (if HP > 60%) > EVENT > SHOP > REST_SITE
Reasoning: Build deck quickly, get card rewards and gold for shop removal.
```

### Mid Act
```
Priority: ELITE (if HP > 50%) > MONSTER > SHOP > EVENT > REST_SITE
Reasoning: Elites give relics. Shop visits enable card removal (critical for Infinite).
```

### Pre-Boss (last 2 floors before boss)
```
Priority: REST_SITE > SHOP > EVENT > MONSTER > ELITE
Reasoning: Prepare for boss. Heal, upgrade key Infinite components, shop for removal.
```

## Infinite Readiness Adjustments

| Readiness | Pathing Adjustment |
|-----------|-------------------|
| **Not Started** | Standard priority. Take fights for card rewards. Seek shops for removal. |
| **Building** | Favor SHOP nodes — card removal is critical. Take fights only when healthy. |
| **Almost Ready** | SHOP is highest non-rest priority — removal pushes deck to Infinite Ready. Avoid unnecessary fights that add bloat cards (event curses, etc.). |
| **Infinite Ready** | Elites and Bosses are safer — Infinite engine handles long fights. SHOP still valuable for further thinning. Skip card rewards from fights (Deck-Building Agent handles this). |

### Shop Seeking Rule

**Progressive Infinite depends heavily on card removal.** Actively seek SHOP nodes:
- In Act 1: Visit at least 1 shop (ideally 2) for Defend/Strike removal
- In Act 2: Visit every reachable shop — removal gets more expensive but is still top priority
- In Act 3: Shop visits are less critical if Infinite Ready, but still useful

When choosing between two equally-valued paths, **prefer the path that includes a SHOP**.

## HP Thresholds

| HP % | Adjustment |
|------|------------|
| > 70% | Follow standard priority |
| 50-70% | Avoid ELITE, prefer MONSTER |
| 30-50% | Prefer REST_SITE or EVENT |
| < 30% | Must REST_SITE if available |

**Infinite Ready override**: When Infinite Ready, HP thresholds can be relaxed by one tier (e.g., take ELITE at 50% instead of 70%) because the Infinite engine provides reliable sustain through Feel No Pain block generation.

## Path Planning

When multiple travelable nodes exist at the same priority:
- **Prefer paths that reach a SHOP** before the boss
- Prefer paths that lead to more diverse node types in subsequent rows
- Avoid paths that lead to consecutive elites (unless Infinite Ready)
- Consider total path value: a MONSTER → SHOP → REST path is often better than ELITE → MONSTER → MONSTER

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
[MAP Act 1 Floor 4: 3 travelable nodes. Readiness=Building. Choosing SHOP at (2,3) — need removal, 120g available]
> ./sts2 choose_map_node 2 3
```

```
[MAP Act 2 Floor 8: Infinite Ready, HP 45/80. Choosing ELITE at (3,2) — engine handles scaling fights]
> ./sts2 choose_map_node 3 2
```
