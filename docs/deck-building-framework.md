# Deck-Building Evaluation Framework

> Single source of truth for card, relic, and deck evaluation across all decision points.
> Referenced by: card-reward, shop-evaluation, rest-site-tactics skills.
> Strategy: **Progressive Infinite** — the dominant Ironclad strategy for A10+ clears.

## Core Strategy: Progressive Infinite

Ironclad's strongest and most consistent strategy is **exhaust-based infinite**. The deck uses exhaust cards to thin the active card pool during combat until only loop components remain, then cycles them infinitely to kill any enemy.

**Key insight**: You do NOT need a 5-card deck. A 15–20 card deck works if it contains enough exhaust + cycle components. The exhaust engine thins the deck *during combat*.

### Two-Phase Model

| Phase | Timing | Goal |
|-------|--------|------|
| **Phase 1: Component Collection** | Act 1 – early Act 2 | Survive fights while collecting exhaust/cycle pieces. Take strong commons that double as infinite components. |
| **Phase 2: Infinite Execution** | Late Act 2 – Act 3 | Engine online. Stop adding cards. Maximize removal. Exhaust down to loop in combat. |

### How the Infinite Works

1. Play exhaust engine cards (Corruption, True Grit, Burning Pact, Second Wind) to remove non-essential cards from combat
2. Feel No Pain generates block as you exhaust → defense
3. Dark Embrace draws cards as you exhaust → fuel
4. Once only loop components remain in draw+hand+discard, cycle them infinitely
5. Each cycle deals damage and/or generates block

### Minimum Loop Example

```
Bloodletting (+2E, -3HP) → Pommel Strike+ (1E, draw 2) → Spite (0E, draw 1 if lost HP) → Shrug It Off (1E, draw 1)
Net energy: 0 | Net draw: 4 | With ≤5 active cards = infinite loop
```

## Card Tier List

Cards rated by contribution to the infinite strategy. Higher tier = higher priority to take.

### S-Tier: Core Infinite Components (Always take)

| Card | Type | Cost | Role in Infinite |
|------|------|------|------------------|
| Offering | Skill | 0 | +2E, draw 3(5), exhaust self. Best Ironclad card. Energy + draw + exhaust trigger. |
| Corruption | Power | 3(2) | Skills cost 0 + auto-exhaust. THE engine card. Every Skill becomes a free exhaust trigger. (Ancient) |
| Dark Embrace | Power | 2(1) | Draw 1 per exhaust. Keeps the engine running. Without this, exhaust runs dry. |
| Feel No Pain | Power | 1 | +3(4) Block per exhaust. Passive defense that replaces all block cards once online. |
| Bloodletting | Skill | 0 | -3HP, +2(3)E. Zero-cost energy. Critical loop component + self-damage trigger. |
| Burning Pact | Skill | 1 | Exhaust 1, draw 2(3). Directed exhaust + draw. Premium thinning tool. |
| True Grit | Skill | 1 | 7(9) Block + exhaust 1 random. Early thinning + defense. Core Phase 1 card. |

### A-Tier: Strong Infinite Support (Take when offered)

| Card | Type | Cost | Role in Infinite |
|------|------|------|------------------|
| Second Wind | Skill | 1 | Exhaust ALL non-Attacks in hand, +5(7) Block each. Mass thinning. Devastating with Corruption. |
| Pommel Strike | Attack | 1 | 9(10) damage + draw 1(2). Loop component — damage + cycle in one card. |
| Shrug It Off | Skill | 1 | 8(11) Block + draw 1. Defense + cycle. Phase 1 survival and loop component. |
| Brand | Skill | 0 | -1HP, exhaust 1, +1(2) Str. Zero-cost directed exhaust + permanent scaling. |
| Battle Trance | Skill | 0 | Draw 3(4). Zero-cost draw burst. Finds engine pieces fast. |
| Headbutt | Attack | 1 | 9(12) damage + put discard card on draw top. Recycle key pieces. Pre-infinite consistency. |
| Forgotten Ritual | Skill | 1 | If exhausted this turn, +3(4)E. Massive energy burst when engine is running. |
| Expect a Fight | Skill | 2(1) | +1E per Attack in hand. Energy burst for big turns. |

### B-Tier: Solid Role Players (Take in right context)

| Card | Type | Cost | Role in Infinite |
|------|------|------|------------------|
| Spite | Attack | 0 | 6(9) damage. Draw 1 if lost HP this turn. Zero-cost loop component. |
| Havoc | Skill | 1(0) | Play top of draw + exhaust it. Random thinning. Excellent when upgraded to 0 cost. |
| Rage | Skill | 0 | +3(5) Block per Attack this turn. Free defense during attack-heavy loop turns. |
| Impervious | Skill | 2 | 30(40) Block, exhaust self. Emergency defense. Self-exhausting = clean. |
| Stoke | Skill | 1(0) | Exhaust hand, draw equal. Mass hand refresh + exhaust. Upgraded (0 cost) is excellent. |
| Iron Wave | Attack | 1 | 5(7) Block + 5(7) damage. Balanced filler for Phase 1 survival. |
| Blood Wall | Skill | 2 | -2HP, 16(20) Block. Efficient block for Phase 1 + self-damage synergy. |
| Hemokinesis | Attack | 1 | -2HP, 14(19) damage. Strong Phase 1 damage + self-damage trigger. |
| Feed | Attack | 1 | 10(12) damage, +3(4) Max HP on kill, exhaust self. Take 1 copy early for HP buffer. |
| Ashen Strike | Attack | 1 | 9+ damage scaling with exhaust pile size. Natural finisher in exhaust decks. |
| Pact's End | Attack | 0 | 17(23) AoE if 3+ exhausted. Zero-cost AoE finisher. |
| Drum of Battle | Power | 0 | Draw 2 + exhaust top of draw each turn. Free engine piece. |
| Fiend Fire | Attack | 2 | Exhaust hand, 7(10) damage per card. Nuclear thinning + burst damage. |
| Armaments | Skill | 1 | 5 Block + upgrade 1(ALL) in hand. Upgraded version upgrades loop pieces mid-combat. |

### C-Tier: Situational (Skip unless filling specific need)

| Card | When to Take |
|------|--------------|
| Demon Form | Fallback if infinite not assembling by mid-Act 2. |
| Body Slam | Only with Feel No Pain generating huge block. |
| Twin Strike | Only if desperate for Act 1 damage. |
| Inflame | Only if pivoting to Strength fallback. |
| Whirlwind | Only with excess energy generation. |
| Uppercut | Only if Vulnerable desperately needed. |
| Flame Barrier | Only vs multi-hit enemies and no other defense. |
| Barricade | Skip for infinite. Block build fallback only. |
| Rupture | Take if already have Bloodletting + self-damage density. Not core to loop. |
| Inferno | Take if heavy on self-damage. Not core to loop. |

### D-Tier: Never Take

Anger (deck bloat — worst card for infinite), Perfected Strike (anti-thinning), Clash (unreliable), Bludgeon (3E, no synergy), Rampage (doesn't cycle), Sword Boomerang (random, doesn't cycle), Setup Strike (temporary Str, doesn't thin).

### Key Colorless Cards

| Card | Tier | Role |
|------|------|------|
| Purity | S | 0-cost, exhaust up to 3(5) from hand. Best thinning card in the game. |
| Flash of Steel | A | 0-cost, 5 damage + draw 1. Perfect loop component. |
| Finesse | A | 0-cost, 4 Block + draw 1. Perfect loop component. |
| Master of Strategy | A | 0-cost, draw 3(4), exhaust self. Free draw burst. |
| Production | A | 0-cost, +2E, exhaust. Free energy. Upgraded removes exhaust keyword. |
| Restlessness | A | 0-cost, Retain. If hand empty → draw 2 + gain 2E. Infinite synergy. |
| Secret Weapon / Technique | B | 0-cost, tutor Attack/Skill from draw. Find missing loop piece. |
| Thinking Ahead | B | 0-cost, draw 2, put 1 on draw top, exhaust. Cycle + thin. |
| Dark Shackles | B | 0-cost, -9(15) Str to enemy, exhaust. Emergency defense. |
| Impatience | B | 0-cost, draw 2 if no Attacks in hand. Conditional but free. |
| Panache | B | Power. Every 5 cards played = 10(14) AoE. Passive kill during infinite loop. |

## Weakness Categories

| Weakness | Diagnosis | Solution Cards |
|----------|-----------|----------------|
| No Exhaust Engine | No Corruption/True Grit/Burning Pact by mid-Act 2 | True Grit, Burning Pact (common/uncommon — should appear) |
| No Draw Engine | No Dark Embrace / Pommel Strike | Pommel Strike, Battle Trance, Shrug It Off |
| No Energy Gen | Relying on base 3E only | Bloodletting, Offering, Forgotten Ritual |
| No Defense (Transition) | Engine not ready, taking too much damage | Shrug It Off, Impervious, Iron Wave, Feel No Pain |
| No Kill Condition | Can loop but not enough damage | Pommel Strike, Spite, Ashen Strike, Pact's End |
| Deck Bloat | 22+ cards with insufficient exhaust | Stop taking cards. Prioritize removal at every shop. |
| No AoE | Multi-enemy fights too slow | Pact's End, Whirlwind, Breakthrough |

A card that fixes a genuine weakness is worth taking even if it's B-tier.

## Deck Size Rules

| Deck Size | Card Rewards | Card Removal | Notes |
|-----------|-------------|--------------|-------|
| < 12 | Take good infinite components freely | Only remove Curses | Small deck loops fast even without full engine |
| 12–16 | Take if S/A-tier or fixes weakness | Remove Defends first, then Strikes | Sweet spot for Phase 1 |
| 16–20 | Take only S-tier or critical missing piece | High priority removal | Engine must be strong to thin this many |
| 20+ | Skip unless critical S-tier gap | Maximum priority removal | Danger zone — infinite may be too slow to activate |

## Act-Specific Priorities

| Act | Priority | Strategy |
|-----|----------|----------|
| Act 1 | Damage + early exhaust pieces | Take Pommel Strike, Shrug It Off, True Grit, Burning Pact, Headbutt. Feed for Max HP. Kill fast. |
| Act 2 | Engine completion | Hunt Dark Embrace, Feel No Pain, Corruption. Second Wind, Brand for mass thinning. Stop taking filler. |
| Act 3+ | Extremely selective | Only cards that directly improve the loop. Card removal at every shop. Deck should be lean and looping. |

## Upgrade Priority

### Tier 1 — Game-Changing (Upgrade first)

| Card | Upgrade Effect | Why |
|------|---------------|-----|
| Pommel Strike | Draw 1→2 | Doubles cycle speed. Critical loop upgrade. |
| Dark Embrace | Cost 2→1 | Playable turn 1. Engine online a turn earlier. |
| Corruption | Cost 3→2 | Playable with 2E remaining. Massive tempo gain. |
| Offering | Draw 3→5 | Nearly draws entire deck. Best single upgrade in the game. |
| Bloodletting | Energy +2→+3 | 50% more energy per loop cycle. |
| Feel No Pain | Block 3→4 | 33% more block per exhaust. Compounds over many exhausts. |

### Tier 2 — Strong

| Card | Upgrade Effect |
|------|---------------|
| Burning Pact | Draw 2→3 |
| Second Wind | Block 5→7 per card |
| Shrug It Off | Block 8→11 |
| Havoc | Cost 1→0 |
| Stoke | Cost 1→0 |
| Spite | Damage 6→9 |
| Impervious | Block 30→40 |
| Brand | Str +1→+2 |
| Bash | Vuln 2→3 (useful in Phase 1) |
| True Grit | Block 7→9 |

### Tier 3 — Decent

Most other attacks (+damage), most other skills (+block).

### Never Upgrade

Strike and Defend — remove them instead. Also skip cards you plan to remove soon.

## Relic Evaluation

### S-Tier (Always take/buy)

| Relic | Why |
|-------|-----|
| Energy relics (Lantern, Ice Cream, etc.) | More energy = faster loop activation |
| Unceasing Top | Hand empties during loop → auto-draw. CRITICAL infinite enabler. |
| Runic Pyramid | Keep loop pieces across turns. Find engine faster. |
| Gambling Chip | Fix opening hand to find engine pieces turn 1. |
| Charon's Ashes | 3 AoE damage per exhaust. Passive kill during infinite loop. |
| Lizard Tail | Death prevention. Run saver. |

### A-Tier (High value for infinite)

| Relic | Why |
|-------|-----|
| Burning Sticks | First Skill exhausted → copy to hand. Extra engine fuel. |
| Mummified Hand | Free card per Power played. Helps setup turn. |
| Game Piece | Draw 1 per Power played. Finds engine pieces faster. |
| Pendulum | Draw 1 on draw pile shuffle. Triggers during loop cycling. |
| Iron Club | Draw 1 every 4 cards played. Passive draw during loop. |
| Toasty Mittens | Exhaust top of draw + 1 Str each turn. Free thinning + scaling. |
| Joss Paper | Draw 1 every 5 exhausts. Passive fuel during big exhaust turns. |
| Bag of Preparation | +2 draw turn 1. Find engine pieces early. |
| Centennial Puzzle | Draw 3 first HP loss. Pairs with Bloodletting/Offering. |
| Gremlin Horn | +1E + draw 1 per enemy kill. Huge in multi-enemy fights. |
| Snecko Eye | +2 draw (Confused). Loop cards are mostly 0–1 cost, Confused barely hurts. |

### B-Tier (Helpful)

| Relic | Why |
|-------|-----|
| Forgotten Soul | 1 damage per exhaust. Minor but adds up. |
| Pantograph | 25 HP at boss start. Survival buffer. |
| Kunai / Shuriken | Dex/Str per 3 Attacks. Triggers during loop. |
| Letter Opener | 5 AoE damage per 3 Skills. Triggers on exhaust-heavy turns. |
| Ornamental Fan | 4 Block per 3 Attacks. Defense during loop. |
| Anchor / Horn Cleat | Early Block to survive until engine runs. |
| Vajra | +1 Str. Always useful. |
| Tungsten Rod | -1 HP loss. Helps with self-damage costs. |

### Relic Traps (AVOID for infinite)

| Relic | Why Avoid |
|-------|-----------|
| Velvet Choker | 6 card limit per turn. **KILLS infinite loop. Never take.** |
| Fiddle | Cannot draw during turn. **KILLS infinite loop. Never take.** |
| Ectoplasm | No gold = no card removal at shops. Only take if deck is already very lean. |
| Sozu | No potions. Acceptable only if infinite is already online. |
| Philosopher's Stone | Enemies +1 Str. Risky if loop takes time to activate. |
| Spiked Gauntlets | Powers cost +1. Hurts engine setup (Dark Embrace 2→3, Feel No Pain 1→2). |

## Gold Efficiency (Shop)

### Purchase Priority Order

| Priority | Purchase | Condition |
|----------|----------|-----------|
| 1 | **Card removal** | Always buy. Most important shop action for infinite. |
| 2 | S-tier infinite card | Any price |
| 3 | A-tier card (fits build) | ≤ 150g |
| 4 | Energy relic / Unceasing Top | ≤ 300g (worth premium) |
| 5 | Infinite-synergy relic | ≤ 200g |
| 6 | Useful potion (boss in 2–3 floors) | ≤ 75g |
| 7 | B-tier card (critical gap) | ≤ 80g |
| 8 | Non-synergy relic | Skip |

### Gold Budget by Act

| Act | Reserve | Strategy |
|-----|---------|----------|
| Act 1 | Keep ≥ 75g | Prioritize card removal. Buy 1 core piece max. |
| Act 2 | Keep ≥ 100g | Card removal + engine completion. Critical shopping act. |
| Act 3+ | Spend freely | Deck should be complete. Remove remaining filler. |

### Card Removal Priority

1. **Curses** — always remove first
2. **Defends** — highest priority basic removal
3. **Strikes** — next priority after Defends are gone
4. **Status cards** stuck in deck
5. **Non-infinite cards** added by mistake
6. **Skip** if all remaining cards serve the infinite

> **Why Defends before Strikes**: Ironclad has 80 HP + Burning Blood heals 6. In Phase 1 you need damage to kill fast — Strikes at least deal 6 damage. Defends cost 1E for zero offensive contribution. Once Feel No Pain is online, exhaust generates all the block you need, making Defends completely redundant. With Corruption, Defends auto-exhaust (free triggers), but they still dilute draws and slow engine activation.

## Infinite Readiness Detection

Track these components in run state to determine loop viability:

### Required Components (need all 3 categories)

| Category | Cards | Minimum |
|----------|-------|---------|
| **Exhaust** | True Grit, Burning Pact, Second Wind, Corruption, Brand, Stoke, Havoc | ≥ 2 exhaust sources |
| **Draw/Cycle** | Pommel Strike, Shrug It Off, Battle Trance, Dark Embrace | ≥ 2 draw sources |
| **Energy** | Bloodletting, Offering, Forgotten Ritual, Expect a Fight | ≥ 1 energy source |

### Bonus Accelerators

| Component | Effect |
|-----------|--------|
| Corruption | Skills auto-exhaust → instant engine |
| Dark Embrace | Draw per exhaust → self-fueling loop |
| Feel No Pain | Block per exhaust → no defense cards needed |
| Unceasing Top | Auto-draw on empty hand → guaranteed loop |

### Readiness Levels

| Level | Criteria | Behavior |
|-------|----------|----------|
| **Not Started** | 0–1 infinite components | Play normally, take strong cards for survival |
| **Building** | 2–4 components, missing key category | Prioritize missing category. Still take survival cards if needed. |
| **Almost Ready** | All 3 categories covered, deck 15–20 | Stop adding non-S-tier cards. Maximize removal at every shop. |
| **Infinite Ready** | All categories + deck ≤ 16, or Corruption online | Fully commit. In combat, exhaust to loop. Skip all card rewards. |

## Fallback Strategy

If by mid-Act 2 you have < 2 infinite components:

1. **Exhaust Midrange**: Use exhaust cards for value (Feel No Pain + True Grit) without full loop. Ashen Strike / Pact's End as finishers.
2. **Strength Scaling**: Pivot to Demon Form + multi-hit (Whirlwind, Twin Strike, Thrash).
3. **Block + Body Slam**: If heavy on block cards, add Body Slam as win condition.

The fallback is rarely needed — exhaust components (True Grit, Burning Pact, Pommel Strike, Shrug It Off) are common/uncommon and appear frequently.

## Anti-Patterns

### Cards to Almost Never Take

- 3rd+ copy of any common (deck bloat kills infinite consistency)
- 3-cost cards without energy support (too expensive for loop)
- Cards that add copies to deck (Anger = infinite's worst enemy)
- Perfected Strike (anti-thinning philosophy)

### Decision Traps

- Taking "good" non-infinite cards (e.g., Demon Form when exhaust engine is assembling)
- Skipping card removal to buy a relic (removal is almost always higher priority)
- Being too conservative in Act 1 (need to take early components aggressively)
- Holding Strikes/Defends too long (remove at first opportunity)

## Doormaker Boss Counter

Act 3 boss Doormaker (489/512 HP) has three mechanics that counter infinite loops:

1. **Weighted affliction** (from HungerPower/GraspPower): Applied to ALL player cards — each card costs extra energy to play
2. **ScrutinyPower**: Blocks non-hand-draw card draw (Dark Embrace, Pommel Strike draw, Battle Trance, etc.)
3. **GraspPower**: Applies Weighted to all cards + gains 4/5 Strength + player loses 1 Str/1 Dex

Pattern: Dramatic Open → Hunger → Scrutiny → Grasp → Hunger → loop

**Countermeasures:**
- **Corruption** nullifies Weighted on Skills (Skills still cost 0 and exhaust)
- Keep 0-cost cards in loop (Spite, Pact's End, Bloodletting) — Weighted on 0-cost is still manageable
- Kill within first 3–4 turns before Weighted stacks become unmanageable
- Pre-build block on previous turns via Feel No Pain exhaust triggers
- Use Impervious or block potions for Scrutiny (30/35) and Grasp (20/23) damage turns
- Charon's Ashes provides passive damage per exhaust even during restricted turns
