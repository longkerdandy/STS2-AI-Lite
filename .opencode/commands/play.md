---
description: Full auto-play — runs the game from current state until game over, handling all screens automatically
agent: game-master
---

Execute a full automated run of Slay the Spire 2 from the current game state.

**Initialization:**

1. Load `run-state-management` skill
2. Run `./sts2 state` to detect current screen
3. Check for new run (initialize run-state.md if needed)

**Main Loop:**

Continuously run `./sts2 state`, parse the `screen` field, and route to the appropriate handler:

- `COMBAT` / `HAND_SELECT` → Dispatch to Combat Agent via Task
- `REWARD` / `CARD_REWARD` / `SHOP` / `REST_SITE` / `GRID_CARD_SELECT` / `RELIC_SELECT` / `BUNDLE_SELECT` → Dispatch to Deck-Building Agent via Task
- `MAP` → Handle directly (load `map-pathing` skill, choose node)
- `EVENT` → Handle directly (dispatch to Deck-Building only for card-related events)
- `TREASURE` → Handle directly (open chest, pick relic, proceed)
- `TRI_SELECT` → Route based on last dispatched agent (combat or deck-building)
- `CRYSTAL_SPHERE` → Handle directly (play mini-game)
- `MENU` / `CHARACTER_SELECT` / `SINGLEPLAYER_SUBMENU` → Handle game start sequence
- `GAME_OVER` → Report result and stop
- `UNKNOWN` → Retry state query

After each screen, output a 1-2 sentence summary of the decision made.

Continue until `GAME_OVER` is reached or user interrupts.

Before every action, output reasoning with specific numbers.

$ARGUMENTS
