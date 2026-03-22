---
description: Full auto combat + reward settlement — plays until combat ends and rewards are claimed
agent: combat
---

Load the `combat-loop` skill, then execute the full combat and reward settlement:

**Phase 1: Combat**

1. Run `./sts2 state` to confirm we are in combat (`screen == "COMBAT"`).
2. If not in combat, check if on reward screen (`screen == "REWARD"`) and skip to Phase 2.
3. If in combat, begin the combat loop:
   - Each turn: analyze board, plan full turn, execute all card plays and potion uses, end turn.
   - After ending turn, observe enemy actions from the response.
   - Repeat until combat ends.
4. When combat ends, report the result (win/loss, final HP).

**Phase 2: Reward Settlement**

5. Run `./sts2 state` to confirm `screen == "REWARD"`.
6. Claim non-card rewards first (Gold, Potion, Relic) via `./sts2 claim_reward <index>`.
   - If `POTION_BELT_FULL`, skip the potion reward.
7. For card rewards, **load the `card-reward` skill** and read `docs/builds.md` for archetype strategy:
   - Identify current build archetype (check `run-state.md` for prior assessment).
   - Evaluate `card_choices[]` using the card-reward skill's 5-step procedure.
   - `./sts2 choose_card <reward_index> <card_index>` to pick, or `./sts2 skip_card <reward_index>` to skip.
   - Update `run-state.md` if the pick meaningfully shifts deck strategy.
8. When all rewards are handled, `./sts2 proceed` to leave the reward screen.
9. Report rewards claimed and cards chosen/skipped.

Before every action, output 1 sentence explaining the decision with specific numbers.

If encountering unfamiliar enemies, read `docs/enemies.md`. If the hand is complex, load the `card-evaluation` skill. If multiple enemies are alive, load the `targeting-priority` skill. If holding potions in a tough fight, load the `potion-timing` skill. If evaluating card rewards, load the `card-reward` skill and read `docs/builds.md`.

$ARGUMENTS
