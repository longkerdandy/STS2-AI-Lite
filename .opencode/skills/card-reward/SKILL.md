---
name: card-reward
description: Card reward evaluation and deck-building strategy for Slay the Spire 2 Ironclad — archetype identification, card pick/skip decisions, and long-term deck planning
---

## Card Reward Evaluation

Use this skill when **choosing card rewards** after combat victory.

When faced with a card reward (`card_choices[]` array), use this procedure to decide whether to pick a card or skip.

**Data source**: All card tiers, archetype definitions, weakness mapping, and deck size rules are defined in `docs/deck-building-framework.md`. Read it before evaluating.

## Step 1: Identify Current Build Archetype

**Load the `run-state-management` skill** and check `run-state.md` for a prior archetype assessment. If none exists, assess now using the **Archetype Signal Table** in `docs/deck-building-framework.md`:

- Count core signal cards in deck
- 2+ core signals → committed
- 1 core signal → leaning (stay flexible)
- 0 core signals → uncommitted (pick strongest individual card)

For detailed archetype strategies, read `docs/builds.md`.

## Step 2: Evaluate Each Card Choice

For each card in `card_choices[]`, score it on these criteria (all data from `docs/deck-building-framework.md`):

### A. Archetype Fit (Highest Weight)

- **Core card for current archetype**: Strong take
- **Support card for current archetype**: Good take if deck needs it
- **Card for a different archetype**: Usually skip unless universally strong
- **No archetype committed yet**: Judge on raw card quality (use Card Tier List)

### B. Card Tier (from framework)

Check the card's tier in the **Card Tier List**:
- **S-Tier**: Take in any build unless deck is 22+ cards and already has the effect
- **A-Tier**: Take when fits build or fills a weakness
- **B-Tier**: Take in right context only
- **C-Tier**: Usually skip

### C. Weakness Coverage (from framework)

Check the **Weakness Categories** table. A card that fixes a genuine weakness is worth taking even if it's not core to the archetype.

### D. Deck Size Check (from framework)

Check the **Deck Size Rules** table for guidance based on current deck size.

## Step 3: Act-Specific Adjustments

Check the **Act-Specific Adjustments** table in the framework. How to infer the Act: early decks (mostly Strikes/Defends) = Act 1; several uncommons/rares = Act 2+; very developed decks = Act 3+.

## Step 4: Make the Decision

Score each card choice mentally:

```
Card Score = Archetype Fit + Tier Bonus + Weakness Fix - Deck Size Penalty
```

- If the best card scores positively: `./sts2 reward_choose_card --type card --card_id <card_id>`
- If all cards score negatively: `./sts2 reward_skip_card --type card`

Output 1 sentence explaining the decision:

```
[Deck is Strength build (15 cards). Inflame (+2 Str) strengthens the core — taking it over Defend+ and Anger.]
> ./sts2 reward_choose_card --type card --card_id INFLAME

[Deck is 23 cards, Exhaust build. None of the offered cards fit — skipping.]
> ./sts2 reward_skip_card --type card
```

## Step 5: Update Run State (If Warranted)

After making a card reward decision, consider whether the archetype assessment has changed. **Load the `run-state-management` skill.** Key triggers for update:

- The archetype assessment changes (e.g., picking Corruption pivots to Exhaust)
- A critical card shifts the deck's strategy
- The deck size crosses a threshold (15, 20, 25)

Do NOT update after every single reward — only on meaningful changes.

## Related Skills

| Situation | Load Skill |
|-----------|------------|
| Full combat and reward procedure | `combat-loop` |
| Update run state after reward | `run-state-management` |
| Potion decisions | `potion-timing` |

## Game Knowledge References

| Need | Read File |
|------|-----------|
| **Evaluation data (tiers, archetypes, weaknesses)** | `docs/deck-building-framework.md` |
| Detailed archetype strategies | `docs/builds.md` |
| Unfamiliar card effects | `docs/cards.md` |
| Unfamiliar relic effects | `docs/relics.md` |
