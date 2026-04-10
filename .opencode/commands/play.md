---
description: "Full auto-play — runs the game from current state until game over. Usage: /play [new|continue]"
agent: game-master
---

Execute a full automated run of Slay the Spire 2.

## Mode (from $ARGUMENTS)

Parse the argument to determine start mode:

| Argument | Mode | Behavior |
|----------|------|----------|
| *(empty)* | **auto** | Run `./sts2 state`. If already in a run (MAP/COMBAT/etc.), resume with existing `run-state.md`. If on MENU: `has_run_save=true` → continue, `false` → new game. |
| `new` | **new** | Force new game. **Reset `run-state.md` immediately.** If `has_run_save=true`, run `./sts2 abandon_run` first, then `./sts2 new_run`. If already in a run (not MENU), tell user to finish or abandon current run first. |
| `continue` | **continue** | Force continue. If `has_run_save=true`, run `./sts2 continue_run`. If `false`, report error: no saved run exists. |

## Initialization

1. Load `run-state-management` skill
2. Run `./sts2 state` to detect current screen
3. Apply mode logic above to start or resume
4. Run state handling:
   - **new mode**: Always reset `run-state.md` with fresh template (see `run-state-management` skill)
   - **auto mode (new game)**: Same as above — reset `run-state.md`
   - **auto mode (resume) / continue mode**: Read existing `run-state.md`. If file is missing or corrupt, reinitialize from current game state.

## Main Loop

Continuously run `./sts2 state`, parse the `screen` field, and route to the appropriate handler.

Handle ALL screens directly (no subagent dispatch):

- `COMBAT` / `HAND_SELECT` → Execute combat directly (load `combat-loop` skill on first combat)
- `REWARD` / `CARD_REWARD` → Claim rewards, evaluate cards directly
- `SHOP` → Handle shop purchases directly (load `shop-evaluation` skill on first shop)
- `REST_SITE` → Decide heal/smith/dig directly (load `rest-site-tactics` skill on first rest)
- `GRID_CARD_SELECT` → Handle card removal/upgrade/transform directly
- `RELIC_SELECT` / `BUNDLE_SELECT` → Evaluate and pick directly
- `MAP` → Compute path and choose node directly (load `map-pathing` skill on first map)
- `EVENT` → Evaluate options and choose directly
- `TREASURE` → Open chest, pick relic, proceed
- `TRI_SELECT` → Evaluate and pick directly
- `CRYSTAL_SPHERE` → Play mini-game directly
- `MENU` / `CHARACTER_SELECT` / `SINGLEPLAYER_SUBMENU` → Handle game start sequence
- `GAME_OVER` → Report result and stop
- `UNKNOWN` → Retry state query

After each screen, output a 1-2 sentence summary of the decision made.

Continue until `GAME_OVER` is reached or user interrupts.

Before every action, output reasoning with specific numbers.
