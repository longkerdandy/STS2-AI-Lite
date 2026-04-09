---
name: rest-site-tactics
description: Rest site decision framework for Slay the Spire 2 — heal vs smith vs dig evaluation based on HP, deck state, and act progress
---

# Rest Site Tactics

Use this skill when the Deck-Building Agent enters a REST_SITE screen.

**Data source**: Upgrade priority tiers are defined in `docs/deck-building-framework.md`. Read it when evaluating SMITH targets.

## Procedure

1. Read game state: `rest_site.options[]` (available options and enabled status)
2. Read `run-state.md` for current build, HP context, deck state, weaknesses
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
| 40–60% | Tier 1 upgrade | Non-boss | **SMITH** (upgrade is game-changing) |
| 40–60% | Tier 2/3 or none | Any | **HEAL** |
| 40–60% | Any | Boss/Elite | **HEAL** (need HP for big fight) |
| 60–75% | Tier 1 or Tier 2 | Any | **SMITH** |
| 60–75% | Tier 3 or none | Any | **HEAL** (marginal upgrade not worth it) |
| > 75% | Any upgrade target | Any | **SMITH** |
| > 75% | No upgrade target | Any | Consider DIG or other options |

**Upgrade Tier definitions**: See `docs/deck-building-framework.md` → Upgrade Priority section.

### DIG (gain random relic)

Choose DIG when:
- HP > 70%
- No Tier 1/2 upgrade target available
- Shovel relic is owned (required for DIG)
- Risk is acceptable (random relic could be bad)

### LIFT (gain Strength)

Choose LIFT when:
- HP > 60%
- Girya relic is owned (required for LIFT)
- Build benefits from Strength (Strength or multi-hit build)
- Uses remaining (max 3)

### Other Options (MEND, HATCH, COOK, CLONE)

Evaluate based on the option description in game state. Generally:
- **MEND**: Alternative healing, use like HEAL
- **COOK**: Meat Cleaver relic option, evaluate description
- **CLONE**: Pael's Growth option, duplicate a key card
- **HATCH**: Egg-related, evaluate description

## Upgrade Selection (SMITH → GRID_CARD_SELECT)

When SMITH is chosen, use the **Upgrade Priority** from `docs/deck-building-framework.md`:

### Selection Procedure

1. Read `grid_card_select.cards[]` for available upgrade targets
2. Look up each card in the framework's Upgrade Priority tiers
3. Pick the highest-tier card available:
   - **Tier 1** (game-changing): Bash, Body Slam, Barricade, Corruption, Dark Embrace, Rupture, Demon Form
   - **Tier 2** (strong): Offering, Shrug It Off, Impervious, Feel No Pain, Inflame, Blood Wall, Whirlwind
   - **Tier 3** (decent): Most attacks/skills with meaningful stat boosts
4. **Never upgrade**: Strike, Defend (remove them instead)
5. If no good target exists, use `./sts2 grid_select_skip` (if cancelable)

Prioritize cards that are **core to the current archetype** (check `run-state.md`). Between two same-tier cards, upgrade the one played more frequently.

```
[SMITH: Upgrading Rupture (+1→+2 Str per trigger) — doubles Bloodletting build scaling]
> ./sts2 grid_select_card RUPTURE
```

## Output Format

```
[REST_SITE: HP 38/80 (47%), no Tier 1 upgrade — choosing HEAL for boss safety]
> ./sts2 choose_rest_option HEAL
> ./sts2 proceed

[REST_SITE: HP 64/80 (80%), Barricade available for upgrade — choosing SMITH]
> ./sts2 choose_rest_option SMITH
> ./sts2 grid_select_card BARRICADE
> ./sts2 proceed
```

## Related Skills

| Situation | Load Skill |
|-----------|------------|
| Upgrade priority data | Read `docs/deck-building-framework.md` |
| Update run state after upgrade | `run-state-management` |
| Archetype strategies | Read `docs/builds.md` |
