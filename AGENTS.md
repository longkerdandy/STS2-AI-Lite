# AGENTS.md - STS2-AI-Lite Master Document

AI player project that interacts with Slay the Spire 2 via the `./sts2` CLI. Supports full automated runs from map navigation through combat, rewards, shops, events, and rest sites.

## Project Structure

```
STS2-AI-Lite/
├── AGENTS.md                    # This document: top-level index
├── opencode.json                # OpenCode configuration
├── sts2                         # CLI wrapper script (bash — Linux/macOS/WSL)
├── sts2.cmd                     # CLI wrapper script (batch — Windows native)
├── run-state.md                 # Current runtime state (temporary file)
├── .opencode/
│   ├── agents/
│   │   └── game-master.md       # Unified agent — handles ALL screens directly
│   ├── skills/
│   │   ├── combat-loop/         # Combat execution, turn planning, threat assessment
│   │   ├── run-state-management/# Persistent run state tracking
│   │   ├── card-reward/         # Card reward evaluation
│   │   ├── potion-timing/       # Potion usage timing
│   │   ├── map-pathing/         # Map node evaluation and selection
│   │   ├── shop-evaluation/     # Shop purchase decisions
│   │   └── rest-site-tactics/   # Rest site heal vs smith vs dig
│   └── commands/
│       └── play.md              # /play — full auto-play command
└── docs/                        # Game knowledge reference (read on demand)
    ├── deck-building-framework.md # ★ Unified evaluation framework (card tiers, archetypes, weaknesses)
    ├── cli-reference.md         # CLI command manual (40+ commands, 18 screen types)
    ├── combat.md                # Combat mechanics
    ├── characters.md            # Character data
    ├── cards.md                 # Card data
    ├── enemies.md               # Enemy behaviors
    ├── relics.md                # Relic effects
    ├── potions.md               # Potion effects
    └── builds.md                # Build strategies (per-archetype detail)
```

## Architecture

### Single-Agent Design

```
Game Master (Unified) — handles ALL screens directly, no subagent dispatch
  ├── Combat — executed inline, no Task overhead
  ├── Deck-Building — evaluated inline (rewards, shop, rest site, card selection)
  ├── Map Navigation — path planning and node selection
  ├── Events / Treasure / Crystal Sphere — handled directly
  └── Skills — loaded on-demand for strategy knowledge (once per run per type)
```

**Why single-agent?** Eliminates Task dispatch overhead (cold-start, context rebuild, skill reload). Each subagent dispatch added 10-30s of latency. Single-agent handles everything in one continuous context.

### Screen Routing

All screens handled directly by the unified agent:

| Screen | Skill (loaded once) |
|--------|---------------------|
| `MAP` | `map-pathing` |
| `COMBAT`, `HAND_SELECT` | `combat-loop` |
| `REWARD`, `CARD_REWARD` | `card-reward` |
| `SHOP` | `shop-evaluation` |
| `REST_SITE` | `rest-site-tactics` |
| `GRID_CARD_SELECT`, `RELIC_SELECT`, `BUNDLE_SELECT` | — |
| `EVENT`, `TREASURE`, `CRYSTAL_SPHERE` | — |
| `TRI_SELECT` | — |
| `MENU`, `CHARACTER_SELECT`, `GAME_OVER` | — |

## Usage Guide

### Full Auto-Play
Type `/play` to run the game from current state to game over automatically.

### Documentation Hierarchy

| Need | Reference Location |
|------|-------------------|
| Card/relic evaluation data | `docs/deck-building-framework.md` ★ |
| How to run full game | `game-master.md` agent |
| How to fight | `combat-loop` skill |
| How to build deck | `game-master.md` (deck-building section) |
| When to use potions | `potion-timing` skill |
| CLI command details | `docs/cli-reference.md` |
| Card/enemy/relic data | Corresponding files under `docs/` |

### Skill Loading Rules

Load skills **once per run** on first encounter. Don't reload on repeat encounters.

| First Encounter | Load Skill |
|-----------------|------------|
| First combat | `combat-loop` |
| First map screen | `map-pathing` |
| First shop | `shop-evaluation` |
| First rest site | `rest-site-tactics` |
| First card reward | `card-reward` + Read `docs/deck-building-framework.md` |
| Potion decision needed | `potion-timing` |
| Run start | `run-state-management` |
| Unfamiliar enemy/card/relic | Read corresponding `docs/` file |
| CLI bug encountered | `./sts2 report_bug --title "..." --description "..." --severity <level>` |

### Output Format

Before each action, output 1 sentence of decision reasoning:

```
[Jaw Worm intent 11 damage, I have 80 HP 0 block, play Strike for 8 damage]
> ./sts2 play_card STRIKE_IRONCLAD --target 1
```

## Scope

- **Supported**: Full game flow — map, combat, rewards, shop, rest site, events, treasure, crystal sphere
- **Character**: The Ironclad only
- **CLI**: 40+ commands, 18 screen types (via STS2-Cli-Mod)

## Language Policy

- **中文**: 与用户对话、解释决策、战斗报告
- **English**: 所有代码注释、技术文档、CLI 命令、run-state.md

在与用户交流时使用中文。在编写或读取技术文档、执行 CLI 命令时保持英文。

## Related Projects

| Project | Link |
|---------|------|
| STS2-Cli-Mod | github.com/longkerdandy/STS2-Cli-Mod |
| STS2-AI-Agent | github.com/longkerdandy/STS2-AI-Agent (Full Version) |
