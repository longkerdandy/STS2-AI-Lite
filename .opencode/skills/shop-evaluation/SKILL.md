---
name: shop-evaluation
description: Shop purchase decision framework for Slay the Spire 2 — card removal priority, infinite component acquisition, gold budget management
---

# Shop Evaluation

Use this skill when the Deck-Building Agent enters a SHOP screen.

**Data source**: All card tiers, relic evaluation, gold efficiency thresholds, and card removal priority are defined in `docs/deck-building-framework.md`. Read it before making purchase decisions.

## Core Principle

For infinite builds, **card removal is the #1 shop priority**. Every card removed brings the deck closer to loop activation. Removal > buying cards > buying relics.

## Procedure

1. Read game state: `shop.cards[]`, `shop.relics[]`, `shop.potions[]`, `shop.card_removal`, `shop.player_gold`
2. Read `run-state.md` for infinite readiness, missing categories, deck size, basics removed
3. Read `docs/deck-building-framework.md` for evaluation data
4. Evaluate all items using the framework
5. Execute purchases in priority order (highest value first)
6. `./sts2 proceed` to leave

## Step 1: Assess Current State

From `run-state.md` and game state, determine:
- **Infinite Readiness**: Not Started / Building / Almost Ready / Infinite Ready
- **Missing categories**: Exhaust / Draw / Energy — what does the deck still need?
- **Deck size**: Check against Deck Size Rules in the framework
- **Basics remaining**: How many Defends / Strikes left to remove?
- **Gold budget**: Check Gold Budget by Act in the framework

## Step 2: Evaluate Card Removal (FIRST PRIORITY)

If `shop.card_removal` exists and `is_used` is false:

1. **Card removal is almost always the best purchase** for infinite builds
2. Removal priority (from framework):
   - **Curses** → always remove
   - **Defends** → highest priority basic removal
   - **Strikes** → next priority after Defends gone
   - **Status cards** stuck in deck
   - **Non-infinite cards** added by mistake
3. Skip removal ONLY if all remaining cards serve the infinite AND deck ≤ 12

When `shop_remove_card` opens GRID_CARD_SELECT:
- Pick the highest-priority removal target per framework
- Use `./sts2 grid_select_card <card_id>` to remove
- Or `./sts2 grid_select_skip` to cancel (only if no valid target)

## Step 3: Evaluate Cards

For each `shop.cards[]` item where `is_stocked` is true:

1. Look up the card's tier in the **Card Tier List** (framework)
2. Check if it fills a **missing infinite category**
3. Apply **Deck Size Rules** — skip if deck is too large (20+)
4. Check price against **Purchase Value Thresholds** (framework)

**Buy conditions:**
- S-tier infinite component: Any price (Offering, Dark Embrace, Feel No Pain, etc.)
- A-tier card that fills missing category: ≤ 150g
- A-tier card (general): ≤ 120g
- B-tier card (critical gap only): ≤ 80g
- If readiness is "Infinite Ready": Skip ALL cards (don't add noise)

## Step 4: Evaluate Relics

For each `shop.relics[]` item where `is_stocked` is true:

1. Check **S-Tier Relics** in framework — energy relics, Unceasing Top, Runic Pyramid always worth buying
2. Check **A-Tier Relics** — Charon's Ashes, Burning Sticks, Mummified Hand etc.
3. Check **Relic Traps** — **NEVER buy Velvet Choker or Fiddle** (kills infinite)
4. Price thresholds: ≤ 300g for S-tier (energy, Unceasing Top), ≤ 200g for A-tier

**Important**: Card removal is higher priority than relics. Don't skip removal to buy a relic.

## Step 5: Evaluate Potions

For each `shop.potions[]` item where `is_stocked` is true:

1. Check if potion belt has empty slots (if full, skip)
2. Buy only if boss or elite is within next 2-3 floors
3. Price threshold: ≤ 75g
4. Priority: Energy potions (help engine setup), block potions (survive setup turns), damage potions (for boss)

## Step 6: Purchase Order

Execute purchases in this order (highest value first):

```
1. Card removal (ALWAYS buy if available and valid target exists)
2. S-tier infinite card (any price)
3. Energy relic / Unceasing Top / Runic Pyramid (≤ 300g)
4. A-tier card that fills missing category (≤ 150g)
5. Infinite-synergy relic (≤ 200g)
6. A-tier card (general fit) (≤ 120g)
7. Useful potion (≤ 75g, boss/elite soon)
8. B-tier card for critical gap (≤ 80g)
9. Skip remaining items
```

After each purchase, re-check remaining gold before next purchase.

## Gold Budget by Act

| Act | Reserve | Strategy |
|-----|---------|----------|
| Act 1 | Keep ≥ 75g | Card removal is priority. Buy 1 core infinite piece max. |
| Act 2 | Keep ≥ 100g | Card removal + engine completion. This is the critical shopping act. |
| Act 3+ | Spend freely | Deck should be complete. Remove remaining filler. |

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
[SHOP: Gold 187, Building infinite (16 cards, 2 Defends left). Card removal (75g) — removing Defend.]
> ./sts2 shop_remove_card
> ./sts2 grid_select_card DEFEND

[SHOP: Gold 112. Dark Embrace (95g) fills missing Draw engine — buying.]
> ./sts2 shop_buy_card DARK_EMBRACE

[SHOP: Gold 17. Remaining items too expensive. Leaving.]
> ./sts2 proceed
```

## Related Skills

| Situation | Load Skill |
|-----------|------------|
| Update run state after purchase | `run-state-management` |
| Card evaluation data | Read `docs/deck-building-framework.md` |
| Detailed infinite strategy | Read `docs/builds.md` |
| Unfamiliar card/relic effects | Read `docs/cards.md` or `docs/relics.md` |
