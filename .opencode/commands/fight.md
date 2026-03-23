---
description: Full auto combat + reward settlement — plays until combat ends and rewards are claimed
agent: combat
---

Load the `combat-loop` skill, then execute the full combat and reward settlement.

**Phase 1: Combat**

Load `combat-loop` skill and follow its procedure to:
1. Run `./sts2 state` to confirm we are in combat (`screen == "COMBAT"`).
2. Execute the combat loop until combat ends.
3. Report the result (win/loss, final HP).

**Phase 2: Reward Settlement**

Load `card-reward` skill and follow its procedure to:
1. Run `./sts2 state` to confirm `screen == "REWARD"`.
2. Claim non-card rewards (Gold, Potion, Relic).
3. Evaluate and choose/skip card rewards.
4. Run `./sts2 proceed` to leave the reward screen.
5. Report rewards claimed.

Before every action, output 1 sentence explaining the decision with specific numbers.

If encountering unfamiliar enemies, read `docs/enemies.md`. For card rewards, read `docs/builds.md`.

$ARGUMENTS
