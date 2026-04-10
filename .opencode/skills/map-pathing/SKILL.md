---
name: map-pathing
description: Map node evaluation and path planning for Slay the Spire 2 — full-act path computation, node type priority, risk assessment, and travelable node selection
---

# Map Pathing

Use this skill when the Game Master needs to choose a map node.

## Architecture: Full-Act Path Planning

**Do NOT make greedy per-node decisions.** Instead, compute the optimal path for the ENTIRE act upfront, then follow it step by step.

### When to Plan
- **First MAP screen of an act** (when `current_coord` is null or first floor)
- **Re-plan triggers**: HP drops below 30%, Infinite Readiness level changes, planned path becomes invalid

### When to Follow
- **Subsequent MAP screens**: Look up the pre-computed path and pick the next node from `travelable_coords` that matches the plan.

## Procedure

### Step 1: Compute Full Path (first MAP of act)

```
1. Run `./sts2 state`, read `map.nodes[]` and `map.travelable_coords[]`
2. Read `run-state.md` for Infinite Readiness level and HP
3. Build graph from nodes[]:
   - Each node has {col, row, type, state, children[], parents[]}
   - children[] gives edges to next-row nodes
4. Enumerate ALL possible paths from travelable starting nodes to BOSS
5. Score each path using the scoring function below
6. Select the highest-scoring path
7. Store the planned path in run-state.md as: Planned Path: [(col,row), (col,row), ...]
8. Execute first step: ./sts2 choose_map_node <col> <row>
```

### Step 2: Follow Path (subsequent MAPs)

```
1. Run `./sts2 state`, read `map.travelable_coords[]`
2. Read `run-state.md` for Planned Path
3. Find the next node in Planned Path that appears in travelable_coords
4. Check re-plan triggers (HP, readiness change) — if triggered, go to Step 1
5. Execute: ./sts2 choose_map_node <col> <row>
```

## Path Scoring Function

Score each complete path (list of nodes from start to boss) by summing node scores.

### Base Node Scores

| Node Type | Base Score | Rationale |
|-----------|-----------|-----------|
| `SHOP` | **+30** | Card removal is #1 priority for Infinite |
| `REST_SITE` | **+25** | Heal or upgrade — both critical |
| `TREASURE` | **+20** | Free relic, zero risk |
| `MONSTER` | **+15** | Card reward + gold, manageable risk |
| `UNKNOWN` | **+12** | May offer removal/transform, some risk |
| `ANCIENT` | **+10** | Ancient event, varies |
| `ELITE` | **-5** | High risk, random reward. Negative by default. |
| `BOSS` | **0** | Mandatory, no choice |

### Modifier Rules

Apply these modifiers ON TOP of base scores:

**Elite Modifiers** (can make elites positive or more negative):

| Condition | Modifier | Explanation |
|-----------|----------|-------------|
| Elite has REST_SITE within 2 steps before AND after | +15 | Campfire adjacency makes elite safe |
| Elite is in late act (row > 60% of total rows) | +10 | Deck is stronger later in the act |
| Elite is in early act (row < 40% of total rows) | -15 | Starting deck can't handle early elites |
| Multiple elites on same path (2nd+) | -10 each | Cumulative HP drain is dangerous |
| Infinite Ready | +20 | Engine handles long fights reliably |
| HP < 50% at planning time | -20 | Too risky when already low |

**Shop Modifier**:

| Condition | Modifier |
|-----------|----------|
| Player gold > 100 | +5 (per shop) |
| Readiness = Almost Ready | +10 (per shop, removal might complete the build) |

**Rest Site Modifier**:

| Condition | Modifier |
|-----------|----------|
| HP < 60% | +10 (healing value is high) |
| Have upgradable Infinite component | +5 (upgrade value) |

### Scoring Example

```
Path A: MONSTER → MONSTER → SHOP → REST_SITE → MONSTER → ELITE → REST_SITE → BOSS
Scores:  15     + 15     + 30   + 25        + 15     + (-5+15+10) + 25   + 0 = 145
(Elite has campfire before+after, late act)

Path B: MONSTER → ELITE → MONSTER → MONSTER → SHOP → MONSTER → EVENT → BOSS
Scores:  15     + (-5-15) + 15   + 15       + 30   + 15     + 12   + 0 = 82
(Elite is early, no campfire before)

→ Choose Path A (145 > 82)
```

## Core Pathing Principles

### Survival First
**Ironclad's starting deck is weak.** Before the Infinite engine comes online, the deck has no scaling and struggles against elites.

- Hallway fights are safe — they give card rewards + gold with manageable HP loss
- Shops and campfires are the highest-value nodes — removal and upgrades directly advance the Infinite build
- Elites are high-risk, often low-reward — the relic is random; the HP cost is steep; a bad elite can cost you two campfire upgrades
- **Don't rush elites.** Two campfire upgrades are often worth more than a random relic.

### Elite Rules
1. **Act 1 target: 0-1 elites.** Maybe 2 if the deck rolled exceptionally well.
2. **Never take an elite before 3 hallway fights.** The starting deck cannot handle it.
3. **Campfire adjacency required.** Only take an elite if the path has a rest site reachable within 1-2 steps before or after.
4. **Prefer forks.** When the graph has branching, prefer paths where you CAN take an elite but don't HAVE to — decide later based on actual deck state.
5. **Potions count.** A Vulnerability or Block potion can make a risky elite manageable.

### Infinite Readiness Adjustments

| Readiness | Pathing Adjustment |
|-----------|-------------------|
| **Not Started** | Maximum caution. SHOP > MONSTER > REST_SITE. Avoid elites. |
| **Building** | Heavily favor SHOP — removal is critical. Only take elites late with campfire adjacency. |
| **Almost Ready** | SHOP is #1 — one more removal might complete the build. Avoid fights that bloat the deck. |
| **Infinite Ready** | Elites become safe — engine provides reliable block/damage. Take elites aggressively for relics. |

### Shop Seeking Rule
**Progressive Infinite depends heavily on card removal.** Actively seek paths with SHOP nodes:
- Act 1: At least 1 shop (ideally 2) for Defend/Strike removal
- Act 2: Visit every reachable shop — removal is still top priority
- Act 3: Less critical if Infinite Ready, but still useful

## HP Thresholds (for re-planning)

| HP % | Action |
|------|--------|
| > 70% | Follow plan. Can consider elites per plan. |
| 50-70% | If plan includes elite, re-evaluate. May re-plan to safer route. |
| 30-50% | **Re-plan.** Prioritize REST_SITE. Remove elites from path. |
| < 30% | **Must REST_SITE.** Re-plan to safest available path. |

## Re-Plan Triggers

Re-compute the full path if any of these occur:
1. **HP drops below 30%** — need to prioritize healing
2. **Infinite Readiness level changes** — adjusts elite risk tolerance
3. **Planned node becomes untravelable** — map state changed unexpectedly
4. **Exceptional card/relic acquired** — deck is suddenly much stronger, can handle more risk

## Path Storage in run-state.md

After computing, store the path:
```
## Map Plan
Planned Path: (1,0) → (2,1) → (2,2) → (1,3) → (2,4) → (2,5) → (1,6) → BOSS
Path Score: 145
Plan Reason: 2 shops, 2 campfires, 1 late elite with campfire adjacency, 0 early elites
```

## Node Types Reference

| Type | Reward | Risk | Infinite Value |
|------|--------|------|----------------|
| `MONSTER` | Card reward + gold | Low-moderate | Medium — gold for removal, card options |
| `ELITE` | Card reward + gold + relic | **High** | Low pre-engine, High post-engine |
| `BOSS` | Relic selection | Very high | Mandatory |
| `SHOP` | Buy/remove cards | None | **Very High** — removal is #1 priority |
| `REST_SITE` | Heal or upgrade | None | **Very High** — upgrades advance engine |
| `TREASURE` | Free relic | None | High — free value, no risk |
| `ANCIENT` | Ancient event | Varies | Medium |
| `UNKNOWN` | Random event | Varies | Medium — may offer removal/transforms |

## Output Format

### Path Planning (first MAP)
```
[MAP Act 1: Planning full path. 4 possible routes to boss.
 Best path (score 145): MONSTER→MONSTER→SHOP→REST→MONSTER→ELITE→REST→BOSS
 2 shops, 2 campfires, 1 late elite with adjacency. Starting with MONSTER at (1,0)]
> ./sts2 choose_map_node 1 0
```

### Path Following (subsequent MAPs)
```
[MAP Act 1 Floor 3: Following plan. Next node: SHOP at (2,2). Readiness=Building, HP 68/80]
> ./sts2 choose_map_node 2 2
```

### Re-Planning
```
[MAP Act 1 Floor 5: HP dropped to 28/80 — re-planning. Removing elite from path.
 New path (score 120): ...→REST→MONSTER→SHOP→REST→BOSS. Next: REST at (1,4)]
> ./sts2 choose_map_node 1 4
```
