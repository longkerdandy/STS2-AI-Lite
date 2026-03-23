# AGENTS.md - STS2-AI-Lite Master Document

AI player project that interacts with Slay the Spire 2 via the `./sts2` CLI.

## Project Structure

```
STS2-AI-Lite/
├── AGENTS.md                    # This document: top-level index
├── opencode.json                # OpenCode configuration
├── sts2 -> STS2-Cli-Mod         # CLI binary symlink
├── run-state.md                 # Current runtime state (temporary file)
├── .opencode/
│   ├── agents/
│   │   └── combat.md            # Main combat Agent (runtime instructions)
│   ├── skills/                  # Detailed strategy knowledge (load on demand)
│   │   ├── combat-loop/         # Complete combat workflow
│   │   ├── end-state-evaluation/# Turn planning framework
│   │   ├── threat-assessment/   # Enemy threat analysis
│   │   ├── card-reward/         # Card reward evaluation
│   │   └── potion-timing/       # Potion usage timing
│   └── commands/
│       └── fight.md             # /fight shortcut command entry
└── docs/                        # Game knowledge reference (read on demand)
    ├── cli-reference.md         # CLI command manual
    ├── combat.md                # Combat mechanics
    ├── characters.md            # Character data
    ├── cards.md                 # Card data
    ├── enemies.md               # Enemy behaviors
    ├── relics.md                # Relic effects
    ├── potions.md               # Potion effects
    └── builds.md                # Build strategies
```

## Usage Guide

### Starting Combat
Type `/fight` to automatically execute a complete combat + reward settlement.

### Documentation Hierarchy

| Need | Reference Location |
|------|-------------------|
| How to fight | `combat-loop` skill |
| How to plan turns | `end-state-evaluation` skill |
| How to evaluate enemies | `threat-assessment` skill |
| How to choose cards | `card-reward` skill + `docs/builds.md` |
| When to use potions | `potion-timing` skill |
| CLI command details | `docs/cli-reference.md` |
| Card/enemy/relic data | Corresponding files under `docs/` |

### Skill Loading Rules

Load skills to get **strategy knowledge**, read docs/ for **data reference**:

| Scenario | Action |
|----------|--------|
| Start full combat | Load `combat-loop` skill |
| Encounter unfamiliar enemy | Read `docs/enemies.md` |
| Encounter unfamiliar card | Read `docs/cards.md` |
| Encounter unfamiliar potion | Read `docs/potions.md` |
| Select card reward | Load `card-reward` skill + Read `docs/builds.md` |
| Plan turn | Load `end-state-evaluation` skill |
| Assess threat | Load `threat-assessment` skill |

### Output Format

Before each action, output 1 sentence of decision reasoning in this format:

```
[Jaw Worm intent 11 damage, I have 80 HP 0 block, play Strike for 8 damage]
> ./sts2 play_card STRIKE_IRONCLAD --target 1
```

## Scope and Limitations

- **Supported**: Combat + post-combat reward settlement
- **Character**: The Ironclad only
- **Not Supported**: Map, shop, events (CLI limitations)
- **Language**: Use Chinese when conversing with the user, keep code and CLI commands in English

## Related Projects

| Project | Link |
|---------|------|
| STS2-Cli-Mod | github.com/longkerdandy/STS2-Cli-Mod |
| STS2-AI-Agent | github.com/longkerdandy/STS2-AI-Agent (Full Version) |
