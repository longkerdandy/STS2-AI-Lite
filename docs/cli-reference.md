# STS2 CLI Reference

Command-line interface for interacting with Slay the Spire 2 via the STS2-Cli-Mod.

## Commands

### ping

```
./sts2 ping
```

Test connection to the mod. Returns `{"ok": true}` on success.

### state

```
./sts2 state
```

Get current game state. Returns screen type, combat details, player info, hand, and enemies.

### play_card

```
./sts2 play_card <index> [--target <combat_id>]
```

Play a card from hand by **0-based index**. `--target` is required for cards with `target_type` that needs an enemy (e.g., `ENEMY`). Omit `--target` for self-targeting or area cards.

### end_turn

```
./sts2 end_turn
```

End the current turn. The response contains all enemy action results (damage dealt, buffs applied, etc.).

### use_potion

```
./sts2 use_potion <slot> [--target <combat_id>]
```

Use a potion by **0-based belt slot**. `--target` required for enemy-targeting potions.

### claim_reward

```
./sts2 claim_reward <index>
```

Claim a non-card reward by **0-based index** in the reward list. Works for Gold, Potion, Relic, and SpecialCard rewards. For card rewards, use `choose_card` instead (returns `USE_CHOOSE_CARD` error if attempted on a card reward).

### choose_card

```
./sts2 choose_card <reward_index> <card_index>
```

Pick a specific card from a card reward. `reward_index` is the reward's position in the reward list (0-based). `card_index` is the card's position in the card choices (0-based, typically 0-2). The card is added directly to the deck.

### skip_card

```
./sts2 skip_card <reward_index>
```

Skip a card reward — take nothing. `reward_index` is the card reward's position in the reward list.

### proceed

```
./sts2 proceed
```

Leave the reward screen and proceed to the map. Any unclaimed rewards are automatically skipped.

## Exit Codes

| Code | Meaning |
|------|---------|
| 0 | Success |
| 1 | Connection error (game not running, mod not loaded) |
| 2 | Invalid game state (not in combat, not on reward screen, combat ending, not player turn) |
| 3 | Invalid parameter (bad index, missing target, unknown command) |
| 4 | Timeout (action did not complete in time) |
| 5 | State changed (concurrent modification) |

## Response Format

**Success:**

```json
{"ok": true, "data": { ... }}
```

**Error:**

```json
{"ok": false, "error": "ERROR_CODE", "message": "Human-readable description"}
```

## Game State Structure

Returned by `./sts2 state` in the `data` field.

```
data
├── screen              # "COMBAT", "REWARD", "CARD_REWARD", "MAP", "MENU", "UNKNOWN"
├── timestamp           # Unix timestamp (ms)
├── combat              # null when not in combat
│   ├── encounter       # encounter ID (e.g., "jaw_worm")
│   ├── turn_number     # 1-indexed
│   ├── is_player_turn
│   ├── is_player_actions_disabled
│   ├── is_combat_ending
│   ├── player
│   │   ├── character_id, character_name
│   │   ├── hp, max_hp, block, energy, max_energy
│   │   ├── gold, deck_count
│   │   ├── hand_count, draw_count, discard_count, exhaust_count
│   │   ├── relics[]
│   │   ├── potions[]
│   │   ├── powers[]
│   │   ├── pets[]?          # Necrobinder only
│   │   ├── orbs[]?          # Defect only
│   │   ├── orb_slots?       # Defect only
│   │   └── stars?           # Regent only
│   ├── hand[]
│   └── enemies[]
└── rewards             # null when not on reward screen
    └── rewards[]       # Array of reward items
```

### Player Fields

| Field | Type | Description |
|-------|------|-------------|
| `character_id` | string | e.g., `"ironclad"` |
| `hp`, `max_hp` | int | Current and maximum health |
| `block` | int | Current block (damage reduction) |
| `energy`, `max_energy` | int | Current and max energy for this turn |
| `gold` | int | Gold count |
| `deck_count` | int | Total cards in deck |
| `hand_count` | int | Cards currently in hand |
| `draw_count` | int | Cards in draw pile |
| `discard_count` | int | Cards in discard pile |
| `exhaust_count` | int | Cards exhausted this combat |

### Relic Object

```json
{"id": "string", "name": "string", "description": "string", "rarity": "string", "status": "string", "counter": 0}
```

`counter` is optional -- only present for relics that track usage.

### Potion Object

```json
{"slot": 0, "id": "string", "name": "string", "description": "string", "rarity": "string", "usage": "string", "target_type": "string"}
```

### Power Object

```json
{"id": "string", "name": "string", "amount": 0, "type": "string", "stack_type": "string", "description": "string"}
```

### Card Object (in hand)

| Field | Type | Description |
|-------|------|-------------|
| `index` | int | 0-based position in hand |
| `id` | string | Card identifier |
| `name` | string | Display name |
| `description` | string | Card effect text |
| `type` | string | `ATTACK`, `SKILL`, `POWER`, `STATUS`, `CURSE` |
| `rarity` | string | `BASIC`, `COMMON`, `UNCOMMON`, `RARE`, `SPECIAL`, `CURSE` |
| `target_type` | string | `ENEMY`, `ALL_ENEMY`, `SELF`, `NONE`, etc. |
| `cost` | int | Energy cost |
| `star_cost` | int? | Star cost (Regent only) |
| `keywords` | string[] | Keywords like `Exhaust`, `Ethereal`, `Retain`, `Innate` |
| `tags` | string[] | Additional tags |
| `damage` | int? | Preview damage (after all modifiers) |
| `block` | int? | Preview block (after all modifiers) |
| `enchantment` | object? | Enchantment details |
| `affliction` | object? | Affliction details |
| `is_upgraded` | bool | Whether the card is upgraded |
| `can_play` | bool | Whether the card can be played right now |
| `unplayable_reason` | string? | Why the card can't be played |

### Enemy Object

| Field | Type | Description |
|-------|------|-------------|
| `combat_id` | int | Stable target ID for `--target` parameter |
| `id` | string | Enemy type identifier |
| `name` | string | Display name |
| `hp`, `max_hp` | int | Current and maximum health |
| `block` | int | Current block |
| `is_alive` | bool | Whether enemy is alive |
| `is_minion` | bool | Whether enemy is a summoned minion |
| `move_id` | string | Current move identifier |
| `intents` | array | Current turn intents (see below) |
| `powers` | array | Active powers/buffs/debuffs |

### Intent Object

| Field | Type | Description |
|-------|------|-------------|
| `type` | string | `ATTACK`, `DEFEND`, `BUFF`, `DEBUFF`, `UNKNOWN`, etc. |
| `damage` | int? | Damage **per hit** |
| `hits` | int? | Number of hits (total damage = damage * hits) |

## Reward State Structure

Returned by `./sts2 state` in the `data.rewards` field when screen is `REWARD`.

### Reward Item Object

| Field | Type | Description |
|-------|------|-------------|
| `index` | int | 0-based position in reward list (for `claim_reward`) |
| `type` | string | `Gold`, `Potion`, `Relic`, `Card`, `SpecialCard`, `CardRemoval` |
| `description` | string | Localized description |
| `gold_amount` | int? | Gold rewards only: amount of gold |
| `potion_id` | string? | Potion rewards only: potion identifier |
| `potion_name` | string? | Potion rewards only: display name |
| `potion_rarity` | string? | Potion rewards only: rarity |
| `relic_id` | string? | Relic rewards only: relic identifier |
| `relic_name` | string? | Relic rewards only: display name |
| `relic_description` | string? | Relic rewards only: effect description |
| `relic_rarity` | string? | Relic rewards only: rarity |
| `card_choices` | array? | Card rewards only: array of card choices (typically 3) |
| `card_id` | string? | SpecialCard rewards only: card identifier |
| `card_name` | string? | SpecialCard rewards only: display name |

### Card Choice Object (within card rewards)

| Field | Type | Description |
|-------|------|-------------|
| `index` | int | 0-based position in card choices (for `choose_card`) |
| `id` | string | Card identifier |
| `name` | string | Display name |
| `description` | string | Card effect text |
| `type` | string | `Attack`, `Skill`, `Power`, `Status`, `Curse` |
| `rarity` | string | `Common`, `Uncommon`, `Rare` |
| `cost` | int | Energy cost |
| `is_upgraded` | bool | Whether the card is upgraded |

### JSON Example (Reward Screen)

```json
{
  "ok": true,
  "data": {
    "screen": "REWARD",
    "timestamp": 1711123456789,
    "rewards": {
      "rewards": [
        {"index": 0, "type": "Gold", "description": "25 Gold", "gold_amount": 25},
        {"index": 1, "type": "Potion", "description": "Fire Potion",
         "potion_id": "FIRE_POTION", "potion_name": "Fire Potion", "potion_rarity": "Common"},
        {"index": 2, "type": "Card", "description": "Add a card to your deck",
         "card_choices": [
           {"index": 0, "id": "INFLAME", "name": "Inflame", "description": "Gain 2 Strength.",
            "type": "Power", "rarity": "Uncommon", "cost": 1, "is_upgraded": false},
           {"index": 1, "id": "SHRUG_IT_OFF", "name": "Shrug It Off",
            "description": "Gain 8 Block. Draw 1 card.",
            "type": "Skill", "rarity": "Common", "cost": 1, "is_upgraded": false},
           {"index": 2, "id": "ANGER", "name": "Anger",
            "description": "Deal 6 damage. Add a copy to discard.",
            "type": "Attack", "rarity": "Common", "cost": 0, "is_upgraded": false}
         ]}
      ]
    }
  }
}
```

## Action Results

After `play_card`, `end_turn`, and `use_potion`, the response `data` includes a `results` array:

| Type | Fields |
|------|--------|
| `damage` | `target_id`, `target_name`, `damage`, `blocked`, `hp_loss`, `killed` |
| `block` | `target_id`, `target_name`, `amount` |
| `power` | `target_id`, `target_name`, `power_id`, `amount` |
| `potion_used` | `target_id`, `target_name`, `potion_id` |

## Key Notes

- Null/empty fields are **omitted** from JSON (not serialized as `null`).
- `damage` and `block` on cards are **preview values** after all modifiers (strength, vulnerable, etc.).
- `intents[].damage` is **per-hit**; multiply by `intents[].hits` for total incoming damage.
- `combat_id` on enemies is **stable** across the entire combat -- use it for `--target`.
- Card `index` values **reindex after each play**. If you play index 2 from a 5-card hand, old indices 3 and 4 become 2 and 3.
- After `end_turn`, the response contains all enemy actions -- always read it.

## Error Handling

| Error | Cause | Recovery |
|-------|-------|----------|
| `TARGET_NOT_FOUND` | Enemy died or wrong combat_id | Run `./sts2 state` to get alive enemies |
| `INVALID_CARD_INDEX` | Hand reindexed after previous play | Run `./sts2 state` to get current hand |
| `CANNOT_PLAY_CARD` | Not enough energy or blocked by effect | Skip this card |
| `NOT_IN_COMBAT` | Combat ended | Stop the combat loop |
| `COMBAT_ENDING` | Combat is resolving | Stop playing, wait for resolution |
| `NOT_ON_REWARD_SCREEN` | Not on the reward screen | Run `./sts2 state` to check current screen |
| `INVALID_REWARD_INDEX` | Reward index out of range | Run `./sts2 state` to get current rewards |
| `NOT_CARD_REWARD` | Used `choose_card`/`skip_card` on non-card reward | Use `claim_reward` instead |
| `USE_CHOOSE_CARD` | Used `claim_reward` on a card reward | Use `choose_card` or `skip_card` instead |
| `POTION_BELT_FULL` | Potion reward but belt has no empty slots | Skip this reward or use a potion first |
| `NOT_SUPPORTED` | Reward type not yet supported (e.g., CardRemoval) | Skip this reward |
| `CLAIM_FAILED` | Reward claim failed for unknown reason | Run `./sts2 state` to refresh and retry |
| `CONNECTION_ERROR` | Game disconnected | Report to user and stop |

On any error, run `./sts2 state` to refresh state before continuing.
