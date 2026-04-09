---
name: card-reward
description: Card reward evaluation and deck-building strategy for Slay the Spire 2 Ironclad — archetype identification, card pick/skip decisions, and long-term deck planning
---

## Card Reward Evaluation

Use this skill when **choosing card rewards** after combat victory.

When faced with a card reward (`card_choices[]` array), use this procedure to decide whether to pick a card or skip.

## Step 1: Identify Current Build Archetype

Before evaluating cards, determine what archetype the deck is pursuing. **Load the `run-state-management` skill** and check `run-state.md` (if it exists) for a prior assessment. If not, assess now by examining the player's deck composition.

The five Ironclad archetypes and their signature cards:

| Archetype | Key Signals (cards in deck / relics) |
|-----------|--------------------------------------|
| **Strength** | Inflame, Demon Form, Twin Strike, Whirlwind, Thrash |
| **Block / Body Slam** | Body Slam, Barricade, Shrug It Off, Blood Wall, Unmovable, Impervious |
| **Exhaust** | Corruption, Dark Embrace, Feel No Pain, True Grit, Burning Pact, Second Wind |
| **Bloodletting** | Rupture, Inferno, Bloodletting, Breakthrough, Crimson Mantle |
| **Vulnerable** | Dismantle, Taunt, Tremble, Cruelty, Dominate, Colossus |

If the deck has no clear archetype yet (early Act 1), stay flexible — pick the strongest individual card.

For detailed archetype strategies, read `docs/builds.md`.

## Step 2: Evaluate Each Card Choice

For each card in `card_choices[]`, score it on these criteria:

### A. Archetype Fit (Highest Weight)

- **Core card for current archetype**: Strong take. These are the cards listed as "Core" or "Must-take" in `docs/builds.md`.
- **Support card for current archetype**: Good take if deck needs it.
- **Card for a different archetype**: Usually skip unless it's universally strong.
- **No archetype committed yet**: Judge on raw card quality.

### B. Universal S-Tier Cards (Always Consider)

These cards are strong in any Ironclad deck regardless of archetype:

| Card | Why |
|------|-----|
| Offering | +2 energy, +3 draw, triggers Rupture. Best Ironclad card. |
| Feed | +3 Max HP on kill. Valuable early/mid game. |
| Demon Form | +2 Str/turn. Fits any build. |
| Thrash | Multi-hit, flexible, self-scaling. |
| Battle Trance | Draw 3. Universally useful. |
| Headbutt | Damage + deck manipulation. |
| Brand | Deck thinning + self-damage trigger. |
| Break | High damage + Vulnerable. (Ancient card) |

If an S-tier card appears, take it unless the deck already has enough of that effect or is 22+ cards.

### C. Weakness Coverage

Check if the deck has gaps and whether a card choice fills them:

| Weakness | Cards That Fix It |
|----------|-------------------|
| No AoE | Whirlwind, Breakthrough, Conflagration |
| No scaling | Demon Form, Rupture, Inflame |
| No Block | Shrug It Off, Impervious, Blood Wall |
| No draw | Offering, Battle Trance, Pommel Strike, Burning Pact |
| No energy | Bloodletting, Offering |

A card that fixes a genuine weakness is worth taking even if it's not core to the archetype.

### D. Deck Size Check

| Deck Size | Guidance |
|-----------|----------|
| < 15 cards | Take good cards freely. Deck needs more tools. |
| 15-22 cards | Take only cards that are strong for the build or fix a weakness. |
| 22+ cards | Skip unless the card is S-tier or a critical missing piece. Lean decks win. |

## Step 3: Act-Specific Adjustments

| Act | Card Priority |
|-----|---------------|
| **Act 1** | Damage, AoE, card draw, early Vulnerable application. Take strong commons. Survival is the priority. |
| **Act 2** | Scaling powers, archetype-defining rares/uncommons. Build the engine. |
| **Act 3+** | Be very selective. Only take cards that solve a specific problem. Skip marginal cards. |

**How to infer the Act**: Look at the deck composition and enemy difficulty. Early decks (mostly Strikes/Defends) = Act 1. Decks with several uncommons/rares = Act 2+. Very developed decks = Act 3+. Turn number and encounter name can also provide hints.

## Step 4: Make the Decision

Score each card choice mentally:

```
Card Score = Archetype Fit + S-Tier Bonus + Weakness Fix - Deck Size Penalty
```

- If the best card scores positively: `./sts2 choose_card --type card --card_id <card_id>`
- If all cards score negatively (wrong archetype, deck too big, mediocre cards): `./sts2 skip_card --type card`

Output 1 sentence explaining the decision, referencing the archetype and reasoning:

```
[Deck is a Strength build (15 cards). Inflame (+2 Str) strengthens the core — taking it over Defend+ and Anger.]
> ./sts2 choose_card --type card --card_id INFLAME

[Deck is 23 cards, Exhaust build. None of the offered cards (Clash, Iron Wave, Flex) fit the archetype — skipping.]
> ./sts2 skip_card --type card
```

## Step 5: Update Run State (If Warranted)

After making a card reward decision, consider whether the deck's archetype assessment has changed. **Load the `run-state-management` skill.** If the pick commits the deck more firmly to an archetype (or opens a new blend), follow the skill's update procedure to modify `run-state.md`:

Key triggers for update:
- The archetype assessment changes (e.g., picking up Corruption pivots to Exhaust)
- A critical card is added that shifts the deck's strategy
- The deck size crosses a threshold (15, 20, 25)

Do NOT update after every single reward — only on meaningful changes.

## Common Blends

Some archetypes combine naturally. Recognize these when evaluating:

- **Exhaust + Block**: Feel No Pain generates Block, Body Slam converts to damage. Second Wind thins + blocks.
- **Vulnerable + Exhaust**: Exhaust thins deck for reliable Vulnerable redraw.
- **Strength + Bloodletting**: Rupture converts self-damage to Strength. Natural overlap.
- **Block + Vulnerable**: Taunt applies Vulnerable, Colossus converts Block from Vulnerable enemies.

If the deck shows signals for two complementary archetypes, pick cards that serve both.

## Anti-Patterns (Cards to Almost Never Take)

- **3rd+ copy of a common** (unless it's Shrug It Off or similar staple)
- **Expensive cards (3 energy) without energy support** in the deck
- **Curse-adjacent cards** (Clash restriction, Burn damage) unless the deck specifically works around them
- **Cards that anti-synergize** with the current build (e.g., Exhaust cards when you need to keep your hand full)

## Related Skills

| Situation | Load Skill |
|-----------|------------|
| Full combat and reward procedure | `combat-loop` |
| Update run state after reward | `run-state-management` |
| Potion decisions | `potion-timing` |

## Game Knowledge References

| Need | Read File |
|------|-----------|
| Detailed archetype strategies | `docs/builds.md` |
| Unfamiliar card effects | `docs/cards.md` |
| Unfamiliar relic effects | `docs/relics.md` |
