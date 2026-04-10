# STS2-AI-Lite

An AI player for [Slay the Spire 2](https://store.steampowered.com/app/2868840/Slay_the_Spire_2/) that plays full automated runs via CLI. No traditional code -- pure prompt engineering with Markdown strategy documents, agents, and skills.

### Supported Coding Agents

| Tool | Status |
|------|--------|
| [OpenCode](https://opencode.ai) | Supported |
| [Claude Code](https://docs.anthropic.com/en/docs/claude-code) | Planned |
| [Kimi Code](https://kimi.ai) | Planned |

Any tool that can read Markdown, run shell commands, and follow structured instructions can drive this project.

### Supported Characters

| Character | Status | Build Strategy |
|-----------|--------|----------------|
| The Ironclad | Supported | Progressive Infinite |
| The Silent | Planned | -- |
| The Defect | Planned | -- |
| The Regent | Planned | -- |

## How It Works

```
CLI Coding Agent (OpenCode / Claude Code / Kimi Code / ...)
  └── Game Master Agent          ← routes game state to subagents
        ├── Combat Agent         ← fights battles
        └── Deck-Building Agent  ← rewards, shop, rest site
              ↕
         ./sts2 CLI              ← reads/controls the game via named pipe
              ↕
         STS2-Cli-Mod            ← BepInEx mod injected into STS2
              ↕
         Slay the Spire 2       ← the game
```

The AI reads game state as JSON, makes decisions using strategy documents and skills, then sends commands back through the CLI. No game files are modified beyond the mod injection.

## Prerequisites

| Component | Version | Purpose |
|-----------|---------|---------|
| [Slay the Spire 2](https://store.steampowered.com/app/2868840/) | Latest | The game |
| [STS2-Cli-Mod](https://github.com/longkerdandy/STS2-Cli-Mod) | Latest | BepInEx mod + CLI binary |
| A CLI coding agent | Latest | See supported tools above |
| LLM API key | -- | Anthropic, OpenAI, Moonshot, or other supported providers |

## Setup

### 1. Install the Mod

Follow [STS2-Cli-Mod](https://github.com/longkerdandy/STS2-Cli-Mod) instructions to install BepInEx and the mod into your STS2 game directory.

### 2. Install the CLI

Build and publish the CLI binary:

```bash
# In the STS2-Cli-Mod repo
dotnet publish STS2.Cli.Cmd/STS2.Cli.Cmd.csproj -c Release -r <rid>
```

Place the output binary in one of these standard paths (auto-detected by the wrapper script):

| Platform | Path |
|----------|------|
| Windows | `%LOCALAPPDATA%\sts2-cli\sts2.exe` |
| WSL | `/mnt/c/Users/<user>/AppData/Local/sts2-cli/sts2.exe` |
| Linux | `~/.local/bin/sts2` |
| macOS | `~/.local/bin/sts2` |

Or set `STS2_CLI_DIR` to the directory containing the binary:

```bash
export STS2_CLI_DIR=/path/to/dir
```

### 3. Configure Your Coding Agent

The project currently ships with OpenCode configuration (`opencode.json`, `.opencode/`). Edit `opencode.json` to set your LLM provider and model:

```jsonc
{
  "model": "anthropic/claude-sonnet-4-20250514",  // or any supported model
  // ...
}
```

See [OpenCode docs](https://opencode.ai/docs) for provider configuration.

> **Other tools:** Support for Claude Code (`CLAUDE.md`), Kimi Code, and similar tools is planned. The core strategy lives in `AGENTS.md` and `docs/` which are tool-agnostic -- only the agent/skill wiring needs adaptation per tool.

### 4. Verify Connection

Launch STS2 with the mod loaded, then test:

```bash
./sts2 ping
# {"ok": true}

./sts2 state
# Returns current game state as JSON
```

## Usage

### Auto-Play a Full Run (OpenCode)

```bash
opencode
```

Once inside OpenCode, type:

```
/play
```

The AI will take over from the current game state and play until game over, handling all screens: map navigation, combat, rewards, shop, rest sites, events, and treasure rooms.

### Manual Interaction

You can also chat with the AI for specific decisions:

```
> Help me choose from these card rewards
> What should I buy in this shop?
> Play this combat for me
```

### CLI Commands

Test or debug the game connection directly:

```bash
./sts2 state                    # Full game state
./sts2 play_card BASH --target 1  # Play a card
./sts2 end_turn                 # End turn
./sts2 choose_map_node 3 2      # Travel to map node
```

See `docs/cli-reference.md` for the complete command reference (40+ commands, 18 screen types).

## Project Structure

```
STS2-AI-Lite/
├── AGENTS.md                   # Agent architecture & routing rules (tool-agnostic)
├── opencode.json               # OpenCode-specific config
├── sts2 / sts2.cmd             # CLI wrapper scripts
├── .opencode/                  # OpenCode-specific agent/skill wiring
│   ├── agents/                 #   3 agents: game-master, combat, deck-building
│   ├── skills/                 #   7 strategy skills (combat-loop, map-pathing, etc.)
│   └── commands/play.md        #   /play auto-play command
└── docs/                       # Game knowledge & strategy (tool-agnostic)
```

The tool-agnostic layer (`AGENTS.md`, `docs/`) contains all strategy and game data. The tool-specific layer (`.opencode/`) wires it into a particular agent framework. Porting to another tool means creating its equivalent wiring (e.g., `CLAUDE.md` for Claude Code) while reusing the same `docs/`.

## Development

### Editing Strategy

The AI's decision-making is driven by two core documents:

| File | Purpose |
|------|---------|
| `docs/deck-building-framework.md` | Card evaluation tiers, pickup/skip rules |
| `docs/builds.md` | Build strategy (Progressive Infinite) |

These are the **single source of truth**. All skills and agents reference them. To change how the AI plays, edit these two files first.

### Editing Agents & Skills

| Layer | Files | What It Controls |
|-------|-------|-----------------|
| Agents | `.opencode/agents/*.md` | Screen routing, dispatch logic, output format |
| Skills | `.opencode/skills/*/SKILL.md` | Step-by-step procedures (combat turns, shop buying, etc.) |
| Docs | `docs/*.md` | Raw game data (card stats, enemy patterns, relic effects) |

### Updating Game Data

When the game patches, update `docs/` files with new card/enemy/relic data. The strategy documents may also need adjustment if balance changes affect the build.

### Bug Reporting

The CLI supports structured bug reports with automatic game state snapshots:

```bash
./sts2 report_bug --title "Card not found" --description "BASH disappeared from hand mid-combat" --severity high --labels "combat,play_card"
```

Reports are saved as JSON in `sts2-cli-bugs/`.

## Related Projects

| Project | Description |
|---------|-------------|
| [STS2-Cli-Mod](https://github.com/longkerdandy/STS2-Cli-Mod) | BepInEx mod + CLI for STS2 |
| [STS2-AI-Agent](https://github.com/longkerdandy/STS2-AI-Agent) | Full version of the AI player |

## License

MIT
