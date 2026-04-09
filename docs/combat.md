# Combat Mechanics

Player-facing combat rules for AI decision-making. Covers turn flow, damage/block pipeline, card keywords, powers, and win/loss conditions.

## Turn Flow

```
Combat Start
  ├── Player gets starting block from relics (if any)
  ├── Enemies roll initial intents
  └── Player Turn 1 begins (block NOT cleared on turn 1)

Each Round:
  Player Turn
    1. Enemy intents rolled (visible to player)
    2. Block cleared (except round 1)
    3. Energy reset to max (default 3)
    4. Draw 5 cards (Innate cards drawn first on turn 1)
    5. PLAY PHASE — player plays cards and uses potions
    6. End Turn pressed:
       Phase 1: Exhaust Ethereal cards, trigger turn-end-in-hand effects
       Phase 2: Retain marked cards, discard the rest
  
  Enemy Turn
    1. Block cleared for enemies
    2. Each enemy executes its intent in order
    3. Win check after each enemy acts
    4. Enemy turn ends
```

## Energy System

- Default max energy: **3** per turn
- Energy resets to max at start of each player turn
- Each card costs energy to play (shown on card)
- X-cost cards consume ALL remaining energy
- Some effects grant bonus energy mid-turn
- Unspent energy is lost at end of turn (unless modified by relics/powers)

## Damage Pipeline

When a card deals damage, the following pipeline applies:

```
Base damage (card value)
  → + Strength (if powered attack)
  → Hook modifications (relics, powers)
  → × Weak modifier (0.75× if attacker is Weak)
  → × Vulnerable modifier (1.5× if target is Vulnerable)
  → Round to nearest integer
  → Subtract target's Block
  → Remaining damage reduces HP
```

**Key points:**
- Card `damage` values in the hand are **already calculated** with all modifiers (Strength, Weak, Vulnerable). Use them directly.
- `intents[].damage` on enemies is **per-hit** after modifiers. Total = damage × hits.
- Damage cannot go below 0.

## Block Pipeline

When a card grants block:

```
Base block (card value)
  → + Dexterity (if powered block)
  → Hook modifications (relics, powers)
  → × Frail modifier (0.75× if player is Frail)
  → Round to nearest integer
  → Added to current Block
```

**Key points:**
- Card `block` values in the hand are **already calculated** with all modifiers. Use them directly.
- Block absorbs damage before HP. Remaining block persists until cleared.
- Block is cleared at the **start of each side's turn** (player block cleared at start of player turn, enemy block cleared at start of enemy turn).
- Exception: Round 1 — player block is NOT cleared (preserves block from relics/combat-start effects).
- Barricade power prevents block from being cleared.

## Card Keywords

| Keyword | Effect |
|---------|--------|
| **Exhaust** | Removed from combat after being played (goes to exhaust pile) |
| **Ethereal** | If still in hand at end of turn, exhausted (removed from combat) |
| **Innate** | Drawn first on turn 1 |
| **Retain** | Kept in hand at end of turn (not discarded) |
| **Unplayable** | Cannot be played (e.g., Curses, some Statuses) |
| **Sly** | Auto-plays when discarded |
| **Eternal** | Cannot be removed from deck |

## Card Types

| Type | Behavior |
|------|----------|
| **Attack** | Deals damage. Goes to discard after play (unless Exhaust). |
| **Skill** | Grants block, applies buffs/debuffs, other utility. Goes to discard after play. |
| **Power** | Permanent effect for the rest of combat. Removed from play after use (not discarded). |
| **Status** | Usually negative. Added to deck/hand by enemies. Often Unplayable or Ethereal. |
| **Curse** | Negative effect. Persists in deck across combats. Often Unplayable. |

## Card Targeting

| Target Type | Behavior |
|-------------|----------|
| `ENEMY` (AnyEnemy) | Must specify `--target <combat_id>` |
| `ALL_ENEMY` (AllEnemies) | Hits all enemies, no target needed |
| `SELF` | Targets self, no target needed |
| `NONE` | No target needed |

## Card Piles

| Pile | Description |
|------|-------------|
| **Draw** | Cards waiting to be drawn. Shuffled at combat start. |
| **Hand** | Cards available to play. Max **10** cards. |
| **Discard** | Played/discarded cards. Shuffled into Draw when Draw is empty. |
| **Exhaust** | Permanently removed cards (within this combat). |
| **Play** | Cards currently being resolved (transient). |

## Common Powers (Buffs & Debuffs)

### Player Buffs

| Power | Type | Behavior |
|-------|------|----------|
| **Strength** | Stacking | +Amount to all attack damage. Can go negative. |
| **Dexterity** | Stacking | +Amount to all block gained. Can go negative. |
| **Artifact** | Counter | Blocks next debuff application, then -1. |
| **Buffer** | Counter | Prevents next HP loss instance, then -1. |
| **Barricade** | Permanent | Block is not cleared at turn start. |
| **Demon Form** | Stacking | Gain Strength equal to Amount each turn. |
| **Plating** | Counter | Gain block at turn end, then -1. |
| **Intangible** | Counter | All HP loss reduced to 1. Ticks down. |
| **Corruption** | Permanent | Skills cost 0 energy but Exhaust. |

### Common Debuffs

| Power | Type | Behavior |
|-------|------|----------|
| **Vulnerable** | Counter | Take 1.5× damage. Decrements at end of sufferer's turn. |
| **Weak** | Counter | Deal 0.75× damage. Decrements at end of sufferer's turn. |
| **Frail** | Counter | Gain 0.75× block. Decrements at end of sufferer's turn. |
| **Poison** | Counter | At turn start: lose HP equal to Amount, then Amount -1. |
| **Doom** | Counter | If HP ≤ Amount at turn end, creature dies. |
| **Confused** | Permanent | Randomizes card energy costs. |

## Enemy Intent System

Each enemy shows intents for their upcoming turn:

| Intent Type | Meaning |
|-------------|---------|
| **ATTACK** | Will deal damage. `damage` × `hits` = total incoming. |
| **DEFEND** | Will gain block. |
| **BUFF** | Will apply a buff to itself or allies. |
| **DEBUFF** | Will apply a debuff to the player. |
| **UNKNOWN** | Intent hidden or mixed. |

**Multiple intents**: An enemy can have multiple intents in one turn (e.g., attack AND buff).

## Win / Loss Conditions

**Win**: All primary (non-minion) enemies are dead.
- When a primary enemy dies and only minions remain, minions are automatically killed.
- Some enemies prevent combat from ending on death (spawn new enemies, revive, etc.).

**Loss**: Player HP reaches 0.
- Loss is deferred — combat doesn't end mid-action.
- Some effects can prevent death (e.g., Fairy in a Bottle potion).

## Stun Mechanic

- Stunned enemies skip their action for one turn (show stun intent).
- Stun is not a power — it's a forced move override on the enemy's state machine.
- After the stunned turn, the enemy resumes its normal pattern.

## Key Formulas

### Lethal Check
```
incoming_damage = sum(enemy.intent.damage × enemy.intent.hits) for each alive enemy with ATTACK intent
net_damage = incoming_damage - player.block
lethal = net_damage >= player.hp
```

### Kill Check
```
can_kill = (available_damage >= enemy.hp + enemy.block)
```

### Damage Efficiency
```
damage_per_energy = card.damage / card.cost
```
