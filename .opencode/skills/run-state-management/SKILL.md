---
name: run-state-management
description: Run state tracking for Slay the Spire 2 — persistent infinite build tracking across combats with automatic reset detection
---

# Run State Management

Use this skill to **manage the run-state.md file** — a persistent record of the current run's infinite build progress, key components, and readiness level.

## File Location

`./run-state.md`

## Reset Detection (CRITICAL)

**Before every read/update operation, check if the run has restarted.**

A run restart is detected when ANY of the following change:
- `character_id` in game state (e.g., switched from `ironclad` to something else, or from null to `ironclad`)
- `ascension_level` changes
- `hp` = `max_hp` AND `gold` = 99 AND deck contains only starter cards (10 cards)
- Player is at Act 1, Floor 0/1 (start of a new run)

**If reset detected:**
```bash
# Clear the run-state.md file and start fresh
> ./run-state.md
echo "# Run State" >> ./run-state.md
echo "" >> ./run-state.md
echo "## Character: The Ironclad" >> ./run-state.md
echo "## Act: 1" >> ./run-state.md
echo "## Ascension: 0" >> ./run-state.md
echo "" >> ./run-state.md
echo "## Phase: 1 — Component Collection" >> ./run-state.md
echo "" >> ./run-state.md
echo "## Infinite Readiness: Not Started" >> ./run-state.md
echo "" >> ./run-state.md
echo "## Infinite Components:" >> ./run-state.md
echo "- Exhaust: None (need ≥2)" >> ./run-state.md
echo "- Draw/Cycle: None (need ≥2)" >> ./run-state.md
echo "- Energy: None (need ≥1)" >> ./run-state.md
echo "- Engine Powers: None" >> ./run-state.md
echo "" >> ./run-state.md
echo "## Deck Size: 10 (starter)" >> ./run-state.md
echo "" >> ./run-state.md
echo "## Relics: Burning Blood" >> ./run-state.md
echo "" >> ./run-state.md
echo "## Potions: None" >> ./run-state.md
echo "" >> ./run-state.md
echo "## Weaknesses: Starter deck — needs exhaust, draw, energy, damage" >> ./run-state.md
echo "" >> ./run-state.md
echo "## Notes: New run. Collecting infinite components." >> ./run-state.md
```

## Standard File Format

```markdown
# Run State

## Character: The Ironclad
## Act: [1/2/3/4]
## Ascension: [0-20]

## Phase: [1 — Component Collection | 2 — Infinite Execution]

## Infinite Readiness: [Not Started | Building | Almost Ready | Infinite Ready]

## Infinite Components:
- Exhaust: [card list] ([count]/2 minimum)
- Draw/Cycle: [card list] ([count]/2 minimum)
- Energy: [card list] ([count]/1 minimum)
- Engine Powers: [Dark Embrace / Feel No Pain / Corruption — list which are owned]

## Deck Size: [Number]

## Relics: [List of key relics, flag infinite-critical ones]

## Potions: [Current potions]

## Weaknesses: [Current deck gaps relative to infinite]

## Notes: [Strategic observations and priorities]
```

## Infinite Component Tracking

### Component Categories

Track every card in the deck that contributes to the infinite engine:

| Category | Cards to Track |
|----------|---------------|
| **Exhaust Sources** | True Grit, Burning Pact, Second Wind, Brand, Stoke, Havoc, Corruption (also Engine Power) |
| **Draw/Cycle Sources** | Pommel Strike, Shrug It Off, Battle Trance, Dark Embrace (also Engine Power), Headbutt |
| **Energy Sources** | Bloodletting, Offering, Forgotten Ritual, Expect a Fight |
| **Engine Powers** | Dark Embrace, Feel No Pain, Corruption (track separately — these are the critical multipliers) |

Also track infinite-relevant colorless cards: Purity (S-tier), Flash of Steel, Finesse, Master of Strategy, Production, Restlessness.

### Readiness Level Calculation

| Level | Criteria | Phase |
|-------|----------|-------|
| **Not Started** | 0–1 total components across all categories | Phase 1 |
| **Building** | 2–4 components, but missing at least one entire category | Phase 1 |
| **Almost Ready** | All 3 categories have minimum count (≥2 exhaust, ≥2 draw, ≥1 energy) AND deck ≤ 20 | Phase 1→2 transition |
| **Infinite Ready** | All categories met + (deck ≤ 16 OR Corruption is in deck) | Phase 2 |

**Corruption override**: If Corruption is obtained, immediately set readiness to at least "Almost Ready" regardless of other component counts. Corruption single-handedly activates the exhaust engine.

### Missing Category Detection

When updating, explicitly identify what's missing:

```markdown
## Weaknesses: Missing Draw/Cycle (only 1 source: Pommel Strike). Need Battle Trance, Shrug It Off, or Dark Embrace.
```

This helps the card-reward and shop-evaluation skills prioritize the right pickups.

## When to Read

**Before every combat (Step 0 in combat-loop):**
- Read `run-state.md` to understand infinite readiness level
- If "Infinite Ready": plan to exhaust-to-loop in combat
- If "Building": play normally but use exhaust cards for value

**Before card reward evaluation:**
- Check readiness level and missing categories
- Determine if offered card fills a gap or is noise

## When to Update

Update the run-state.md file in these situations:

### 1. After Card Rewards (Component Changes)
- New infinite component added → recalculate readiness
- Readiness level changes (e.g., "Building" → "Almost Ready")
- Deck size crosses threshold (12, 16, 20)

### 2. After Relic Acquisition
- Infinite-critical relic obtained (Unceasing Top, Charon's Ashes, Runic Pyramid)
- Relic trap taken that hurts infinite (Velvet Choker, Fiddle — note as WARNING)

### 3. After Card Removal (Shop/Event)
- Track which basics were removed (e.g., "3/4 Defends removed, 2/5 Strikes removed")
- Recalculate deck size and readiness

### 4. After Act Transition
- Update Act number
- Reassess: if Act 2+ and readiness is still "Not Started", note fallback may be needed

### 5. After Deck Transformation Events
- Card upgrades (especially Pommel Strike+, Dark Embrace+, Corruption+)
- Transform events that add/remove cards

## Update Procedure

When updating, rewrite the full run-state.md with current data:

```markdown
# Run State

## Character: The Ironclad
## Act: [1/2/3/4]
## Ascension: [0-20]

## Phase: [1 | 2]

## Infinite Readiness: [Not Started | Building | Almost Ready | Infinite Ready]

## Infinite Components:
- Exhaust: [cards] ([n]/2)
- Draw/Cycle: [cards] ([n]/2)
- Energy: [cards] ([n]/1)
- Engine Powers: [list]

## Key Upgrades: [list upgraded infinite components]

## Deck Size: [count]
## Basics Removed: [n]/4 Defends, [n]/5 Strikes

## Relics: [list, flag infinite-critical with ★]

## Potions: [list]

## Weaknesses: [missing categories or gaps]

## Notes:
- [observation or priority]
```

## Example Run States

### Early Act 1 (Starter)
```markdown
# Run State

## Character: The Ironclad
## Act: 1
## Ascension: 0

## Phase: 1 — Component Collection

## Infinite Readiness: Not Started

## Infinite Components:
- Exhaust: None (0/2)
- Draw/Cycle: None (0/2)
- Energy: None (0/1)
- Engine Powers: None

## Deck Size: 10 (starter)

## Relics: Burning Blood

## Potions: None

## Weaknesses: Starter deck — needs all infinite categories

## Notes: New run. Priority: take any S/A-tier infinite component offered.
```

### Mid-Act 1 (Building)
```markdown
# Run State

## Character: The Ironclad
## Act: 1
## Ascension: 0

## Phase: 1 — Component Collection

## Infinite Readiness: Building

## Infinite Components:
- Exhaust: True Grit, Burning Pact (2/2 ✓)
- Draw/Cycle: Pommel Strike, Shrug It Off (2/2 ✓)
- Energy: None (0/1 ✗)
- Engine Powers: None

## Deck Size: 14
## Basics Removed: 1/4 Defends, 0/5 Strikes

## Relics: Burning Blood, Orichalcum

## Potions: Fire Potion

## Weaknesses: Missing Energy source. Need Bloodletting, Offering, or Forgotten Ritual.

## Notes:
- Good exhaust + draw foundation
- Priority: Bloodletting (common, should appear soon)
- Next shop: remove a Defend
```

### Act 2 (Almost Ready → Infinite Ready)
```markdown
# Run State

## Character: The Ironclad
## Act: 2
## Ascension: 0

## Phase: 2 — Infinite Execution

## Infinite Readiness: Infinite Ready

## Infinite Components:
- Exhaust: True Grit, Burning Pact, Second Wind (3/2 ✓)
- Draw/Cycle: Pommel Strike+, Shrug It Off, Battle Trance (3/2 ✓)
- Energy: Bloodletting, Offering (2/1 ✓)
- Engine Powers: Dark Embrace, Feel No Pain

## Key Upgrades: Pommel Strike+, Dark Embrace+

## Deck Size: 16
## Basics Removed: 3/4 Defends, 2/5 Strikes

## Relics: Burning Blood, Orichalcum, Charon's Ashes ★

## Potions: Block Potion, Energy Potion

## Weaknesses: Deck still has 1 Defend and 3 Strikes. Need more removal.

## Notes:
- Engine fully online. Charon's Ashes = passive AoE kill during loop.
- SKIP all card rewards from here.
- Every shop: remove a card.
- Combat plan: setup powers → exhaust to loop → kill.
```

### Fallback State (Mid-Act 2, Infinite Failed)
```markdown
# Run State

## Character: The Ironclad
## Act: 2
## Ascension: 0

## Phase: 1 — Component Collection (FALLBACK)

## Infinite Readiness: Not Started (FALLBACK: Exhaust Midrange)

## Infinite Components:
- Exhaust: True Grit (1/2 ✗)
- Draw/Cycle: Shrug It Off (1/2 ✗)
- Energy: None (0/1 ✗)
- Engine Powers: Feel No Pain

## Deck Size: 18

## Relics: Burning Blood, Vajra

## Weaknesses: Infinite not viable. Pivoting to Exhaust Midrange + Strength.

## Notes:
- Only 1 exhaust, 1 draw by mid-Act 2. Infinite unlikely.
- Feel No Pain provides value without full loop.
- Pivot: Take Demon Form / Inflame if seen. Strength scaling as backup.
- Ashen Strike / Pact's End as non-loop finishers.
```

## Integration with Other Skills

| Skill | Integration Point |
|-------|-------------------|
| **combat-loop** | Step 0: Read readiness level. If "Infinite Ready", plan exhaust-to-loop sequence. |
| **card-reward** | Check missing categories → prioritize cards that fill gaps. If "Infinite Ready", skip all rewards. |
| **shop-evaluation** | Card removal is #1 priority. Buy cards that fill missing categories. |
| **rest-site-tactics** | Upgrade Tier 1 infinite targets (Pommel Strike, Dark Embrace, Corruption). |
| **end-state-evaluation** | If "Infinite Ready", add infinite loop as candidate sequence type. |
| **threat-assessment** | Infinite decks can afford longer fights — reduce urgency of fast kills pre-loop. |
| **map-pathing** | Infinite builds value shops highly for card removal. Route toward shops. |

## Error Handling

| Issue | Action |
|-------|--------|
| File doesn't exist | Create new with reset template |
| File is empty/invalid | Treat as reset, reinitialize |
| Parse error | Log warning, continue with empty/default state |
| Write permission denied | Log error, continue without persistence |

## Notes on Persistence

- This file is in `.gitignore` and will NOT be committed
- It survives context compaction and long sessions
- It's temporary per run and will be reset on new game starts
- Human users can edit it manually to correct AI assessments
