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

## Core Principle: Survival First

**Ironclad's starting deck is weak.** Before the Infinite engine comes online, the deck has no scaling and struggles against elites. The pathing strategy reflects this:

- **Hallway fights are safe** — they give card rewards + gold with manageable HP loss
- **Shops and campfires are the most valuable nodes** — removal and upgrades directly advance the Infinite build
- **Elites are high-risk, often low-reward** — the relic is random and may be useless; the HP cost is steep; and the card reward may not be what you need. A single bad elite can cost you two campfire upgrades (one lost to healing, one lost to pathing away from a campfire).
- **Don't rush elites just for relics.** Two campfire upgrades are often worth more than a random relic.

## Node Type Priority

Priority depends on run phase, HP, **and Infinite Readiness**.

### Early Act (first 3-4 floors)
```
Priority: MONSTER > EVENT > SHOP > REST_SITE > ELITE
Reasoning: Build deck with safe hallway fights first. Get 3+ hallway fights
before even considering an elite. Gold from fights funds shop removal.
NEVER take an early elite — the starting deck cannot handle it cleanly.
```

### Mid Act (floors 5-7)
```
Priority: SHOP > REST_SITE > MONSTER > EVENT > ELITE (only if adjacent to campfire AND HP > 70%)
Reasoning: Shop for removal, campfire for upgrades. These directly build
the Infinite engine. Elites only when the path is safe (campfire before
AND after) and HP is high. Most of the time, skip elites entirely.
```

### Late Act (floors 8+, pre-boss)
```
Priority: REST_SITE > SHOP > ELITE (if deck is strong + HP > 60%) > EVENT > MONSTER
Reasoning: Prepare for boss. Heal, upgrade. If the deck has gotten strong
from card rewards and upgrades, a late elite is the safest time to take one
(your deck is at its strongest in the act). But only 0-2 elites per act total.
```

### Pre-Boss (last 1-2 floors)
```
Priority: REST_SITE > SHOP > EVENT > MONSTER > ELITE
Reasoning: Heal and prepare for boss. Never take an elite right before boss.
```

## Elite Rules (Critical)

Elites in STS2 hit much harder than STS1. Follow these rules strictly:

1. **Act 1 target: 0-1 elites.** Maybe 2 if the deck rolled exceptionally well early.
2. **Never take an elite before 3 hallway fights.** The starting deck cannot handle it.
3. **Campfire adjacency is required.** Only take an elite if there's a campfire/rest reachable before or after it on your path.
4. **Have an escape route.** When pathing, prefer forks where you CAN take an elite but don't HAVE to. Commit only when you're confident.
5. **Potions count.** A Vulnerability potion or Block potion can make an otherwise risky elite manageable — factor this in.
6. **Elite rewards are random.** Don't gamble HP on a fight that might give you a niche relic and a card you don't need.

## Infinite Readiness Adjustments

| Readiness | Pathing Adjustment |
|-----------|-------------------|
| **Not Started** | Maximum caution. Prioritize SHOP > MONSTER > REST_SITE. Take fights for card rewards and gold. Avoid elites unless very safe. |
| **Building** | Heavily favor SHOP nodes — card removal is critical. Take hallway fights for gold. Only take elites late in act with campfire adjacency. |
| **Almost Ready** | SHOP is #1 priority — one more removal might push to Infinite Ready. Avoid unnecessary fights that bloat the deck. |
| **Infinite Ready** | Elites become much safer — the engine provides reliable block and damage. Can take elites more aggressively. SHOP still valuable for further thinning. |

### Shop Seeking Rule

**Progressive Infinite depends heavily on card removal.** Actively seek SHOP nodes:
- In Act 1: Visit at least 1 shop (ideally 2) for Defend/Strike removal
- In Act 2: Visit every reachable shop — removal gets more expensive but is still top priority
- In Act 3: Shop visits are less critical if Infinite Ready, but still useful

When choosing between two equally-valued paths, **prefer the path that includes a SHOP or REST_SITE**.

## HP Thresholds

| HP % | Adjustment |
|------|------------|
| > 70% | Can consider elites (if late in act with campfire adjacency) |
| 50-70% | Avoid all elites. Prefer MONSTER, SHOP, or EVENT. |
| 30-50% | Prefer REST_SITE. Avoid all combat if possible. |
| < 30% | Must REST_SITE. If no rest available, take safest non-combat path. |

**Infinite Ready override**: When Infinite Ready, HP thresholds relax by one tier (e.g., consider elites at 50% instead of 70%) because the engine provides reliable block via Feel No Pain.

## Path Planning

When multiple travelable nodes exist at the same priority:
- **Prefer paths with SHOP + REST_SITE** access over elite-heavy paths
- **Prefer forks** that give you the option to take or dodge an elite later
- Avoid paths that force consecutive elites
- Consider total path value: MONSTER → SHOP → REST is almost always better than ELITE → MONSTER → MONSTER
- Gold availability matters: if you have 100+ gold, a SHOP path is very high value

## Node Types Reference

| Type | Reward | Risk | Infinite Value |
|------|--------|------|----------------|
| `MONSTER` | Card reward + gold | Low-moderate | Medium — gold for removal, card options |
| `ELITE` | Card reward + gold + relic | **High** | Low-Medium — random relic, HP cost |
| `BOSS` | Relic selection | Very high | Medium — mandatory, prepare well |
| `SHOP` | Buy/remove cards | None | **Very High** — removal is #1 priority |
| `REST_SITE` | Heal or upgrade | None | **Very High** — upgrades advance engine |
| `TREASURE` | Free relic | None | High — free value, no risk |
| `ANCIENT` | Ancient event | Varies | Medium |
| `UNKNOWN` | Random event | Varies | Medium — may offer removal or transforms |

## Output Format

```
[MAP Act 1 Floor 2: 3 travelable nodes. Readiness=Not Started. Choosing MONSTER at (1,2) — need hallway fights first, too early for elite]
> ./sts2 choose_map_node 1 2
```

```
[MAP Act 1 Floor 6: Readiness=Building, HP 65/80. Choosing SHOP at (2,3) — need removal, have 110g, skipping elite at (3,3)]
> ./sts2 choose_map_node 2 3
```

```
[MAP Act 2 Floor 8: Infinite Ready, HP 55/80. Choosing ELITE at (3,2) — engine online, can handle scaling fights]
> ./sts2 choose_map_node 3 2
```
