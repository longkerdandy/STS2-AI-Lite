---
name: run-state-management
description: Run state tracking for Slay the Spire 2 — persistent deck/build tracking across combats with automatic reset detection
---

# Run State Management

Use this skill to **manage the run-state.md file** — a persistent record of the current run's build direction, key cards, and progression.

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
echo "## Build: Early Act 1 / Undecided" >> ./run-state.md
echo "" >> ./run-state.md
echo "## Key Cards: None yet" >> ./run-state.md
echo "" >> ./run-state.md
echo "## Deck Size: 10 (starter)" >> ./run-state.md
echo "" >> ./run-state.md
echo "## Relics: Burning Blood" >> ./run-state.md
echo "" >> ./run-state.md
echo "## Potions: None" >> ./run-state.md
echo "" >> ./run-state.md
echo "## Weaknesses: Basic starter deck - needs damage, AoE, scaling" >> ./run-state.md
echo "" >> ./run-state.md
echo "## Notes: New run started. Looking for archetype signals." >> ./run-state.md
```

## Standard File Format

```markdown
# Run State

## Character: The Ironclad
## Act: 1
## Ascension: 0

## Build: [Archetype / Stage / Flexibility]

## Key Cards: [List of archetype-defining cards]

## Deck Size: [Number]

## Relics: [List of key relics]

## Potions: [Current potions]

## Weaknesses: [Current deck gaps]

## Notes: [Strategic observations and priorities]
```

## When to Read

**Before every combat (Step 0 in combat-loop):**
- Read `run-state.md` to understand current build direction
- Use this to inform turn planning and target priorities

**Before card reward evaluation:**
- Check current archetype assessment
- Determine if card fits existing archetype or opens new direction

## When to Update

Update the run-state.md file in these situations:

### 1. After Card Rewards (Meaningful Changes Only)
- Archetype commitment changes (e.g., picking Corruption commits to Exhaust)
- Critical card added that enables a combo
- Deck size crosses threshold (15, 20, 25, 30+)

### 2. After Relic Acquisition
- Relic changes build direction (e.g., Dead Branch with Exhaust)
- Relic enables new strategy

### 3. After Act Transition
- Update Act number
- Reassess build viability for next Act's challenges

### 4. After Deck Transformation Events
- Card removal
- Card upgrade events
- Special card additions (from events, shops, etc.)

## Update Procedure

```markdown
# Run State

## Character: [Character Name]
## Act: [1/2/3/4]
## Ascension: [0-20]

## Build: [Description]

## Key Cards: [Card list]

## Deck Size: [Count]

## Relics: [Relic list]

## Potions: [Potion list]

## Weaknesses: [Analysis]

## Notes: [Timestamped observations]
- [Timestamp]: [Observation or strategic note]
```

## Archetype Signals Reference

| Archetype | Key Signals | Status |
|-----------|-------------|--------|
| **Strength** | Inflame, Demon Form, Twin Strike, Whirlwind | [ ] |
| **Block/Body Slam** | Body Slam, Barricade, Shrug It Off, Impervious | [ ] |
| **Exhaust** | Corruption, Dark Embrace, Feel No Pain, True Grit | [ ] |
| **Bloodletting** | Rupture, Inferno, Bloodletting, Crimson Mantle | [ ] |
| **Vulnerable** | Dismantle, Taunt, Tremble, Dominate, Colossus | [ ] |

Use checkboxes to track which archetypes show signals in the current deck.

## Example Run States

### Early Act 1 (Starter)
```markdown
# Run State

## Character: The Ironclad
## Act: 1
## Ascension: 0

## Build: Early Act 1 / Undecided

## Key Cards: None yet

## Deck Size: 10 (starter)

## Relics: Burning Blood

## Potions: None

## Weaknesses: Basic starter deck - needs damage, AoE, scaling

## Notes: Looking for archetype signals in first few combats.
```

### Mid-Act 1 (Archetype Forming)
```markdown
# Run State

## Character: The Ironclad
## Act: 1
## Ascension: 0

## Build: Exhaust signals + Block engine (flexible)

## Key Cards: Feel No Pain, Shrug It Off, True Grit

## Deck Size: 14

## Relics: Burning Blood, Orichalcum

## Potions: Fire Potion

## Weaknesses: No consistent scaling, no AoE yet

## Notes:
- [Turn 4]: Picked Feel No Pain - commit to Exhaust archetype
- [Turn 8]: Shrug It Off adds Block/Draw engine
- Priority: Find Corruption or Dark Embrace for Exhaust core
```

### Act 2 (Committed Build)
```markdown
# Run State

## Character: The Ironclad
## Act: 2
## Ascension: 0

## Build: Exhaust (Corruption online) + Block synergy

## Key Cards: Corruption, Dark Embrace, Feel No Pain, Body Slam, Shrug It Off, Second Wind

## Deck Size: 22

## Relics: Burning Blood, Dead Branch, Orichalcum

## Potions: Dexterity Potion, Fairy in a Bottle

## Weaknesses: Deck size getting large, need more card draw

## Notes:
- [Act 2, Floor 15]: Corruption + Dark Embrace online - engine working
- [Act 2, Floor 18]: Dead Branch acquired - adds random cards, watch for bloat
- Be selective with card picks from here
```

## Integration with Other Skills

| Skill | Integration Point |
|-------|-------------------|
| **combat-loop** | Step 0: Read run-state; After combat: Update Notes if meaningful |
| **card-reward** | Before evaluation: Read archetype; After: Update if archetype shifts |
| **deck-building agent** | All deck-mutation screens: update after card/relic/shop changes |
| **game-master agent** | Update Act/floor progression after map transitions |
| **end-state-evaluation** | Consider archetype patterns when generating candidate sequences |
| **threat-assessment** | Use archetype to determine kill priority (e.g., Exhaust decks can afford longer fights) |

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
