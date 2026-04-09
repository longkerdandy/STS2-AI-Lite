---
name: shop-evaluation
description: Shop purchase decision framework for Slay the Spire 2 — card/relic/potion evaluation, gold budget management, and card removal priority
---

# Shop Evaluation

Use this skill when the Deck-Building Agent enters a SHOP screen.

**Data source**: All card tiers, archetype definitions, relic evaluation, gold efficiency thresholds, and card removal priority are defined in `docs/deck-building-framework.md`. Read it before making purchase decisions.

## Procedure

1. Read game state: `shop.cards[]`, `shop.relics[]`, `shop.potions[]`, `shop.card_removal`, `shop.player_gold`
2. Read `run-state.md` for current build archetype, key cards, weaknesses, deck size
3. Read `docs/deck-building-framework.md` for evaluation data
4. Evaluate all items using the framework
5. Execute purchases in priority order (highest value first)
6. `./sts2 proceed` to leave

## Step 1: Assess Current State

From `run-state.md` and game state, determine:
- **Archetype**: Use the Signal Table in the framework
- **Deck size**: Check against Deck Size Rules in the framework
- **Weaknesses**: Check against Weakness Categories in the framework
- **Gold budget**: Check Gold Budget by Act in the framework

## Step 2: Evaluate Cards

For each `shop.cards[]` item where `is_stocked` is true:

1. Look up the card's tier in the **Card Tier List** (framework)
2. Check archetype fit using **Archetype Signal Table** (framework)
3. Check if it fixes a weakness from **Weakness Categories** (framework)
4. Apply **Deck Size Rules** — skip if deck is too large for the card's tier
5. Check price against **Purchase Value Thresholds** (framework)

Score: `Card Tier + Archetype Fit + Weakness Fix - Deck Size Penalty - Gold Cost`

## Step 3: Evaluate Relics

For each `shop.relics[]` item where `is_stocked` is true:

1. Check **Universal High-Value Relics** table (framework) — energy relics are always worth buying
2. Check **Archetype-Specific Relics** table (framework) — strong synergy relics are high priority
3. Check **Relic Traps** in Anti-Patterns (framework) — avoid traps like Ectoplasm without a strong deck
4. Check price against thresholds (framework): ≤ 250g for universal, ≤ 200g for archetype-specific

## Step 4: Evaluate Card Removal

If `shop.card_removal` exists and `is_used` is false:

1. Check **Card Removal Priority** in the framework
2. Card removal is almost always worth buying if deck > 15 cards
3. Priority: Curses > Strikes > Defends > Status cards
4. Skip if deck < 15 cards or all cards are useful

When `shop_remove_card` opens GRID_CARD_SELECT:
- Pick the highest-priority removal target per framework
- Use `./sts2 grid_select_card <card_id>` to remove
- Or `./sts2 grid_select_skip` to cancel

## Step 5: Evaluate Potions

For each `shop.potions[]` item where `is_stocked` is true:

1. Check if potion belt has empty slots (if full, skip)
2. Buy only if boss or elite is within next 2-3 floors
3. Price threshold: ≤ 75g
4. Priority: damage potions for boss, block potions if low HP

## Step 6: Purchase Order

Execute purchases in this order (highest value first):

```
1. S-tier card (any price)
2. Card removal (if deck > 15 and removal target exists)
3. Archetype core card (≤ 150g)
4. Energy/universal relic (≤ 250g)
5. Archetype-synergy relic (≤ 200g)
6. A-tier card that fills weakness (≤ 120g)
7. Useful potion (≤ 75g, boss soon)
8. B-tier card for critical weakness (≤ 80g)
9. Skip remaining items
```

After each purchase, re-check remaining gold before next purchase.

## Commands

```bash
./sts2 shop_buy_card <card_id>      # Buy a card
./sts2 shop_buy_relic <relic_id>    # Buy a relic
./sts2 shop_buy_potion <potion_id>  # Buy a potion
./sts2 shop_remove_card             # Buy card removal → GRID_CARD_SELECT
./sts2 proceed                      # Leave shop
```

## Output Format

```
[SHOP: Gold 187, Exhaust build (18 cards). Shrug It Off (48g) S-tier + fills Block weakness. Buying.]
> ./sts2 shop_buy_card SHRUG_IT_OFF

[SHOP: Gold 139. Card removal (75g) to remove Strike — deck thinning priority.]
> ./sts2 shop_remove_card

[SHOP: Gold 64. Remaining items don't justify spend. Leaving.]
> ./sts2 proceed
```

## Related Skills

| Situation | Load Skill |
|-----------|------------|
| Update run state after purchase | `run-state-management` |
| Card evaluation data | Read `docs/deck-building-framework.md` |
| Detailed archetype strategies | Read `docs/builds.md` |
| Unfamiliar card/relic effects | Read `docs/cards.md` or `docs/relics.md` |
