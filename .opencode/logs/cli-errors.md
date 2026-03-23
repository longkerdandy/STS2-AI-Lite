# CLI Error Log

This file records potential CLI MOD errors, limitations, and workarounds encountered during gameplay.

## Log Format

Each entry should include:
- **Timestamp**: When the issue occurred
- **Command**: The CLI command that triggered the issue
- **Error Type**: TIMEOUT / ACTION_CANCELLED / TUI_GLITCH / OTHER
- **Description**: What happened
- **Context**: Combat situation, game state
- **Workaround**: How it was resolved or avoided
- **Status**: OPEN / RESOLVED / WONT_FIX

---

## Entries


---

## Known CLI Limitations

1. **Interactive Elements**: Potions/abilities requiring user choice (discard selection, target selection for multi-target) may timeout or glitch
2. **TUI Mode**: Visual output can flood terminal during certain animations
3. **State Sync**: After errors, game state may desync requiring explicit refresh
4. **Concurrent Actions**: Rapid successive commands may fail; always verify with state check

## Recommendations for AI

### When to Log
- Any non-zero exit code from `./sts2`
- TIMEOUT errors
- ACTION_CANCELLED after successful previous action
- Successful API response but visual/TUI glitches
- Unexplained state changes (cards disappearing, wrong enemy HP)

### When NOT to Log
- Expected combat end (COMBAT_ENDING)
- Valid game logic blocks (CANNOT_PLAY_CARD with EnergyCostTooHigh)
- Connection errors (game not running)

### Recovery Protocol
1. On error, immediately `./sts2 state`
2. If state is consistent: continue with different card/action
3. If state is inconsistent: document in this log, note workaround used
4. If TUI floods: Ctrl+C or Enter, then verify state

---

*Last Updated: 2024-03-23*
*CLI Version: STS2-Cli-Mod (development)*
