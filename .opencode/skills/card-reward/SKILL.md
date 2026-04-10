---
name: card-reward
description: Card reward evaluation and deck-building strategy for Slay the Spire 2 Ironclad — infinite build component evaluation, pick/skip decisions, and long-term deck planning
---

## Card Reward Evaluation

Use this skill when **choosing card rewards** after combat victory.

When faced with a card reward (`card_choices[]` array), use this procedure to decide whether to pick a card or skip.

**Data source**: All card tiers, infinite component tracking, weakness mapping, and deck size rules are defined in `docs/deck-building-framework.md`. Read it before evaluating.

## Step 1: Check Infinite Build Status

**Load the `run-state-management` skill** and read `run-state.md` for:
- **Infinite Readiness**: Not Started / Building / Almost Ready / Infinite Ready
- **Missing categories**: Which of Exhaust / Draw / Energy is lacking?
- **Phase**: 1 (Component Collection) or 2 (Infinite Execution)
- **Deck size**: Current count

**Quick decision**: If readiness is "Infinite Ready", **skip ALL card rewards** unless an S-tier card is offered that directly improves the loop. Adding cards = adding noise.

## Step 2: Evaluate Each Card Choice

For each card in `card_choices[]`, score on these criteria (all data from `docs/deck-building-framework.md`):

### A. Infinite Component Value (Highest Weight)

- **Fills a missing category**: TOP priority. If you need Energy and Bloodletting is offered, take it immediately.
- **S-tier infinite component**: Always take (Offering, Dark Embrace, Feel No Pain, Corruption, Bloodletting, Burning Pact, True Grit).
- **A-tier infinite support**: Take if deck < 20 (Pommel Strike, Shrug It Off, Second Wind, Brand, Headbutt, Battle Trance).
- **B-tier role player**: Take only if fills specific gap and deck < 16.
- **Non-infinite card**: Usually skip. Only consider if Phase 1 and desperately need survival.

### B. Card Tier (from framework)

Check the card's tier in the **Card Tier List**:
- **S-Tier**: Take unless readiness is "Infinite Ready" AND deck already has this card's role covered
- **A-Tier**: Take in Phase 1, selective in Phase 2
- **B-Tier**: Take only in Phase 1 if fills weakness
- **C/D-Tier**: Skip

### C. Weakness Coverage (from framework)

Check the **Weakness Categories** table. Key weaknesses for infinite:
- No Exhaust Engine → take any exhaust source
- No Draw Engine → take any draw source
- No Energy Gen → take Bloodletting/Offering
- No Defense (during transition) → take Shrug It Off/Iron Wave/Impervious

### D. Deck Size Check (from framework)

Check the **Deck Size Rules** table:
- < 12: Take good components freely
- 12–16: Take S/A-tier or weakness fixes
- 16–20: Take only S-tier or critical missing piece
- 20+: Skip unless S-tier gap fill

## Step 3: Phase-Specific Adjustments

### Phase 1 (Component Collection — Act 1 to early Act 2)

- **Priority**: Survival + infinite components
- **Take**: Strong commons that double as loop pieces (Pommel Strike, Shrug It Off, True Grit)
- **Take**: Feed (1 copy) for Max HP buffer
- **Take**: Iron Wave, Hemokinesis if deck needs damage to survive Act 1
- **Skip**: Cards that don't cycle or thin (Anger, Bludgeon, Rampage)

### Phase 2 (Infinite Execution — late Act 2+)

- **Priority**: Only cards that directly improve the loop
- **Take**: S-tier if not already owned
- **Skip**: Everything else. Deck should be shrinking, not growing.

### Fallback Mode

If readiness is "Not Started" by mid-Act 2, note this in output and consider:
- Demon Form / Inflame → Strength fallback
- Body Slam + block cards → Block fallback
- Continue taking exhaust cards for non-loop value

## Step 4: Make the Decision

Score each card choice mentally:

```
Card Score = Infinite Component Value + Tier Bonus + Missing Category Fill - Deck Size Penalty
```

- If the best card scores positively: `./sts2 reward_choose_card --type card --card_id <card_id>`
- If all cards score negatively or readiness is "Infinite Ready": `./sts2 reward_skip_card --type card`

Output 1 sentence explaining the decision:

```
[Building infinite (14 cards). Bloodletting fills missing Energy category — taking it over Bludgeon and Iron Wave.]
> ./sts2 reward_choose_card --type card --card_id BLOODLETTING

[Infinite Ready (16 cards). None of the offered cards improve the loop — skipping.]
> ./sts2 reward_skip_card --type card
```

## Step 5: Update Run State (If Warranted)

After making a card reward decision, check if readiness level changed. **Load the `run-state-management` skill.** Key triggers for update:

- A new infinite component added → recalculate readiness
- Readiness level changes (e.g., "Building" → "Almost Ready")
- Deck size crosses a threshold (12, 16, 20)
- Fallback triggered (no components by mid-Act 2)

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
| **Evaluation data (tiers, components, weaknesses)** | `docs/deck-building-framework.md` |
| Detailed infinite build strategy | `docs/builds.md` |
| Unfamiliar card effects | `docs/cards.md` |
| Unfamiliar relic effects | `docs/relics.md` |
