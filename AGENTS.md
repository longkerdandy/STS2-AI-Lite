# AGENTS.md - STS2-AI-Lite Master Document

AI player project that interacts with Slay the Spire 2 via the `./sts2` CLI. Supports full automated runs from map navigation through combat, rewards, shops, events, and rest sites.

## Project Structure

```
STS2-AI-Lite/
├── AGENTS.md                    # This document: top-level index
├── opencode.json                # OpenCode configuration
├── sts2 -> STS2-Cli-Mod         # CLI binary symlink
├── run-state.md                 # Current runtime state (temporary file)
├── .opencode/
│   ├── agents/
│   │   ├── game-master.md       # Primary orchestrator (state routing, map, events, lifecycle)
│   │   ├── combat.md            # Combat subagent (fighting + combat sub-states)
│   │   └── deck-building.md     # Deck-building subagent (rewards, shop, rest site, card selection)
│   ├── skills/
│   │   ├── combat-loop/         # Combat execution workflow
│   │   ├── run-state-management/# Persistent run state tracking
│   │   ├── end-state-evaluation/# Turn planning framework
│   │   ├── threat-assessment/   # Enemy threat analysis
│   │   ├── card-reward/         # Card reward evaluation
│   │   ├── potion-timing/       # Potion usage timing
│   │   ├── map-pathing/         # Map node evaluation and selection
│   │   ├── shop-evaluation/     # Shop purchase decisions
│   │   └── rest-site-tactics/   # Rest site heal vs smith vs dig
│   ├── commands/
│   │   └── play.md              # /play — full auto-play command
│   └── logs/
│       └── cli-errors.md        # CLI error log and workarounds
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

### Agent Hierarchy

```
Game Master (Primary) — state routing, map, events, treasure, crystal sphere, lifecycle
├── Combat Agent (Subagent) — combat execution, HAND_SELECT, TRI_SELECT sub-states
└── Deck-Building Agent (Subagent) — rewards, shop, rest site, card/relic selection
```

### Screen Routing

| Screen | Handler |
|--------|---------|
| `MAP` | Game Master (map-pathing skill) |
| `COMBAT`, `HAND_SELECT` | Combat Agent |
| `REWARD`, `CARD_REWARD`, `SHOP`, `REST_SITE` | Deck-Building Agent |
| `GRID_CARD_SELECT`, `RELIC_SELECT`, `BUNDLE_SELECT` | Deck-Building Agent |
| `EVENT` | Game Master (simple) / Deck-Building (card-related) |
| `TREASURE`, `CRYSTAL_SPHERE` | Game Master |
| `TRI_SELECT` | Context-dependent (Combat or Deck-Building) |
| `MENU`, `CHARACTER_SELECT`, `GAME_OVER` | Game Master |

## Usage Guide

### Full Auto-Play
Type `/play` to run the game from current state to game over automatically.

### Documentation Hierarchy

| Need | Reference Location |
|------|-------------------|
| Card/relic evaluation data | `docs/deck-building-framework.md` ★ |
| How to run full game | `game-master.md` agent |
| How to fight | `combat-loop` skill |
| How to build deck | `deck-building.md` agent |
| How to navigate map | `map-pathing` skill |
| How to shop | `shop-evaluation` skill |
| How to rest | `rest-site-tactics` skill |
| How to track run state | `run-state-management` skill |
| How to plan turns | `end-state-evaluation` skill |
| How to evaluate enemies | `threat-assessment` skill |
| How to choose card rewards | `card-reward` skill + `docs/deck-building-framework.md` |
| When to use potions | `potion-timing` skill |
| CLI command details | `docs/cli-reference.md` |
| Card/enemy/relic data | Corresponding files under `docs/` |

### Skill Loading Rules

Load skills for **strategy knowledge**, read docs/ for **data reference**:

| Scenario | Action |
|----------|--------|
| Start full combat | Load `combat-loop` skill |
| Plan turn | Load `end-state-evaluation` skill |
| Navigate map | Load `map-pathing` skill |
| Enter shop | Load `shop-evaluation` skill |
| Enter rest site | Load `rest-site-tactics` skill |
| Select card reward | Load `card-reward` skill + Read `docs/deck-building-framework.md` |
| Assess threat | Load `threat-assessment` skill |
| Update run state | Load `run-state-management` skill |
| Unfamiliar enemy/card/relic | Read corresponding `docs/` file |

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
