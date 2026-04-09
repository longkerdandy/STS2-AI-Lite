---
name: shop-evaluation
description: Shop purchase decision framework for Slay the Spire 2 — card/relic/potion evaluation, gold budget management, and card removal priority
---

# Shop Evaluation

Use this skill when the Deck-Building Agent enters a SHOP screen.

## Procedure

1. Read game state: `shop.cards[]`, `shop.relics[]`, `shop.potions[]`, `shop.card_removal`, `shop.player_gold`
2. Read `run-state.md` for current build, key cards, weaknesses
3. Evaluate all items against build needs
4. Execute purchases in priority order
5. `./sts2 proceed` to leave

## Purchase Priority

```
1. Archetype core card (if affordable) — e.g., Corruption for Exhaust build
2. Card removal (remove basic Strike/Defend) — improves deck quality
3. Key support card — fills a weakness (AoE, draw, block)
4. High-value relic — synergy with current build
5. Useful potion — if belt has space and boss is coming
6. Skip — save gold for future shops
```

## Gold Budget Guidelines

| Situation | Strategy |
|-----------|----------|
| Act 1, < 100g | Buy only core cards or removal |
| Act 1, > 150g | Can afford 1-2 purchases + removal |
| Act 2+ | More flexible, prioritize build completion |
| Pre-boss floor | Save for potions if needed |

## Card Removal Priority

When using `shop_remove_card` → GRID_CARD_SELECT:
1. Remove Strike first (basic attack, low value)
2. Remove Defend next (basic block, less impactful)
3. Remove Curses (if any)
4. Skip if deck is already lean (< 15 cards)

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
[SHOP: Gold 187. Shrug It Off (48g) fills Block weakness. Buying.]
> ./sts2 shop_buy_card SHRUG_IT_OFF
```
