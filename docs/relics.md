# Relic Reference

> AI-optimized relic reference for Slay the Spire 2 combat decisions.
> Player's active relics are visible in game state -- check effects before each turn.
> Relics appear as `relics[]` in `player` state with id, name, description, rarity, status, and optional counter.

## How to Use This Reference

When you see a relic in the player's game state, look it up here to understand its combat effect.
Key things to check:
- **Energy relics**: Affect how many cards you can play (Lantern, Very Hot Cocoa, Ectoplasm, etc.)
- **Start-of-combat relics**: Provide opening advantages (Anchor, Bag of Preparation, Vajra, etc.)
- **Conditional triggers**: Fire when specific conditions are met (Kunai, Shuriken, Ornamental Fan, etc.)
- **Passive modifiers**: Always active during combat (Tungsten Rod, Paper Phrog, Strike Dummy, etc.)
- **Turn-specific relics**: Trigger on specific turns (Horn Cleat, Captain's Wheel, Candelabra, etc.)

## Ironclad Relics

Ironclad-specific relics (starter + character pool). The AI plays Ironclad exclusively.

| Name | Rarity | Description |
|------|--------|-------------|
| Black Blood | Starter | At the end of combat, heal 12 HP. |
| Brimstone | Shop | At the start of your turn, gain 2 Strength and ALL enemies gain 1 Strength. |
| Burning Blood | Starter | At the end of combat, heal 6 HP. |
| Charon's Ashes | Rare | Whenever you Exhaust a card, deal 3 damage to ALL enemies. |
| Demon Tongue | Rare | The first time you lose HP on your turn, heal HP equal to the amount lost. |
| Paper Phrog | Uncommon | Enemies with Vulnerable take 75% more damage rather than 50%. |
| Red Skull | Common | While your HP is at or below 50%, you have 3 additional Strength. |
| Ruined Helmet | Rare | The first time you gain Strength each combat, double the amount gained. |
| Self-Forming Clay | Uncommon | Whenever you lose HP in combat, gain 3 Block next turn. |

## Shared Relics

Available to all characters. These are the Common, Uncommon, Rare, and Shop relics from the main relic pool.

### Common

| Name | Rarity | Description |
|------|--------|-------------|
| Amethyst Aubergine | Common | Enemies drop 10 additional Gold. |
| Anchor | Common | Start each combat with 10 Block. |
| Bag of Preparation | Common | At the start of each combat, draw 2 additional cards. |
| Blood Vial | Common | At the start of each combat, heal 2 HP. |
| Book of Five Rings | Common | Every 5 cards you add to your Deck, heal 15 HP. |
| Bronze Scales | Common | Start each combat with 3 Thorns. |
| Centennial Puzzle | Common | The first time you lose HP each combat, draw 3 cards. |
| Festive Popper | Common | At the start of each combat, deal 9 damage to ALL enemies. |
| Gorget | Common | At the start of each combat, gain 4 Plating. |
| Happy Flower | Common | Every 3 turns, gain 1 Energy. |
| Juzu Bracelet | Common | Regular enemy combats are no longer encountered in ? rooms. |
| Lantern | Common | Start each combat with an additional 1 Energy. |
| Meal Ticket | Common | Whenever you enter a shop room, heal 15 HP. |
| Oddly Smooth Stone | Common | Start each combat with 1 Dexterity. |
| Pendulum | Common | Whenever you shuffle your Draw Pile, draw a card. |
| Permafrost | Common | The first time you play a Power each combat, gain 6 Block. |
| Potion Belt | Common | Upon pickup, gain 2 potion slots. |
| Regal Pillow | Common | Whenever you Rest, heal an additional 15 HP. |
| Strawberry | Common | Upon pickup, raise your Max HP by 7. |
| Strike Dummy | Common | Cards containing “Strike” deal 3 additional damage. |
| Tiny Mailbox | Common | Whenever you Rest, procure a random potion. |
| Vajra | Common | Start each combat with 1 Strength. |
| Venerable Tea Set | Common | Whenever you enter a Rest Site, start the next combat with an additional 2 Energy. |
| War Paint | Common | Upon pickup, Upgrade 2 random Skills. |
| Whetstone | Common | Upon pickup, Upgrade 2 random Attacks. |

### Uncommon

| Name | Rarity | Description |
|------|--------|-------------|
| Akabeko | Uncommon | At the start of each combat, gain 8 Vigor. |
| Bag of Marbles | Uncommon | At the start of each combat, apply 1 Vulnerable to ALL enemies. |
| Bellows | Uncommon | The first Hand you draw each combat is Upgraded. |
| Bowler Hat | Uncommon | Gain 20% additional Gold. |
| Candelabra | Uncommon | At the start of your 2nd turn, gain 2 Energy. |
| Eternal Feather | Uncommon | For every 5 cards in your Deck, heal 3 HP whenever you enter a Rest Site. |
| Gremlin Horn | Uncommon | Whenever an enemy dies, gain 1 Energy and draw 1 card. |
| Horn Cleat | Uncommon | At the start of your 2nd turn, gain 14 Block. |
| Joss Paper | Uncommon | Every 5 times you Exhaust a card, draw 1 card. |
| Kusarigama | Uncommon | Every time you play 3 Attacks in a single turn, deal 6 damage to a random enemy. |
| Letter Opener | Uncommon | Every time you play 3 Skills in a single turn, deal 5 damage to ALL enemies. |
| Lucky Fysh | Uncommon | Whenever you add a card to your Deck, gain 15 Gold. |
| Mercury Hourglass | Uncommon | At the start of your turn, deal 3 damage to ALL enemies. |
| Miniature Cannon | Uncommon | Upgraded Attacks deal 3 additional damage. |
| Nunchaku | Uncommon | Every time you play 10 Attacks, gain 1 Energy. |
| Orichalcum | Uncommon | If you end your turn without Block, gain 6 Block. |
| Ornamental Fan | Uncommon | Every time you play 3 Attacks in a single turn, gain 4 Block. |
| Pantograph | Uncommon | At the start of each Boss combat, heal 25 HP. |
| Parrying Shield | Uncommon | If you end a turn with at least 10 Block, deal 6 damage to a random enemy. |
| Pear | Uncommon | Upon pickup, raise your Max HP by 10. |
| Pen Nib | Uncommon | Every 10th Attack you play deals double damage. |
| Petrified Toad | Uncommon | At the start of each combat, procure a Potion-Shaped Rock. |
| Planisphere | Uncommon | Whenever you enter a ? room, heal 4 HP. |
| Red Mask | Uncommon | At the start of each combat, apply 1 Weak to ALL enemies. |
| Reptile Trinket | Uncommon | Whenever you use a potion, gain 3 Strength this turn. |
| Ripple Basin | Uncommon | If you did not play any Attacks during your turn, gain 4 Block. |
| Sparkling Rouge | Uncommon | At the start of your 3rd turn, gain 1 Strength and 1 Dexterity. |
| Stone Cracker | Uncommon | At the start of Boss combats, Upgrade 3 random cards in your Draw Pile for the rest of combat. |
| Tuning Fork | Uncommon | Every time you play 10 Skills, gain 7 Block. |
| Vambrace | Uncommon | The first time you gain Block from a card each combat, double the amount gained. |

### Rare

| Name | Rarity | Description |
|------|--------|-------------|
| Art of War | Rare | If you do not play any Attacks during your turn, gain an additional 1 Energy next turn. |
| Beating Remnant | Rare | You cannot lose more than 20 HP in a single turn. |
| Captain's Wheel | Rare | At the start of your 3rd turn, gain 18 Block. |
| Chandelier | Rare | At the start of your 3rd turn, gain 3 Energy. |
| Cloak Clasp | Rare | At the end of your turn, gain 1 Block for each card in your Hand. |
| Frozen Egg | Rare | Whenever you add a Power into your Deck, Upgrade it. |
| Gambling Chip | Rare | At the start of each combat, discard any number of cards then draw that many. |
| Game Piece | Rare | Whenever you play a Power, draw 1 card. |
| Girya | Rare | You can now gain Strength at Rest Sites. (3 times max) |
| Ice Cream | Rare | Energy is now conserved between turns. |
| Intimidating Helmet | Rare | Whenever you play a card that costs 2 Energy or more, gain 4 Block. |
| Kunai | Rare | Every time you play 3 Attacks in a single turn, gain 1 Dexterity. |
| Lasting Candy | Rare | Every other combat, your card rewards gain an additional Power. |
| Lizard Tail | Rare | When you would die, heal to 50% of your Max HP instead (works once). |
| Mango | Rare | Upon pickup, raise your Max HP by 14. |
| Meat on the Bone | Rare | If your HP is at or below 50% at the end of combat, heal 12 HP. |
| Molten Egg | Rare | Whenever you add an Attack card to your Deck, Upgrade it. |
| Mummified Hand | Rare | Whenever you play a Power, a random card in your Hand is free to play that turn. |
| Old Coin | Rare | Upon pickup, gain 300 Gold. |
| Pocketwatch | Rare | Whenever you play 3 or fewer cards during your turn, draw 3 additional cards at the start of your next turn. |
| Prayer Wheel | Rare | Normal enemies drop an additional card reward. |
| Rainbow Ring | Rare | The first time you play an Attack, Skill, and Power each turn, gain 1 Strength and 1 Dexterity. |
| Razor Tooth | Rare | Every time you play an Attack or Skill, Upgrade it for the remainder of combat. |
| Shovel | Rare | You can now dig at Rest Sites to obtain a random Relic. |
| Shuriken | Rare | Every time you play 3 Attacks in a single turn, gain 1 Strength. |
| Stone Calendar | Rare | At the end of turn 7, deal 52 damage to ALL enemies. |
| Sturdy Clamp | Rare | Up to 10 Block persists across turns. |
| The Courier | Rare | The merchant no longer runs out of cards, relics, or potions and his prices are reduced by 20%. |
| Toxic Egg | Rare | Whenever you add a Skill into your Deck, Upgrade it. |
| Tungsten Rod | Rare | Whenever you would lose HP, lose 1 less. |
| Unceasing Top | Rare | Whenever you have no cards in Hand during your turn, draw a card. |
| Unsettling Lamp | Rare | Each combat, the first time you play a card that Debuffs an enemy, double its effect. |
| Vexing Puzzlebox | Rare | At the start of each combat, add a random card into your Hand. It costs 0 Energy. |
| White Beast Statue | Rare | Potions always appear in combat rewards. |
| White Star | Rare | Elites drop an additional Rare card reward. |

### Shop

| Name | Rarity | Description |
|------|--------|-------------|
| Belt Buckle | Shop | While you have no potions, you have 2 additional Dexterity. |
| Bread | Shop | At the start of your first turn, lose 2 Energy. At the start of all other turns, gain 1 Energy. |
| Burning Sticks | Shop | The first time each combat you Exhaust a Skill, add a copy of it into your Hand. |
| Cauldron | Shop | Upon pickup, brews 5 random potions. |
| Chemical X | Shop | The effects of your cost X cards are increased by 2. |
| Dingy Rug | Shop | Card rewards can now contain Colorless cards. |
| Dolly's Mirror | Shop | Upon pickup, obtain an additional copy of a card in your Deck. |
| Dragon Fruit | Shop | Whenever you gain Gold, raise your Max HP by 1. |
| Ghost Seed | Shop | Strikes and Defends gain Ethereal. |
| Gnarled Hammer | Shop | Upon pickup, Enchant up to 3 Attacks with Sharp 3. |
| Kifuda | Shop | Upon pickup, Enchant up to 3 cards with Adroit. |
| Lava Lamp | Shop | At the end of combat, Upgrade all card rewards if you took no damage. |
| Lee's Waffle | Shop | Upon pickup, raise your Max HP by 7 and heal all of your HP. |
| Membership Card | Shop | 50% discount on all products! |
| Miniature Tent | Shop | You may choose any number of options at Rest Sites. |
| Mystic Lighter | Shop | Enchanted Attacks deal 9 additional damage. |
| Orrery | Shop | Upon pickup, gain 5 card rewards. |
| Punch Dagger | Shop | Upon pickup, Enchant an Attack with Momentum 5. |
| Ringing Triangle | Shop | Retain your Hand on the first turn of combat. |
| Royal Stamp | Shop | Upon pickup, choose an Attack or Skill in your Deck to Enchant with Royally Approved. |
| Screaming Flagon | Shop | If you end your turn with no cards in your Hand, deal 20 damage to ALL enemies. |
| Sling of Courage | Shop | Start each Elite combat with 2 Strength. |
| The Abacus | Shop | Whenever you shuffle your Draw Pile, gain 6 Block. |
| Toolbox | Shop | At the start of each combat, choose 1 of 3 random Colorless cards and add the chosen card into your Hand. |
| Wing Charm | Shop | A random card in each card reward is Enchanted with Swift 1. |

## Event and Ancient Relics

Obtained from events, treasures, and special encounters. Includes Ancient (highest tier) and Event relics.

### Ancient Relics

| Name | Rarity | Description |
|------|--------|-------------|
| Alchemical Coffer | Ancient | Upon pickup, gain 4 potion slots filled with random potions. |
| Arcane Scroll | Ancient | Upon pickup, obtain a random Rare Card to add to your Deck. |
| Archaic Tooth | Ancient | Upon pickup, Transform a starter card with an ancient version. |
| Astrolabe | Ancient | Upon pickup, Transform 3 cards, then Upgrade them. |
| Beautiful Bracelet | Ancient | Upon pickup, choose 3 cards in your Deck. Enchant them with Swift 3. |
| Biiig Hug | Ancient | Upon pickup, remove 4 cards from your Deck. Whenever you shuffle your Draw Pile, add a Soot into your Draw Pile. |
| Black Star | Ancient | Elites drop an additional Relic when defeated. |
| Blessed Antler | Ancient | Gain 1 Energy at the start of each turn. At the start of each combat, shuffle 3 Dazed into your Draw Pile. |
| Blood-Soaked Rose | Ancient | Upon pickup, add 1 Enthralled to your Deck. Gain 1 Energy at the start of each turn. |
| Booming Conch | Ancient | At the start of Elite combats, draw 2 additional cards. |
| Brilliant Scarf | Ancient | The 5th card you play each turn is free. |
| Calling Bell | Ancient | Upon pickup, obtain a unique Curse and 3 Relics. |
| Choices Paradox | Ancient | At the start of each combat, add 1 of 5 random cards into your Hand. Add Retain to the chosen card. |
| Claws | Ancient | Upon pickup, Transform up to 6 cards into Maul. |
| Crossbow | Ancient | At the start of your turn, add a random Attack into your Hand. It costs 0 Energy this turn. |
| Cursed Pearl | Ancient | Upon pickup, receive Greed. Gain 333 Gold. |
| Delicate Frond | Ancient | At the start of each combat, fill all empty potion slots with random potions. |
| Diamond Diadem | Ancient | Whenever you play 2 or fewer cards in a turn, take half damage from enemies. |
| Distinguished Cape | Ancient | Upon pickup, lose 9 Max HP. Add 3 Apparitions to your Deck. |
| Driftwood | Ancient | You may reroll each card reward once. |
| Dusty Tome | Ancient | Upon pickup, obtain an Ancient Card. |
| Ectoplasm | Ancient | You can no longer gain Gold. Gain 1 Energy at the start of each turn. |
| Electric Shrymp | Ancient | Upon pickup, Enchant a Skill with Imbued. |
| Empty Cage | Ancient | Upon pickup, remove 2 cards from your Deck. |
| Fiddle | Ancient | At the start of each turn, draw 2 additional cards. You may not draw cards during your turn. |
| Fur Coat | Ancient | Upon pickup, mark 7 random combats. Enemies in those rooms have 1 HP. |
| Glass Eye | Ancient | Upon pickup, obtain 2 Common cards, 2 Uncommon cards, and 1 Rare card. |
| Glitter | Ancient | Enchant all card rewards with Glam. |
| Golden Compass | Ancient | Upon pickup, replace the Act 2 Map with a single special path. |
| Golden Pearl | Ancient | Upon pickup, gain 150 Gold. |
| Iron Club | Ancient | Every 4 cards you play, draw 1 card. |
| Jeweled Mask | Ancient | At the start of combat put a random Power from your Draw Pile into your Hand, it's free to play. |
| Jewelry Box | Ancient | Upon pickup, add 1 Apotheosis to your Deck. |
| Large Capsule | Ancient | Upon pickup, obtain 2 random Relics. Add an additional Strike and Defend to your Deck. |
| Lava Rock | Ancient | The Act 1 Boss drops 2 Relics. |
| Lead Paperweight | Ancient | Upon pickup, choose 1 of 2 Colorless cards to add to your Deck. |
| Leafy Poultice | Ancient | Upon pickup, Transform 1 of your Strikes and 1 of your Defends and lose 10 Max HP. |
| Looming Fruit | Ancient | Upon pickup, raise your Max HP by 31. |
| Lord's Parasol | Ancient | When you encounter the Merchant, immediately obtain EVERYTHING he sells. |
| Lost Coffer | Ancient | Upon pickup, gain 1 card reward and procure 1 random potion. |
| Massive Scroll | Ancient | Upon pickup, choose 1 of 3 Multiplayer Colorless Cards to add to your Deck. |
| Meat Cleaver | Ancient | You may Cook at Rest Sites. |
| Music Box | Ancient | Create an Ethereal copy of the first Attack you play each turn. |
| Neow's Torment | Ancient | Upon pickup, add 1 Neow's Fury to your Deck. |
| New Leaf | Ancient | Upon pickup, Transform 1 card. |
| Nutritious Oyster | Ancient | Upon pickup, raise your Max HP by 11. |
| Nutritious Soup | Ancient | Upon pickup, Enchant all Strikes in your Deck with Tezcatara's Ember. |
| Pael's Blood | Ancient | At the start of your turn, draw 1 additional card. |
| Pael's Claw | Ancient | Upon pickup, Enchant all Defends with Goopy. |
| Pael's Eye | Ancient | The first time each combat you end your turn without playing cards, Exhaust your Hand, and take an extra turn. |
| Pael's Flesh | Ancient | Gain an additional 1 Energy at the start of your 3rd turn, and every turn after that. |
| Pael's Growth | Ancient | Upon pickup, Enchant a card with Clone 4. You may Clone cards at Rest Sites. |
| Pael's Horn | Ancient | Upon pickup, add 2 Relax to your Deck. |
| Pael's Legion | Ancient | Doubles Block gained from a card, then goes to sleep for 2 turns. |
| Pael's Tears | Ancient | If you end your turn with unspent 1 Energy, gain an additional 2 Energy next turn. |
| Pael's Tooth | Ancient | Upon pickup, remove 5 cards from your Deck. After each combat, randomly add 1 back Upgraded. |
| Pael's Wing | Ancient | You may sacrifice card rewards to Pael. Every 2 sacrifices, obtain a Relic. |
| Pandora's Box | Ancient | Transform ALL Strikes and Defends. |
| Philosopher's Stone | Ancient | Gain 1 Energy at the start of each turn. ALL enemies start combat with 1 Strength. |
| Pomander | Ancient | Upon pickup, Upgrade a card. |
| Precarious Shears | Ancient | Upon pickup, remove 2 cards from your Deck and take 13 damage. |
| Precise Scissors | Ancient | Upon pickup, remove 1 card from your Deck. |
| Preserved Fog | Ancient | Upon pickup, remove 5 cards from your Deck. Add Folly to your Deck. |
| Prismatic Gem | Ancient | Gain 1 Energy at the start of each turn. Card rewards now contain cards from other colors. |
| Pumpkin Candle | Ancient | Gain 1 Energy at the start of each turn. Extinguishes at the start of Act 3. |
| Radiant Pearl | Ancient | At the start of each combat, add 1 Luminesce into your Hand. |
| Runic Pyramid | Ancient | At the end of your turn, you no longer discard your Hand. |
| Sai | Ancient | At the start of your turn, gain 7 Block. |
| Sand Castle | Ancient | Upon pickup, Upgrade 6 random cards. |
| Scroll Boxes | Ancient | Upon pickup, lose all Gold and choose 1 of 2 packs of cards to add to your Deck. |
| Sea Glass | Ancient | See 15 cards from another character. Choose any number of them to add to your Deck. |
| Seal of Gold | Ancient | At the start of your turn, spend 5 Gold to gain 1 Energy. |
| Sere Talon | Ancient | Upon pickup, add 2 random Curses and 3 Wishes to your Deck. |
| Signet Ring | Ancient | Upon pickup, gain 999 Gold. |
| Silver Crucible | Ancient | The first 3 card rewards you see are Upgraded. The first Treasure Chest you open is empty. |
| Small Capsule | Ancient | Upon pickup, obtain a random Relic. |
| Snecko Eye | Ancient | At the start of your turn, draw 2 additional cards. Start each combat Confused. |
| Sozu | Ancient | Gain 1 Energy at the start of each turn. You can no longer obtain potions. |
| Spiked Gauntlets | Ancient | Gain 1 Energy at the start of each turn. Powers cost 1 more Energy. |
| Stone Humidifier | Ancient | Whenever you Rest at a Rest Site, raise your Max HP by 5. |
| Storybook | Ancient | Upon pickup, add 1 Brightest Flame to your Deck. |
| Tanx's Whistle | Ancient | Upon pickup, add 1 Whistle to your Deck. |
| Throwing Axe | Ancient | The first card you play each combat is played an extra time. |
| Toasty Mittens | Ancient | At the start of your turn, Exhaust the top card of your Draw Pile and gain 1 Strength. |
| Touch of Orobas | Ancient | Upon pickup, replace your starter Relic with an Ancient version. |
| Toy Box | Ancient | Upon pickup, obtain 4 Wax Relics. Every 3 combats, your left-most Wax Relic will melt away. |
| Tri-Boomerang | Ancient | Choose 3 Attacks in your Deck. Enchant them with Instinct. |
| Velvet Choker | Ancient | Gain 1 Energy at the start of each turn. You cannot play more than 6 cards per turn. |
| Very Hot Cocoa | Ancient | Start each combat with an additional 4 Energy. |
| War Hammer | Ancient | Whenever you kill an Elite, Upgrade 4 random cards. |
| Whispering Earring | Ancient | Gain 1 Energy at the start of each turn. Vakuu plays your first turn for you. |
| Yummy Cookie | Ancient | Upon pickup, Upgrade 4 cards. |

### Event Relics

| Name | Rarity | Description |
|------|--------|-------------|
| Anchor??? | Event | Start each combat with 4 Block. |
| Big Mushroom | Event | Upon pickup, raise your Max HP by 20. At the start of each combat, draw 2 fewer cards. |
| Bing Bong | Event | Whenever you add a card to your Deck, add one additional copy. |
| Blood Vial??? | Event | At the start of each combat, heal 1 HP. |
| Bone Tea | Event | At the start of the next 2 combats, Upgrade your starting hand. |
| Byrdpip | Event | Upon pickup, gain the card Byrd Swoop. A Byrdpip will accompany you in battles. |
| Darkstone Periapt | Event | Whenever you obtain a Curse, raise your Max HP by 6. |
| Daughter of the Wind | Event | Whenever you play an Attack, gain 1 Block. |
| Dream Catcher | Event | Whenever you Rest, you may add a card to your Deck. |
| Ember Tea | Event | At the start of the next 2 combats, gain 2 Strength. |
| Forgotten Soul | Event | Whenever you Exhaust a card, deal 1 damage to a random enemy. |
| Fragrant Mushroom | Event | Upon pickup, lose 15 HP and Upgrade 3 random cards. |
| Fresnel Lens | Event | Whenever you add a card that gains Block to your Deck, Enchant it with Nimble 2. |
| Hand Drill | Event | Whenever you break an enemy's Block, apply 2 Vulnerable. |
| Happy Flower??? | Event | Every 5 turns, gain 1 Energy. |
| History Course | Event | At the start of your turn, play a copy of your last played Attack or Skill. |
| Lee's Waffle??? | Event | Upon pickup, heal 10% of your HP. |
| Lost Wisp | Event | Whenever you play a Power, deal 8 damage to ALL enemies. |
| Mango??? | Event | Upon pickup, raise your Max HP by 3. |
| Maw Bank | Event | Whenever you climb a floor, gain 12 Gold. No longer works when you spend any Gold at the shop. |
| Mr. Struggles | Event | At the start of your turn, deal damage equal to the turn number to ALL enemies. |
| Orichalcum??? | Event | If you end your turn without Block, gain 3 Block. |
| Pollinous Core | Event | Every 4 turns, draw 2 additional cards. |
| Royal Poison | Event | At the start of each combat, lose 4 HP. |
| Snecko Eye??? | Event | Start each combat Confused. |
| Strike Dummy??? | Event | Cards containing “Strike” deal 1 additional damage. |
| Sword of Jade | Event | Start each combat with 3 Strength. |
| Sword of Stone | Event | Transforms into a powerful Relic after defeating 5 Elites. |
| Tea of Discourtesy | Event | At the start of the next combat, shuffle 2 Dazed into your Draw Pile. |
| The Boot | Event | Whenever you would deal 4 or less unblocked attack damage, increase it to 5. |
| The Chosen Cheese | Event | At the end of combat, gain 1 Max HP. |
| The Merchant's Rug??? | Event | Poor imitation. Does nothing. |
| Venerable Tea Set??? | Event | Whenever you enter a Rest Site, start the next combat with an additional 1 Energy. |
| Wongo Customer Appreciation Badge | Event | Does nothing. |
| Wongo's Mystery Ticket | Event | Receive 3 random Relics after 5 combats. |

### Starter Relics (other characters)

These may appear in game state if using Touch of Orobas or other transformation effects.

| Name | Rarity | Description |
|------|--------|-------------|

## Other Character Relics

These belong to other character pools but may appear through Prismatic Gem or multiplayer.

### Silent

| Name | Rarity | Description |
|------|--------|-------------|
| Helical Dart | Rare | Whenever you play a Shiv, gain 1 Dexterity this turn. |
| Ninja Scroll | Shop | At the start of each combat, add 3 Shivs into your Hand. |
| Paper Krane | Rare | Enemies with Weak deal 40% less damage to you rather than 25%. |
| Ring of the Drake | Starter | At the start of your first 3 turns, draw 2 additional cards. |
| Ring of the Snake | Starter | At the start of each combat, draw 2 additional cards. |
| Snecko Skull | Common | Whenever you apply Poison, apply an additional 1 Poison. |
| Tingsha | Uncommon | Whenever you discard a card during your turn, deal 3 damage to a random enemy for each card discarded. |
| Tough Bandages | Rare | Whenever you discard a card during your turn, gain 3 Block. |
| Twisted Funnel | Uncommon | At the start of each combat, apply 4 Poison to ALL enemies. |

### Defect

| Name | Rarity | Description |
|------|--------|-------------|
| Cracked Core | Starter | At the start of each combat, Channel 1 Lightning. |
| Data Disk | Common | Start each combat with 1 Focus. |
| Emotion Chip | Rare | If you lost HP during the previous turn, trigger the passive ability of all Orbs at the start of your turn. |
| Gold-Plated Cables | Uncommon | Your rightmost Orb triggers its passive an additional time. |
| Infused Core | Starter | At the start of each combat, Channel 3 Lightning. |
| Metronome | Rare | The first time you Channel 7 Orbs each combat, deal 30 damage to ALL enemies. |
| Power Cell | Rare | At the start of each combat, add 2 zero-cost cards from your Draw Pile into your Hand. |
| Runic Capacitor | Shop | Start each combat with 3 additional Orb Slots. |
| Symbiotic Virus | Uncommon | At the start of each combat, Channel 1 Dark. |

### Necrobinder

| Name | Rarity | Description |
|------|--------|-------------|
| Big Hat | Rare | At the start of each combat, add 2 random Ethereal cards into your Hand. |
| Bone Flute | Common | Whenever Osty attacks, gain 2 Block. |
| Book Repair Knife | Uncommon | Whenever a non-Minion enemy dies to Doom, heal 3 HP. |
| Bookmark | Rare | At the end of each turn, lower the cost of a random Retained card by 1 until played. |
| Bound Phylactery | Starter | At the start of your turn, Summon 1. |
| Funerary Mask | Uncommon | At the start of each combat, add 3 Souls into your Draw Pile. |
| Ivory Tile | Rare | Whenever you play a card that costs 3 Energy or more, gain 1 Energy. |
| Phylactery Unbound | Starter | At the start of each combat, Summon 5. At the start of your turn, Summon 2. |
| Undying Sigil | Shop | Enemies with at least as much Doom as HP deal 50% less damage. |

### Regent

| Name | Rarity | Description |
|------|--------|-------------|
| Divine Destiny | Starter | At the start of each combat, gain 6 Stars. |
| Divine Right | Starter | At the start of each combat, gain 3 Stars. |
| Fencing Manual | Common | At the start of each combat, Forge 10. |
| Galactic Dust | Uncommon | For every 10 Stars spent, gain 10 Block. |
| Lunar Pastry | Rare | At the end of your turn, gain 1 Stars. |
| Mini Regent | Rare | The first time you spend Stars each turn, gain 1 Strength. |
| Orange Dough | Rare | At the start of each combat, add 2 random Colorless cards into your Hand. |
| Regalite | Uncommon | Whenever you create a Colorless card, gain 2 Block. |
| Vitruvian Minion | Shop | Cards containing “Minion” deal double damage and gain double Block. |

## Combat-Critical Relic Quick Reference

Relics that directly change how you should play each turn.

### Energy Modifiers
| Relic | Effect |
|-------|--------|
| Lantern | +1 Energy turn 1 |
| Very Hot Cocoa | +4 Energy turn 1 |
| Candelabra | +2 Energy on turn 2 |
| Chandelier | +3 Energy on turn 3 |
| Happy Flower | +1 Energy every 3 turns |
| Ice Cream | Unspent Energy carries over |
| Bread | -2 Energy turn 1, +1 Energy other turns |
| Art of War | +1 Energy next turn if no Attacks played |
| Velvet Choker | +1 Energy but max 6 cards per turn |
| Ectoplasm | +1 Energy (no Gold gain) |
| Sozu | +1 Energy (no potions) |
| Blessed Antler | +1 Energy (3 Dazed in draw pile) |
| Blood-Soaked Rose | +1 Energy (Enthralled in deck) |
| Philosopher's Stone | +1 Energy (enemies start with 1 Strength) |
| Prismatic Gem | +1 Energy (mixed card rewards) |
| Pumpkin Candle | +1 Energy (expires Act 3) |
| Spiked Gauntlets | +1 Energy (Powers cost 1 more) |
| Whispering Earring | +1 Energy (Vakuu plays turn 1) |
| Pael's Flesh | +1 Energy from turn 3 onward |
| Pael's Tears | +2 Energy next turn if unspent Energy |
| Gremlin Horn | +1 Energy per enemy kill |
| Seal of Gold | Spend 5 Gold for 1 Energy each turn |
| Nunchaku | +1 Energy every 10 Attacks |

### Play-Count Triggers (track cards played)
| Relic | Trigger | Effect |
|-------|---------|--------|
| Kunai | 3 Attacks in a turn | +1 Dexterity |
| Shuriken | 3 Attacks in a turn | +1 Strength |
| Ornamental Fan | 3 Attacks in a turn | +4 Block |
| Kusarigama | 3 Attacks in a turn | 6 damage to random enemy |
| Letter Opener | 3 Skills in a turn | 5 damage to ALL enemies |
| Rainbow Ring | 1 Attack + 1 Skill + 1 Power in a turn | +1 Strength and +1 Dexterity |
| Brilliant Scarf | 5th card played | Free |
| Diamond Diadem | 2 or fewer cards played | Half damage from enemies |
| Pocketwatch | 3 or fewer cards played | Draw 3 extra next turn |
| Pen Nib | Every 10th Attack | Double damage |
| Velvet Choker | Max 6 cards per turn | Cannot play more |

### Damage Reduction / Survival
| Relic | Effect |
|-------|--------|
| Tungsten Rod | Lose 1 less HP whenever you lose HP |
| Beating Remnant | Cannot lose more than 20 HP per turn |
| Lizard Tail | Heal to 50% Max HP instead of dying (once) |
| Sturdy Clamp | Up to 10 Block persists across turns |
| Self-Forming Clay | Gain 3 Block next turn when you lose HP |
| Demon Tongue | First HP loss on your turn is healed back |
| The Boot | Minimum 5 unblocked attack damage |
| Toasty Mittens | Exhaust top card of draw pile, gain 1 Strength each turn |

### Block / Defense
| Relic | Effect |
|-------|--------|
| Anchor | 10 Block at combat start |
| Orichalcum | 6 Block if you end turn with 0 Block |
| Horn Cleat | 14 Block at start of turn 2 |
| Captain's Wheel | 18 Block at start of turn 3 |
| Cloak Clasp | 1 Block per card in hand at end of turn |
| Sai | 7 Block at start of each turn |
| Gorget | 4 Plating at combat start |
| The Abacus | 6 Block when draw pile shuffles |
| Ripple Basin | 4 Block if no Attacks played |
| Parrying Shield | 6 damage to random enemy if 10+ Block at end of turn |

### Strength / Damage Buffs
| Relic | Effect |
|-------|--------|
| Vajra | +1 Strength at combat start |
| Red Skull | +3 Strength while HP <= 50% |
| Ruined Helmet | Double first Strength gain each combat |
| Sling of Courage | +2 Strength at Elite combat start |
| Brimstone | +2 Strength per turn (enemies +1) |
| Strike Dummy | Strikes deal +3 damage |
| Miniature Cannon | Upgraded Attacks deal +3 damage |
| Paper Phrog | Vulnerable = 75% more damage (instead of 50%) |
| Bag of Marbles | 1 Vulnerable to ALL enemies at combat start |
| Red Mask | 1 Weak to ALL enemies at combat start |
| Unsettling Lamp | First debuff each combat is doubled |
