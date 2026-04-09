---
name: rest-site-tactics
description: Rest site decision framework for Slay the Spire 2 — heal vs smith vs dig evaluation based on HP, deck state, and act progress
---

# Rest Site Tactics

Use this skill when the Deck-Building Agent enters a REST_SITE screen.

## Procedure

1. Read game state: `rest_site.options[]` (available options and enabled status)
2. Read `run-state.md` for current build, HP context, deck state
3. Evaluate options
4. Execute: `./sts2 choose_rest_option <option_id>`
5. If SMITH → GRID_CARD_SELECT → pick card to upgrade
6. `./sts2 proceed` when `rest_site.can_proceed` is true

## Decision Framework

### HEAL (restore HP)
Choose HEAL when:
- HP < 50% of max
- Next fight is Boss or Elite
- No urgent upgrade targets

### SMITH (upgrade a card)
Choose SMITH when:
- HP > 60% of max
- High-value upgrade target exists (see Upgrade Priority)
- Not immediately before Boss with low HP

### DIG (gain relic/card)
Choose DIG when:
- HP is healthy (> 70%)
- Deck lacks key pieces
- Risk is acceptable

### Other Options (LIFT, HATCH, COOK, CLONE, MEND)
Evaluate on a case-by-case basis. Generally:
- LIFT (gain Strength) — good for damage-focused builds
- MEND — heal alternative
- Others — evaluate description

## Upgrade Priority

When SMITH is chosen, select card to upgrade via GRID_CARD_SELECT:

```
1. Archetype core cards (Corruption, Demon Form, Barricade)
2. High-frequency cards (Shrug It Off, Pommel Strike)
3. Key attack cards (Heavy Blade with Strength build)
4. Bash (upgrade gives 3 Vulnerable instead of 2)
5. Defend/Strike (low priority, avoid unless nothing else)
```

## Common Options Reference

| Option ID | Effect |
|-----------|--------|
| `HEAL` | Restore ~30% max HP |
| `SMITH` | Upgrade one card → opens GRID_CARD_SELECT |
| `DIG` | Gain a random relic |
| `LIFT` | Gain permanent Strength |
| `MEND` | Alternative healing |

## Output Format

```
[REST_SITE: HP 38/80 (47%), choosing HEAL — too low for Boss next floor]
> ./sts2 choose_rest_option HEAL
```
