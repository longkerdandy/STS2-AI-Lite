# Potion Reference

> AI-optimized potion reference for Slay the Spire 2 combat decisions.
> Potions are used via `./sts2 use_potion <slot> [--target <combat_id>]`.

## Targeting Rules

| Target Type | CLI Usage | Description |
|---|---|---|
| Self | `./sts2 use_potion <slot>` | No target needed |
| Enemy | `./sts2 use_potion <slot> --target <id>` | Must specify enemy `combat_id` |
| All | `./sts2 use_potion <slot>` | Hits all enemies, no target needed |

## Combat Potions (Offensive)

Potions that deal damage, apply debuffs, or buff offensive stats.

| Name | Rarity | Target | Description |
|---|---|---|---|
| Beetle Juice | Rare | Enemy | Enemy's attacks deal 30% less damage for the next 4 turns. |
| Duplicator | Uncommon | Self | This turn, your next card is played an extra time. |
| Explosive Ampoule | Common | All | Deal 10 damage to ALL enemies. |
| Fire Potion | Common | Enemy | Deal 20 damage. |
| Flex Potion | Common | Self | Gain 5 Strength. At the end of your turn, lose 5 Strength. |
| Foul Potion | Event | All | Deal 12 damage to EVERYONE (including yourself). |
| Gigantification Potion | Rare | Self | The next Attack you play deals triple damage. |
| Mazaleth's Gift | Rare | Self | Gain 1 Ritual (gain Strength at the start of each turn). |
| Poison Potion | Common | Enemy | Apply 6 Poison. (Silent pool) |
| Potion of Binding | Uncommon | All | Apply 1 Weak and 1 Vulnerable to ALL enemies. |
| Potion of Doom | Common | Enemy | Apply 33 Doom. (Necrobinder pool) |
| Potion-Shaped Rock | Token | Enemy | Deal 15 damage. |
| Powdered Demise | Uncommon | Enemy | Enemy loses 9 HP at the end of each of its turns. |
| Shackling Potion | Rare | All | ALL enemies lose 7 Strength this turn. |
| Soldier's Stew | Rare | Self | All cards containing Strike gain 1 Replay this combat. (Ironclad pool) |
| Strength Potion | Common | Self | Gain 2 Strength. |
| Vulnerable Potion | Common | Enemy | Apply 3 Vulnerable. |
| Weak Potion | Common | Enemy | Apply 3 Weak. |

## Combat Potions (Defensive)

Potions that provide Block, healing, HP, or defensive buffs.

| Name | Rarity | Target | Description |
|---|---|---|---|
| Block Potion | Common | Self | Gain 12 Block. |
| Blood Potion | Common | Self | Heal for 20% of your Max HP. (Ironclad pool, usable anytime) |
| Dexterity Potion | Common | Self | Gain 2 Dexterity. |
| Fairy in a Bottle | Rare | Self | When you would die, this potion is automatically discarded and you heal to 30% of your Max HP. (Automatic, not manually used) |
| Fortifier | Uncommon | Self | Triple your Block. |
| Fruit Juice | Rare | Self | Gain 5 Max HP. (Usable anytime) |
| Fysh Oil | Uncommon | Self | Gain 1 Strength and 1 Dexterity. |
| Ghost in a Jar | Rare | Self | Gain 1 Intangible. (Silent pool) |
| Heart of Iron | Uncommon | Self | Gain 7 Plating (gain Block at end of each turn). |
| Liquid Bronze | Uncommon | Self | Gain 3 Thorns. |
| Lucky Tonic | Rare | Self | Gain 1 Buffer (negate next HP loss instance). |
| Regen Potion | Uncommon | Self | Gain 5 Regen. |
| Ship in a Bottle | Rare | Self | Gain 10 Block. Next turn, gain 10 Block. |
| Speed Potion | Common | Self | Gain 5 Dexterity. At the end of your turn, lose 5 Dexterity. |

## Utility Potions

Potions that provide energy, card draw, card generation, or hand manipulation.

| Name | Rarity | Target | Description |
|---|---|---|---|
| Ashwater | Uncommon | Self | Exhaust any number of cards in your Hand. (Ironclad pool) |
| Attack Potion | Common | Self | Choose 1 of 3 random Attack cards to add into your Hand. It's free to play this turn. |
| Blessing of the Forge | Uncommon | Self | Upgrade all cards in your Hand for the rest of combat. |
| Bottled Potential | Rare | Self | Shuffle ALL your cards into your Draw Pile. Draw 5 cards. |
| Clarity Extract | Uncommon | Self | Draw 1 card. At the start of your next 3 turns, draw 1 additional card. |
| Colorless Potion | Common | Self | Choose 1 of 3 random Colorless cards to add into your Hand. It's free to play this turn. |
| Cure All | Uncommon | Self | Gain 1 Energy. Draw 2 cards. |
| Distilled Chaos | Rare | Self | Play the top 3 cards of your Draw Pile. |
| Droplet of Precognition | Rare | Self | Choose a card in your Draw Pile and add it into your Hand. |
| Energy Potion | Common | Self | Gain 2 Energy. |
| Entropic Brew | Rare | Self | Fill all your empty potion slots with random potions. (Usable anytime) |
| Gambler's Brew | Uncommon | Self | Discard any number of cards, then draw that many. |
| Glowwater Potion | Event | Self | Exhaust your Hand. Draw 10 cards. |
| Liquid Memories | Rare | Self | Put a card from your Discard Pile into your Hand. It costs 0 this turn. |
| Orobic Acid | Rare | Self | Add a random Attack, Skill, and Power into your Hand. They're free to play this turn. |
| Power Potion | Common | Self | Choose 1 of 3 random Power cards to add into your Hand. It's free to play this turn. |
| Radiant Tincture | Uncommon | Self | Gain 1 Energy. Gain an additional 1 Energy at the start of your next 3 turns. |
| Skill Potion | Common | Self | Choose 1 of 3 random Skill cards to add into your Hand. It's free to play this turn. |
| Snecko Oil | Rare | Self | Draw 7 cards. Randomize the cost of cards in your Hand this turn. |
| Stable Serum | Uncommon | Self | Retain your Hand for 2 turns. |
| Swift Potion | Common | Self | Draw 3 cards. |
| Touch of Insanity | Uncommon | Self | Choose a card in your Hand. It is free to play this combat. |

## Character-Specific Pool Notes

Ironclad can encounter potions from the **Shared pool** plus the **Ironclad pool**:

- **Ironclad pool**: Ashwater, Blood Potion, Soldier's Stew
- **Silent pool**: Cunning Potion, Ghost in a Jar, Poison Potion (Ironclad will NOT see these)
- **Defect pool**: Essence of Darkness, Focus Potion, Potion of Capacity (Ironclad will NOT see these)
- **Necrobinder pool**: Bone Brew, Pot of Ghouls, Potion of Doom (Ironclad will NOT see these)
- **Regent pool**: Cosmic Concoction, King's Courage, Star Potion (Ironclad will NOT see these)

Event and Token potions (Foul Potion, Glowwater Potion, Potion-Shaped Rock) can appear for any character through special sources.

## AI Decision Notes

- Potions marked **(Automatic)** cannot be manually used (Fairy in a Bottle triggers on death).
- Potions marked **(Usable anytime)** work outside combat too, but the CLI only supports combat use.
- **Fortifier** triples existing Block -- use after playing Block cards, not before.
- **Flex Potion / Speed Potion** give temporary buffs lost at end of turn -- use before playing Attack/Skill cards.
- **Duplicator** doubles the next card played -- pair with high-impact cards.
- **Gigantification Potion** triples the next Attack's damage -- pair with highest base damage Attack.
- **Foul Potion** damages EVERYONE including the player.
- Potions that generate card choices (Attack/Skill/Power/Colorless Potion) require player selection which the CLI may not support -- prefer potions with deterministic effects.
