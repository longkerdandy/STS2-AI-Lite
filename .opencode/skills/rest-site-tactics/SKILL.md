---
name: rest-site-tactics
description: Rest site decision framework for Slay the Spire 2 — heal vs smith vs dig evaluation based on HP, deck state, infinite progress, and act progress
---

# Rest Site Tactics

Use this skill when the Deck-Building Agent enters a REST_SITE screen.

**Data source**: Upgrade priority tiers are defined in `docs/deck-building-framework.md`. Read it when evaluating SMITH targets.

## Procedure

1. Read game state: `rest_site.options[]` (available options and enabled status)
2. Read `run-state.md` for infinite readiness, HP context, deck state, key upgrades needed
3. Evaluate options using the decision framework below
4. Execute: `./sts2 choose_rest_option <option_id>`
5. If SMITH → GRID_CARD_SELECT → pick card to upgrade (see Upgrade Selection)
6. `./sts2 proceed` when `rest_site.can_proceed` is true

## Decision Framework

### Primary Decision: HEAL vs SMITH

This is the most common choice. Use this matrix:

| HP % | Upgrade Target Available? | Next Node | Decision |
|------|--------------------------|-----------|----------|
| < 40% | Any | Any | **HEAL** |
| 40–60% | Tier 1 upgrade | Non-boss | **SMITH** (Tier 1 = game-changing for infinite) |
| 40–60% | Tier 2/3 or none | Any | **HEAL** |
| 40–60% | Any | Boss/Elite | **HEAL** (need HP for big fight) |
| 60–75% | Tier 1 or Tier 2 | Any | **SMITH** |
| 60–75% | Tier 3 or none | Any | **HEAL** (marginal upgrade not worth it) |
| > 75% | Any upgrade target | Any | **SMITH** |
| > 75% | No upgrade target | Any | Consider DIG or other options |

### DIG (gain random relic)

Choose DIG when:
- HP > 70%
- No Tier 1/2 upgrade target available
- Shovel relic is owned (required for DIG)
- Risk is acceptable (random relic could be Velvet Choker — bad for infinite)

### LIFT (gain Strength)

Choose LIFT when:
- HP > 60%
- Girya relic is owned (required for LIFT)
- Infinite is NOT ready (Strength less valuable once looping)
- Uses remaining (max 3)

### Other Options (MEND, HATCH, COOK, CLONE)

Evaluate based on the option description in game state. Generally:
- **MEND**: Alternative healing, use like HEAL
- **COOK**: Meat Cleaver relic option, evaluate description
- **CLONE**: Pael's Growth option — duplicate a key infinite component (S-tier if duplicating Bloodletting, Pommel Strike, etc.)
- **HATCH**: Egg-related, evaluate description

## Upgrade Selection (SMITH → GRID_CARD_SELECT)

When SMITH is chosen, use the **Upgrade Priority** from `docs/deck-building-framework.md`:

### Selection Procedure (Infinite-Focused)

1. Read `grid_card_select.cards[]` for available upgrade targets
2. Look up each card in the framework's Upgrade Priority tiers
3. Pick the highest-tier card available:
   - **Tier 1** (game-changing for infinite): Pommel Strike (draw +1), Dark Embrace (cost -1), Corruption (cost -1), Offering (draw +2), Bloodletting (energy +1), Feel No Pain (block +1)
   - **Tier 2** (strong): Burning Pact (draw +1), Second Wind (block +2/card), Shrug It Off (block +3), Havoc (cost→0), Stoke (cost→0), Spite (dmg +3), Impervious (block +10), Brand (Str +1), Bash (Vuln +1), True Grit (block +2)
   - **Tier 3** (decent): Most other attacks/skills with meaningful stat boosts
4. **Never upgrade**: Strike, Defend (remove them instead)
5. If no good target exists, use `./sts2 grid_select_skip` (if cancelable)

**Priority within same tier**: Upgrade the card you play MOST frequently in the loop. Pommel Strike+ (draw 2) is usually the single best upgrade in the game for infinite builds.

```
[SMITH: Upgrading Pommel Strike (draw 1→2) — doubles cycle speed in infinite loop]
> ./sts2 grid_select_card POMMEL_STRIKE
```

## Infinite Readiness Adjustments

| Readiness | SMITH Value | HEAL Threshold | Notes |
|-----------|-------------|----------------|-------|
| Not Started | Normal — upgrade strong standalone cards | < 50% | Standard play |
| Building | High — upgrade infinite components | < 45% | Prioritize Tier 1 upgrades for loop pieces |
| Almost Ready | Very High — loop speed matters | < 40% | Pommel Strike+, Bloodletting+ are critical |
| Infinite Ready | Medium — loop already works | < 50% | Upgrades improve loop but aren't critical |

## Output Format

```
[REST_SITE: HP 38/80 (47%), Pommel Strike available (Tier 1) — but next is Boss, choosing HEAL]
> ./sts2 choose_rest_option HEAL
> ./sts2 proceed

[REST_SITE: HP 64/80 (80%), Dark Embrace available for upgrade (Tier 1) — choosing SMITH]
> ./sts2 choose_rest_option SMITH
> ./sts2 grid_select_card DARK_EMBRACE
> ./sts2 proceed
```

## Related Skills

| Situation | Load Skill |
|-----------|------------|
| Upgrade priority data | Read `docs/deck-building-framework.md` |
| Update run state after upgrade | `run-state-management` |
| Infinite build strategy | Read `docs/builds.md` |
