# Ironclad Build Strategy: Progressive Infinite

> AI decision-making guide for deck building across a run.
> Used during card reward evaluation and long-term planning.
> Based on Slay the Spire 2 community meta — Ironclad's dominant A10+ strategy.
> For card tiers, relic evaluation, and all numeric thresholds, see `docs/deck-building-framework.md`.

## Overview

Ironclad's strongest strategy is **progressive infinite** — building an exhaust-based engine that thins the active deck during combat until a small set of cards loops indefinitely, killing any enemy regardless of HP.

**Why infinite?** Community consensus: ~80% of successful A10 Ironclad runs go infinite. The exhaust components are common/uncommon rarity, making the strategy consistently achievable without relying on rare card luck.

**Golden Rule**: Always build toward infinite. The components you need (True Grit, Burning Pact, Pommel Strike, Shrug It Off, Bloodletting) are strong standalone cards that carry Phase 1 even before the loop is assembled.

## The Infinite Engine

### Core Mechanic

The infinite does NOT require a 5-card deck. It works by exhausting non-essential cards *during combat*:

```
Turn 1-3: Play engine powers (Dark Embrace, Feel No Pain, Corruption)
Turn 2-4: Exhaust junk cards (True Grit, Burning Pact, Second Wind)
Turn 3-5: Only loop components remain → cycle infinitely
Each cycle: Deal damage + generate block + draw back into the loop
```

### Engine Components

The engine has three mandatory categories:

| Category | Function | Key Cards |
|----------|----------|-----------|
| **Exhaust** | Remove non-loop cards from combat | True Grit, Burning Pact, Second Wind, Brand, Corruption, Stoke, Havoc |
| **Draw/Cycle** | Find and recycle loop components | Pommel Strike, Shrug It Off, Dark Embrace, Battle Trance, Headbutt |
| **Energy** | Fuel the loop each cycle | Bloodletting, Offering, Forgotten Ritual, Expect a Fight |

### Engine Accelerators (Powers)

These powers transform the engine from "good" to "unstoppable":

| Power | Effect | Priority |
|-------|--------|----------|
| **Corruption** | Skills cost 0 + auto-exhaust. Instantly activates the engine. | Take whenever seen (Ancient rarity). |
| **Dark Embrace** | Draw 1 per exhaust. Self-fueling — each exhaust finds the next card. | Must-take. Without this, engine stalls. |
| **Feel No Pain** | +3(4) Block per exhaust. All defense comes from this. No block cards needed. | Must-take. Removes the need for defensive cards entirely. |

### Example Loops

**Standard Loop (5 active cards):**
```
Bloodletting (0E, +2E) → Pommel Strike+ (1E, draw 2) → Spite (0E, draw 1) → Shrug It Off (1E, draw 1)
→ [cycle back to Bloodletting]
Net: 0 energy, 4 draws, damage + block each cycle
```

**Corruption Loop (any deck size):**
```
With Corruption + Dark Embrace + Feel No Pain active:
Play any Skill → costs 0, exhausts, draws 1, gains 3+ Block
→ Repeat until only Attacks remain
→ Play Attacks, discard/draw, repeat
```

**Zero-Cost Loop (with Unceasing Top relic):**
```
Bloodletting (0E, +2E) → Spite (0E) → [hand empty → draw 1]
→ Repeat with any 0-cost attacks
```

## Phase 1: Component Collection (Act 1 – Early Act 2)

### Goals
- Survive fights while collecting exhaust/cycle/energy components
- Remove Defends at every shop opportunity
- Take strong commons that double as loop pieces

### Card Priority

| Priority | Cards | Reasoning |
|----------|-------|-----------|
| **Always take** | Offering, True Grit, Burning Pact, Bloodletting, Feel No Pain, Dark Embrace | Core engine pieces. These ARE the strategy. |
| **High** | Pommel Strike, Shrug It Off, Headbutt, Brand, Second Wind | Loop components + Phase 1 survival |
| **Medium** | Battle Trance, Feed (1 copy), Spite, Iron Wave, Hemokinesis | Draw burst / HP buffer / Phase 1 filler |
| **Low** | Other attacks for survival | Only if deck desperately needs damage output |
| **Skip** | Non-cycling cards, expensive cards, deck-bloating cards | Anger, Bludgeon, Rampage, Perfected Strike, etc. |

### Act 1 Gameplay

1. **Floors 1–3**: Take Pommel Strike, True Grit, Shrug It Off if offered. These are strong standalone AND loop pieces.
2. **First shop**: Remove a Defend. Buy Burning Pact or Bloodletting if available.
3. **Floors 4–7**: Continue collecting. Headbutt helps recycle key cards. Feed gives HP buffer.
4. **Act 1 boss**: Use potions aggressively. Survive with current tools.

### Deck Size Target: 12–16 cards by end of Act 1

## Phase 2: Infinite Execution (Late Act 2 – Act 3)

### Goals
- Complete the engine (all 3 categories filled)
- Stop adding non-S-tier cards
- Maximize card removal at every shop
- Begin executing infinite loops in combat

### Transition Signals

Move to Phase 2 when you have:
- ≥ 2 exhaust sources
- ≥ 2 draw/cycle sources
- ≥ 1 energy source beyond base 3
- OR Corruption (immediately activates Phase 2 regardless of other pieces)

### Act 2 Gameplay

1. **Hunt for engine powers**: Dark Embrace and Feel No Pain transform the deck. Corruption is auto-take.
2. **Mass thinning**: Second Wind + Brand enable rapid deck thinning in combat.
3. **Shop priority**: Card removal > engine completion > everything else.
4. **Skip marginal cards**: Even B-tier cards add noise. Only take S/A-tier or critical gap fills.

### Act 3+ Gameplay

1. **Deck should be looping**: If engine is online, skip ALL card rewards.
2. **Every shop**: Remove a card. Removal is the most valuable shop action.
3. **Combat approach**: Set up engine → exhaust to loop → kill.
4. **Boss preparation**: Ensure loop can handle the damage race. Potions for turn 1 survival while setting up.

### Deck Size Target: 14–18 cards (engine thins the rest in combat)

## Combat Execution (Infinite)

### Setup Phase (Turns 1–3)

1. **Turn 1**: Play powers — Dark Embrace, Feel No Pain, Corruption (if affordable). Use Offering/Bloodletting for energy.
2. **Turn 2**: Begin exhausting — True Grit, Burning Pact, Second Wind. Let Feel No Pain generate block.
3. **Turn 3**: Active deck should be thin enough to start cycling loop components.

### Loop Phase (Turn 3+)

1. **Identify loop**: Check which cards remain in draw + hand + discard.
2. **Execute cycle**: Play loop components in order. Each cycle should net 0 energy and draw the full loop back.
3. **Kill**: Each cycle deals damage. Continue until all enemies are dead.
4. **Block**: Feel No Pain triggers during exhaust provide all necessary defense.

### Key Combat Principles

- **Don't block manually during setup** — Feel No Pain handles defense once exhausting begins.
- **Exhaust aggressively** — every non-loop card removed brings you closer to infinite.
- **Energy first** — play Bloodletting/Offering before other cards to maximize plays per turn.
- **Draw before exhaust** — use Battle Trance/Pommel Strike to find exhaust tools.
- **Attacks last** — play attacks after all exhaust/draw/energy cards to maximize damage from accumulated Strength.

## Key Relics

### Infinite-Critical Relics

| Relic | Effect | Impact |
|-------|--------|--------|
| Unceasing Top | Draw 1 when hand empty | Guarantees loop with 0-cost cards. Top infinite relic. |
| Charon's Ashes | 3 AoE damage per exhaust | Passive kill condition. Each exhaust = damage to ALL enemies. |
| Runic Pyramid | Don't discard hand | Hold loop pieces across turns during setup. |
| Ice Cream | Energy persists | Bank energy from Bloodletting for big setup turns. |
| Burning Sticks | Copy first Skill exhausted | Extra fuel for the engine each combat. |

### Strong Support Relics

| Relic | Why |
|-------|-----|
| Gambling Chip | Mulligan opening hand for engine pieces |
| Mummified Hand | Free card when Power played (helps setup) |
| Toasty Mittens | Free exhaust + Str each turn |
| Centennial Puzzle | Draw 3 on first HP loss (Bloodletting trigger) |
| Pendulum | Draw on shuffle (fires during loop cycling) |

### Relics to AVOID

| Relic | Why |
|-------|-----|
| **Velvet Choker** | 6 card limit per turn KILLS the infinite loop. Never take. |
| **Fiddle** | Cannot draw during turn. KILLS infinite. Never take. |
| Spiked Gauntlets | Powers cost +1. Delays engine setup by 1–2 turns. |

## Card Removal Strategy

**Priority order at shops**: Defends → Strikes → Status → Non-infinite cards

| Card | Remove When | Reasoning |
|------|------------|-----------|
| Defend | Always first | 1E for no damage, no cycle. Feel No Pain replaces block. |
| Strike | After Defends gone | At least deals 6 damage, but doesn't cycle or thin. |
| Non-infinite filler | When deck is Phase 2 | Any card not part of the loop is noise. |

**Exception**: Keep 1 Defend if you have NO block source and are still in Phase 1.

**Target**: Remove all 4 Defends + all 5 Strikes over the run = deck is entirely engine + loop.

## Upgrade Strategy

Upgrade infinite components, not survival cards:

| Priority | Cards | Why |
|----------|-------|-----|
| **First** | Pommel Strike (+1 draw), Offering (+2 draw), Dark Embrace (-1 cost) | These upgrades directly enable or accelerate the loop |
| **Second** | Corruption (-1 cost), Bloodletting (+1E), Feel No Pain (+1 Block) | Engine efficiency |
| **Third** | Burning Pact (+1 draw), Shrug It Off (+3 Block), Second Wind (+2 Block/card) | Support upgrades |
| **Never** | Strike, Defend | Remove, don't upgrade |

At rest sites: SMITH if you have a Tier 1 upgrade target. HEAL only if HP < 40%.

## Fallback Strategies

If by mid-Act 2 the infinite is not assembling (< 2 components):

### Exhaust Midrange
- **When**: Have Feel No Pain / True Grit but no draw engine
- **How**: Use exhaust for value (block from FNP, thinning from True Grit) without looping
- **Finishers**: Ashen Strike (scales with exhaust pile), Pact's End (0-cost AoE), Fiend Fire (burst)

### Strength Scaling
- **When**: Found Demon Form / Inflame but no exhaust pieces
- **How**: Stack Strength, attack with multi-hit cards
- **Core**: Demon Form → Whirlwind / Thrash / Twin Strike

### Block + Body Slam
- **When**: Heavy on block cards (Shrug It Off, Blood Wall, Impervious)
- **How**: Accumulate block, convert to damage via Body Slam
- **Core**: Body Slam + Barricade + block generators

These fallbacks are rarely needed. The exhaust components are common/uncommon — in most runs, you will find enough to go infinite without trying.

## Doormaker Boss (Act 3)

Doormaker has turns that prohibit card draw, which counters draw-dependent loops.

**Countermeasures:**
- Race: Kill within first 3–4 turns before anti-draw activates
- 0-cost cards: Spite, Pact's End, Bloodletting are playable without draw
- Pre-block: Build massive block via Feel No Pain on the turn before restriction
- Emergency: Impervious, block potions for the restricted turn
- Best case: Charon's Ashes provides passive damage even during restricted turns

## Quick Reference

### Must-Have Cards (S-Tier)
Offering, Corruption, Dark Embrace, Feel No Pain, Bloodletting, Burning Pact, True Grit

### Phase 1 Commons to Take
Pommel Strike, Shrug It Off, True Grit, Headbutt, Iron Wave

### Key Upgrade Targets
Pommel Strike, Offering, Dark Embrace, Corruption, Bloodletting, Feel No Pain

### Shop Priority
1. Card removal (always)
2. S-tier card (any price)
3. A-tier card (≤ 150g)
4. Energy relic (≤ 300g)

### Removal Priority
Curses → Defends → Strikes → Status → Non-infinite cards
