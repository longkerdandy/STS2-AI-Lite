# Deck-Building Evaluation Framework

> Single source of truth for card, relic, and deck evaluation across all decision points.
> Referenced by: card-reward, shop-evaluation, rest-site-tactics skills.
> For detailed per-archetype strategy and gameplay, see `docs/builds.md`.

## Archetype Identification

### Signal Table

| Archetype | Core Signals (2+ = committed) | Secondary Signals |
|-----------|-------------------------------|-------------------|
| **Strength** | Demon Form, Inflame, Whirlwind, Thrash | Twin Strike, Brand, Fight Me! |
| **Block / Body Slam** | Body Slam, Barricade, Unmovable | Shrug It Off, Blood Wall, Impervious, Flame Barrier |
| **Exhaust** | Corruption, Dark Embrace, Feel No Pain | True Grit, Burning Pact, Second Wind, Stoke |
| **Bloodletting** | Rupture, Inferno, Crimson Mantle | Bloodletting, Breakthrough, Offering, Hemokinesis |
| **Vulnerable** | Dismantle, Cruelty, Dominate, Colossus | Bash (upgraded), Taunt, Tremble, Uppercut, Molten Fist |

### Identification Rules

1. Count core signal cards in deck
2. **2+ core signals** from one archetype → committed to that archetype
3. **1 core signal** → leaning (stay flexible, don't force)
4. **0 core signals** → uncommitted (pick strongest individual card)
5. Signals from 2 complementary archetypes → blend (see below)

### Common Blends

| Blend | Synergy |
|-------|---------|
| Exhaust + Block | Feel No Pain → Block → Body Slam damage |
| Strength + Bloodletting | Rupture converts self-damage to Strength |
| Vulnerable + Exhaust | Thin deck for reliable Vulnerable redraw |
| Block + Vulnerable | Taunt applies Vulnerable → Colossus doubles Block |

## Card Tier List

Cards rated independently of archetype. Higher tier = stronger in more contexts.

### S-Tier (Take in any build)

| Card | Type | Cost | Why |
|------|------|------|-----|
| Offering | Skill | 0 | +2 energy, +3 draw, self-damage trigger. Best Ironclad card. |
| Feed | Attack | 1 | +3 Max HP on kill. Permanent scaling across the run. |
| Demon Form | Power | 3 | +2 Str/turn. Fits any build as win condition. |
| Thrash | Attack | 1 | Multi-hit, eats Attacks to scale. Flexible finisher. |
| Battle Trance | Skill | 0 | Draw 3 (4 upgraded). Universally useful. |
| Shrug It Off | Skill | 1 | 8 Block + draw 1. Best defensive common. |
| Corruption | Power | 3 | Skills cost 0 but Exhaust. Engine card. (Ancient) |
| Break | Attack | 2 | 20 damage + 5 Vulnerable. (Ancient) |

### A-Tier (Strong, take when fits build or fills weakness)

| Card | Type | Cost | Why |
|------|------|------|-----|
| Headbutt | Attack | 1 | 9 damage + deck manipulation. Recycles key cards. |
| Brand | Skill | 0 | Deck thinning + self-damage + Strength. |
| Inflame | Power | 1 | +2 Str, cheap. Core for Strength builds. |
| Body Slam | Attack | 1 | Damage = Block. Core for Block builds. |
| Impervious | Skill | 2 | 30 Block. Emergency defense + Body Slam setup. |
| Dark Embrace | Power | 2 | Draw on Exhaust. Core for Exhaust builds. |
| Feel No Pain | Power | 1 | Block on Exhaust. Core for Exhaust builds. |
| Rupture | Power | 1 | Strength on self-damage. Core for Bloodletting. |
| Barricade | Power | 3 | Block persists. Core for Block builds. |
| Whirlwind | Attack | X | AoE multi-hit. Best Strength payoff. |
| Bloodletting | Skill | 0 | -3 HP, +2 energy. Fuel + self-damage trigger. |
| Pommel Strike | Attack | 1 | 9 damage + draw 1. Efficient cycling. |

### B-Tier (Solid, take in right context)

| Card | Type | Cost | Why |
|------|------|------|-----|
| Twin Strike | Attack | 1 | Hits twice. Good early Strength multiplier. |
| Blood Wall | Skill | 2 | -2 HP, 16 Block. Efficient Block. |
| True Grit | Skill | 1 | 7 Block + random Exhaust. Early thinning. |
| Burning Pact | Skill | 1 | Exhaust 1, draw 2. Efficient cycling. |
| Inferno | Power | 1 | AoE on self-damage. Core for Bloodletting. |
| Breakthrough | Attack | 1 | -1 HP, 9 AoE. Cheap clear + self-damage. |
| Iron Wave | Attack | 1 | 5 Block + 5 damage. Balanced filler. |
| Uppercut | Attack | 2 | 13 damage + Weak + Vulnerable. Versatile. |
| Second Wind | Skill | 1 | Exhaust non-Attacks, gain Block each. Massive thin. |
| Dismantle | Attack | 1 | 8 damage, hits twice if Vulnerable. |
| Flame Barrier | Skill | 2 | 12 Block + retaliate vs multi-hit. |
| Rage | Skill | 0 | +3 Block per Attack this turn. Free defense. |
| Hemokinesis | Attack | 1 | -2 HP, 14 damage. Efficient + self-damage. |

### C-Tier (Situational, usually skip)

Anger, Bludgeon, Perfected Strike, Rampage, Sword Boomerang, Clash, Setup Strike.
These cards are either inefficient, anti-synergistic with deck thinning, or too situational.

## Weakness Categories

| Weakness | Diagnosis | Solution Cards |
|----------|-----------|----------------|
| No AoE | No multi-target damage | Whirlwind, Breakthrough, Conflagration, Thunderclap |
| No Scaling | No permanent damage increase | Demon Form, Rupture, Inflame, Dominate |
| No Block | Insufficient defense | Shrug It Off, Impervious, Blood Wall, Flame Barrier |
| No Draw | Relying on natural draw only | Offering, Battle Trance, Pommel Strike, Burning Pact |
| No Energy | Frequently energy-starved | Bloodletting, Offering, Expect a Fight |
| Deck Bloat | 22+ cards, inconsistent draws | Skip cards, prioritize card removal |
| No Vulnerable | Missing key debuff | Bash (upgrade), Tremble, Uppercut, Thunderclap |

A card that fixes a genuine weakness is worth taking even if it's not core to the archetype.

## Deck Size Rules

| Deck Size | Card Rewards | Shop Purchases | Card Removal |
|-----------|-------------|----------------|--------------|
| < 15 | Take good cards freely | Buy if fits build | Skip removal |
| 15–18 | Take if fits archetype or fixes weakness | Buy archetype core or S-tier only | Remove Strikes first |
| 18–22 | Take only if strong for build | Buy only critical missing piece | Remove Strikes then Defends |
| 22+ | Skip unless S-tier or critical gap | Almost always skip cards | High priority removal |

## Act-Specific Adjustments

| Act | Priority | Reasoning |
|-----|----------|-----------|
| Act 1 | Damage, AoE, draw, Vulnerable | Damage race. Kill fast. Take strong commons. |
| Act 2 | Scaling powers, archetype-defining cards | Longer fights. Build the engine. |
| Act 3+ | Extremely selective, skip marginal cards | Deck should be lean and consistent. |

## Upgrade Priority

When choosing a card to upgrade (Smith, Armaments, etc.):

### Tier 1 — Game-changing upgrades

| Card | Upgrade Effect | Why |
|------|---------------|-----|
| Bash | 2→3 Vulnerable | 50% more Vulnerable uptime |
| Body Slam | Cost 1→0 | Free damage every turn |
| Barricade | Cost 3→2 | Playable without energy relic |
| Corruption | Cost 3→2 | Same reason |
| Dark Embrace | Cost 2→1 | Playable turn 1 |
| Rupture | +1→+2 Str per trigger | Doubles scaling rate |
| Demon Form | +2→+3 Str/turn | 50% more scaling |

### Tier 2 — Strong upgrades

| Card | Upgrade Effect |
|------|---------------|
| Offering | Draw 3→5 |
| Shrug It Off | 8→11 Block |
| Impervious | 30→40 Block |
| Feel No Pain | 3→4 Block per Exhaust |
| Inflame | +2→+3 Strength |
| Blood Wall | 16→20 Block |
| Whirlwind | 5→8 per hit |

### Tier 3 — Decent upgrades

Most attacks (+damage), most skills (+block), Burning Pact (draw 2→3), True Grit (7→9 Block + choose instead of random).

### Never upgrade

Strike and Defend — remove them instead. Also skip cards you plan to remove soon.

## Relic Evaluation

### Universal High-Value Relics

| Relic | Tier | Why |
|-------|------|-----|
| Energy relics (Lantern, Ice Cream, etc.) | S | More energy = more cards = more power |
| Lizard Tail | S | Death prevention |
| Gambling Chip | A | Fix bad opening hands |
| Runic Pyramid | A | Perfect hand control |
| Bag of Preparation | A | +2 cards turn 1 |
| Snecko Eye | A | +2 draw (Confused is manageable) |

### Archetype-Specific Relics

| Archetype | High-Value Relics |
|-----------|-------------------|
| Strength | Vajra, Ruined Helmet, Brimstone, Sling of Courage, Shuriken |
| Block | Anchor, Horn Cleat, Cloak Clasp, Vambrace, Pael's Legion, Fresnel Lens |
| Exhaust | Charon's Ashes, Burning Sticks, Joss Paper, Forgotten Soul |
| Bloodletting | Centennial Puzzle, Demon Tongue, Self-Forming Clay, Ruined Helmet |
| Vulnerable | Paper Phrog, Bag of Marbles, Unsettling Lamp, Hand Drill |

## Gold Efficiency (Shop)

### Purchase Value Thresholds

| Purchase Type | Condition | Buy? |
|---------------|-----------|------|
| S-tier card | Any price | Always |
| Archetype core card | ≤ 150g, not already owned | Yes |
| Card removal | Any price, deck > 15 cards | Yes (see Removal Priority) |
| A-tier card (fits build) | ≤ 120g, fills a gap | Yes |
| Archetype-synergy relic | ≤ 200g | Yes |
| Universal relic (energy etc.) | ≤ 250g | Yes |
| Useful potion | ≤ 75g, boss in next 2-3 floors | Yes |
| B-tier card | ≤ 80g, critical weakness fix | Maybe |
| Non-synergy relic/card | Any price | Skip |

### Gold Budget by Act

| Act | Reserve | Strategy |
|-----|---------|----------|
| Act 1 | Keep ≥ 50g | Card removal + 1 core purchase max |
| Act 2 | Keep ≥ 75g | Build completion, 1-2 purchases |
| Act 3+ | Spend freely | No future shops guaranteed |

### Card Removal Priority (Shop)

1. **Curses** — always remove
2. **Strikes** — highest priority basic removal
3. **Defends** — next priority (skip if Block build)
4. **Status cards** stuck in deck
5. **Skip** if deck < 15 cards or all cards are useful

## Anti-Patterns

### Cards to Almost Never Take

- 3rd+ copy of any common (unless Shrug It Off)
- Expensive cards (3 energy) without energy support
- Cards that anti-synergize with current build
- Anger (deck bloat), Clash (unreliable), Perfected Strike (anti-thinning)

### Relic Traps

- Ectoplasm without strong deck already (no gold = no shop)
- Sozu if potions are still useful
- Philosopher's Stone vs scaling enemies
- Velvet Choker in high-card-count builds
