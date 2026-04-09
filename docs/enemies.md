# Enemy Reference

> AI-optimized enemy reference for Slay the Spire 2 combat decisions.
> Damage values shown as Normal/Ascension. Single value means same for both.
> Intent damage is per-hit; multiply by hits for total incoming damage.

## Bosses

### Ceremonial Beast

- **HP**: 150/160
- **Moves**:
  - **Stamp**: Applies Plow power to self
  - **Plow**: 18/20 damage + gains 2 Strength
  - **Beast Cry**: Applies Ringing to player
  - **Stomp**: Attack (follows Beast Cry)
  - **Crush**: 17/19 damage + gains 3/4 Strength
- **Pattern**: Stamp -> Plow (repeats) -> [stun] -> Beast Cry -> Stomp -> Crush -> Beast Cry -> loop
- **Notes**: Plow power causes repeated attacks. Stun occurs after enough Plow stacks.

### Devoted Sculptor

- **HP**: 162/172
- **Moves**:
  - **Forbidden Incantation**: Gains Ritual 9 (9 Strength per turn permanently)
  - **Savage**: 12/15 damage (repeats forever)
- **Pattern**: Incantation -> Savage -> Savage -> ...
- **Notes**: Extremely dangerous scaling. Kill quickly or block escalating damage.

### Doormaker

- **HP**: Phase 1 "Door" has infinite HP
- **Moves**:
  - **Dramatic Open**: Transforms, summons enemies, applies Hunger of the Void
  - **Beam**: 10/11 damage x3 hits
  - **Chomp**: 40/45 damage
  - **Pulverize**: 20/22 damage + gains 2/3 Strength
- **Pattern**: Open -> Beam -> Chomp -> Pulverize -> Beam -> loop
- **Notes**: Phase 1 is invincible. Phase 2 starts after Dramatic Open.

### Fabricator

- **HP**: 150/155
- **Starting**: Spawns bots (Zapbot, Stabbot, Guardbot, Noisebot)
- **Moves**:
  - **Fabricate**: Summon 2 bots
  - **Fabricating Strike**: 18/21 damage + summon 1 bot
  - **Disintegrate**: 11/13 damage (used when 4+ allies alive)
- **Pattern**: Summons when <4 allies, attacks otherwise
- **Notes**: Kill bots to force Fabricator into summoning mode (less damage). See Minions section for bot stats.

### Frog Knight

- **HP**: 191/199
- **Starting**: 15/19 Plating
- **Moves**:
  - **Tongue Lash**: 13/14 damage + 2 Frail
  - **Strike Down Evil**: 21/23 damage
  - **For the Queen**: Gains 5 Strength
  - **Beetle Charge**: 35/40 damage (once, when <50% HP)
- **Pattern**: Tongue Lash -> Strike Down Evil -> For the Queen -> [conditional: Tongue Lash or Beetle Charge] -> repeat
- **Notes**: Beetle Charge is a one-time massive hit when below half HP. Prepare block.

### Globe Head

- **HP**: 148/158
- **Starting**: Galvanic 6
- **Moves**:
  - **Shocking Slap**: 13/14 damage + 2 Frail
  - **Thunder Strike**: 6/7 damage x3 hits
  - **Galvanic Burst**: 16/17 damage + gains 2 Strength
- **Pattern**: Shocking Slap -> Thunder Strike -> Galvanic Burst -> repeat
- **Notes**: Galvanic passive deals damage when hit. Frail reduces your block.

### Infested Prism

- **HP**: 200/215
- **Starting**: Vital Spark
- **Moves**:
  - **Jab**: 22/24 damage
  - **Radiate**: 16/18 damage + 16/18 block
  - **Whirlwind**: 9/10 damage x3 hits
  - **Pulsate**: 20/22 block + gains 4/5 Strength
- **Pattern**: Jab -> Radiate -> Whirlwind -> Pulsate -> repeat
- **Notes**: Pulsate is the scaling turn - good time to deal unblocked damage.

### Knowledge Demon

- **Moves**:
  - **Curse of Knowledge**: Player chooses a Curse card to add
  - **Slap**: Attack
  - **Knowledge Overwhelming**: 8/9 damage x3 hits
  - **Ponder**: 11/13 damage + heals 30 HP + gains 2/3 Strength
- **Pattern**: Curse -> Slap -> Knowledge Overwhelming -> Ponder -> repeat
- **Notes**: Ponder heals and scales. Burst damage before Ponder turns.

### Lagavulin Matriarch

- **Starting**: 12 Plating + 3 Asleep turns
- **Moves**:
  - **Slash**: 19/21 damage
  - **Disembowel**: 9/10 damage x2 hits
  - **Slash + Block**: 12/14 damage + 12/14 block
  - **Soul Siphon**: Player loses 2 Strength and 2 Dexterity, she gains 2 Strength
- **Pattern**: Slash -> Disembowel -> Slash+Block -> Soul Siphon -> repeat
- **Notes**: Starts sleeping with Plating. Wakes after 3 turns or when attacked. Soul Siphon is devastating - try to kill before multiple siphons.

### Louse Progenitor

- **HP**: 134-136/138-141
- **Starting**: Curl Up (14/18 block on first hit)
- **Moves**:
  - **Web Cannon**: 9/10 damage + 2 Frail
  - **Curl and Grow**: 14/18 block + gains 5 Strength
  - **Pounce**: 14/16 damage
- **Pattern**: Web Cannon -> Curl and Grow -> Pounce -> repeat
- **Notes**: Curl and Grow is the scaling turn. High priority kill target.

### Mecha Knight

- **Starting**: 3 Artifact
- **Moves**:
  - **Charge**: 25/30 damage
  - **Flamethrower**: Adds 4 Burns to player deck
  - **Windup**: 15 block + gains 5 Strength
  - **Heavy Cleave**: 35/40 damage
- **Pattern**: Charge -> Flamethrower -> Windup -> Heavy Cleave -> Flamethrower -> loop
- **Notes**: 3 Artifact blocks first 3 debuffs. Heavy Cleave after Windup is extremely dangerous.

### Owl Magistrate

- **HP**: 234/243
- **Moves**:
  - **Scrutiny**: 16/17 damage
  - **Peck Assault**: 4/4 damage x6 hits
  - **Judicial Flight**: Gains Soar power
  - **Verdict**: 33/36 damage + 4 Vulnerable
- **Pattern**: Scrutiny -> Peck Assault -> Judicial Flight -> Verdict -> repeat
- **Notes**: Verdict hits very hard with Vulnerable follow-up. Soar may reduce damage taken.

### Queen

- **Moves**:
  - **Off with Your Head**: 3/4 damage x5 hits
  - **Puppet Strings**: Applies 3 Chains of Binding
  - **You're Mine**: 99 Frail + 99 Weak + 99 Vulnerable
  - **Burn Bright**: All allies gain 1 Strength + 20 block to allies
- **Notes**: Paired with Torch Head Amalgam minion. You're Mine is near-lethal debuff. Puppet Strings locks cards.

### Slimy Berserker

- **HP**: 266/276
- **Moves**:
  - **Vomit Ichor**: Adds 10 Slimed cards to discard pile
  - **Furious Pummeling**: 4/5 damage x4 hits
  - **Leeching Hug**: 3 Weak + gains 3 Strength
  - **Smother**: 30/33 damage
- **Pattern**: Vomit Ichor -> Furious Pummeling -> Leeching Hug -> Smother -> repeat
- **Notes**: Slimed cards clog your deck. Smother is the big hit each cycle.

### Soul Nexus

- **HP**: 234/254
- **Moves**:
  - **Soul Burn**: 29/31 damage
  - **Maelstrom**: 6/7 damage x4 hits
  - **Drain Life**: 18/19 damage + 2 Vulnerable + 2 Weak
- **Pattern**: Random (no repeat), starts with Soul Burn
- **Notes**: Unpredictable after turn 1. All moves are threatening.

### Terror Eel

- **HP**: 140/150
- **Starting**: Shriek 70/75 (shield that triggers Terror on break)
- **Moves**:
  - **Crash**: 16/18 damage
  - **Thrash**: 3/4 damage x3 hits + 6 Vigor
  - **Terror**: 99 Vulnerable (triggered when Shriek breaks)
- **Pattern**: Crash -> Thrash -> Crash -> loop. Stun + Terror when Shriek HP reaches 0.
- **Notes**: Shriek acts as a threshold shield. Breaking it applies massive Vulnerable. Time your burst carefully.

### The Adversary Mk1

- **HP**: 100
- **Starting**: 0 Artifact
- **Moves**:
  - **Smash**: 12 damage
  - **Beam**: 15 damage
  - **Barrage**: 8 damage x2 hits + gains 2 Strength
- **Pattern**: Smash -> Beam -> Barrage -> repeat

### The Adversary Mk2

- **HP**: 200
- **Starting**: 1 Artifact
- **Moves**:
  - **Bash**: 13 damage
  - **Flame Beam**: 16 damage
  - **Barrage**: 9 damage x2 hits + gains 3 Strength
- **Pattern**: Bash -> Flame Beam -> Barrage -> repeat

### The Adversary Mk3

- **HP**: 300
- **Starting**: 2 Artifact
- **Moves**:
  - **Crash**: 15 damage
  - **Flame Beam**: 18 damage
  - **Barrage**: 10 damage x2 hits + gains 4 Strength
- **Pattern**: Crash -> Flame Beam -> Barrage -> repeat

### The Insatiable

- **Moves**:
  - **Liquify Ground**: Applies Sandpit + adds 6 Frantic Escape cards
  - **Thrash**: 8/9 damage x2 hits
  - **Lunging Bite**: 28/31 damage
  - **Salivate**: Gains 2/3 Strength
- **Pattern**: Liquify Ground -> Thrash -> Lunging Bite -> Salivate -> Thrash -> loop
- **Notes**: Sandpit limits mobility. Lunging Bite is the big hit - block accordingly.

### Waterfall Giant

- **Starting**: Steam Eruption power (15/20 damage to player at end of each turn)
- **Moves**:
  - **Pressure Gun**: Starts at 20/23 damage, +5 each use
  - **Siphon**: Heals 15 HP
  - **Death Blow**: Damage equal to Steam Eruption amount
  - **Pressurize**: Buff move
  - **Stomp**: Attack + Weak
  - **Ram**: Attack
- **Pattern**: Pressurize -> Stomp -> Ram -> Siphon -> Pressure Gun -> Pressure Up -> repeat
- **Notes**: Steam Eruption is passive unavoidable damage. Pressure Gun escalates each use.

## Elites

### Byrdonis

- **HP**: 91-94/99
- **Starting**: Territorial
- **Moves**:
  - **Peck**: 3/4 damage x3 hits
  - **Swoop**: 17/19 damage
- **Pattern**: Swoop -> Peck -> Swoop -> repeat

### Entomancer

- **HP**: 145/155
- **Starting**: Personal Hive
- **Moves**:
  - **Pheromone Spit**: Gains +1 Hive + 1 Strength (or +2 Strength if Hive >= 3)
  - **Bees**: 7/8 damage x3 hits
  - **Spear**: 18/20 damage
- **Pattern**: Bees -> Spear -> Pheromone Spit -> repeat
- **Notes**: Scales via Hive stacks. Kill before stacks accumulate.

### Flail Knight

- **HP**: 101/108
- **Moves**:
  - **Flail**: 9/10 damage x2 hits
  - **Ram**: 15/17 damage
  - **War Chant**: Gains 3 Strength
- **Pattern**: Starts with Ram. Random after each (cannot repeat War Chant consecutively).

### Hunter Killer

- **HP**: 121/126
- **Moves**:
  - **Tenderizing Goop**: Applies Tender debuff
  - **Bite**: 17/19 damage
  - **Puncture**: 7/8 damage x3 hits
- **Pattern**: Tenderizing Goop -> random (Bite no-repeat, Puncture x2 weight)

### MagiKnight

- **HP**: 82/89
- **Moves**:
  - **Power Shield**: 6/7 damage + 5/9 block
  - **Dampen**: Applies Dampen power on player
  - **Spear**: 10/11 damage
  - **Prep**: 5/9 block
  - **Magic Bomb**: 35/40 damage
- **Pattern**: Power Shield -> Dampen -> Spear -> Prep -> Magic Bomb -> Spear -> Prep -> Magic Bomb -> loop
- **Notes**: Magic Bomb is devastating. Block heavily on Magic Bomb turns.

### Mysterious Knight

- **HP**: 101/108 (same as Flail Knight)
- **Starting**: 6 Strength + 6 Plating
- **Moves**: Same as Flail Knight (Flail, Ram, War Chant)
- **Notes**: Starts with huge Strength bonus. Much more dangerous than regular Flail Knight.

### Skulking Colony

- **HP**: 74/79
- **Starting**: 15 Hardened Shell
- **Moves**:
  - **Smash**: 9/11 damage + adds 5 Dazed to draw pile
  - **Zoom**: 16/17 damage + 10/13 block
  - **Inertia**: Gains 3/4 Strength + adds 3 Dazed to draw pile
  - **Piercing Stabs**: 7/8 damage x2 hits
- **Pattern**: Smash -> Zoom -> Inertia -> Piercing Stabs -> repeat

### Spectral Knight

- **HP**: 93/97
- **Moves**:
  - **Hex**: Applies 2 Hex on all players
  - **Soul Slash**: 15/17 damage
  - **Soul Flame**: 3/4 damage x3 hits
- **Pattern**: Hex -> Soul Slash -> random (Soul Slash or Soul Flame, no repeat Soul Flame) -> loop
- **Notes**: Hex is very dangerous - reduces the value of non-attack cards.

### Spiny Toad

- **HP**: 116-119/121-124
- **Moves**:
  - **Protruding Spikes**: Gains 5 Thorns
  - **Spike Explosion**: 23/25 damage (removes Thorns)
  - **Tongue Lash**: 17/19 damage
- **Pattern**: Protruding Spikes -> Spike Explosion -> Tongue Lash -> repeat
- **Notes**: Has Thorns - take damage when attacking. Spike Explosion removes them.

### Thieving Hopper

- **HP**: 84/79 (79/84)
- **Starting**: Escape Artist 5
- **Moves**:
  - **Thievery**: 17/19 damage + steals a card from your deck
  - **Flutter**: Gains Flutter 5 (evasion buff)
  - **Hat Trick**: 21/23 damage
  - **Nab**: 14/16 damage
  - **Escape**: Flees combat
- **Pattern**: Thievery -> Flutter -> Hat Trick -> Nab -> Escape -> (repeats Escape)
- **Notes**: Will steal cards and flee. Kill before Escape turn to recover stolen cards.

## Normal Enemies

### Axebot

- **Moves**:
  - **The One-Two**: 2-hit attack
  - **Boot Up**: 10 block + gains 1 Strength
  - **Sharpen**: Gains 4 Strength
  - **Hammer Uppercut**: 1 Weak + 1 Frail
- **Starting**: 2 Stock
- **Notes**: Multi-move robot. Sharpen is a big buff - prioritize killing.

### Bowlbug Egg

- **HP**: 21-22/23-24
- **Moves**:
  - **Bite**: 7/8 damage + 7/8 block
- **Pattern**: Bite (repeats)
- **Notes**: Attacks and blocks every turn. Simple but persistent.

### Bowlbug Nectar

- **HP**: 35-38/36-39
- **Moves**:
  - **Thrash**: 3 damage
  - **Buff**: Gains 15/16 Strength
- **Pattern**: Thrash -> Buff -> Thrash (repeats Thrash forever)
- **Notes**: Buff turn grants massive Strength. Kill before or immediately after the buff.

### Bowlbug Rock

- **HP**: 45-48/46-49
- **Starting**: Imbalanced power
- **Moves**:
  - **Headbutt**: 15/16 damage
  - **Dizzy**: Stunned (does nothing)
- **Pattern**: Headbutt -> [if off-balance: Dizzy -> Headbutt] -> [if not: Headbutt] -> repeat
- **Notes**: Stuns itself after headbutt if off-balance. Free damage window during Dizzy.

### Bowlbug Silk

- **HP**: 40-43/41-44
- **Moves**:
  - **Thrash**: 4/5 damage x2 hits
  - **Toxic Spit**: Applies 1 Weak
- **Pattern**: Toxic Spit -> Thrash -> Toxic Spit -> repeat

### Bygone Effigy

- **Starting**: Sleeping with Slow power
- **Moves**:
  - **Wake**: Gains 10 Strength
  - **Slash**: Attack (repeats after waking)
- **Pattern**: Sleep -> Wake -> Slash -> Slash -> ...
- **Notes**: Starts asleep. Wakes and gains massive Strength. Kill while sleeping if possible.

### Calcified Cultist

- **HP**: 38-41/39-42
- **Moves**:
  - **Incantation**: Gains Ritual 2 (2 Strength per turn permanently)
  - **Dark Strike**: 9/11 damage (repeats)
- **Pattern**: Incantation -> Dark Strike -> Dark Strike -> ...
- **Notes**: Low scaling but grows over time. Kill early.

### Chomper

- **Starting**: 2 Artifact
- **Moves**:
  - **Clamp**: 2-hit attack
  - **Screech**: Adds 3 Dazed to discard pile
- **Notes**: Artifact blocks first 2 debuffs. Dazed cards clog deck.

### Corpse Slug

- **HP**: 25-27/27-29
- **Starting**: Ravenous 4/5
- **Moves**:
  - **Whip Slap**: 3 damage x2 hits
  - **Glomp**: 8/9 damage
  - **Goop**: 2 Frail
- **Pattern**: Rotates (staggered per slug in multi-slug encounters)

### Crusher

- **Starting**: Back Attack Left + Crab Rage
- **Moves**:
  - **Thrash**: Attack
  - **Enlarging Strike**: Attack
  - **Bug Sting**: 6/7 damage x2 hits + 2 Weak + 2 Frail
  - **Adapt**: Gains 2/3 Strength
  - **Guarded Strike**: 12/14 damage + 18 block
- **Pattern**: Thrash -> Enlarging Strike -> Bug Sting -> Adapt -> Guarded Strike -> repeat

### Cubex Construct

- **HP**: 65/70
- **Starting**: 13 block + 1 Artifact
- **Moves**:
  - **Charge Up**: Gains 2 Strength
  - **Repeater Blast**: 7/8 damage + gains 2 Strength
  - **Expel Blast**: 5/6 damage x2 hits
  - **Submerge**: 15 block
- **Pattern**: Charge Up -> Repeater Blast -> Repeater Blast -> Expel Blast -> Repeater Blast -> loop

### Damp Cultist

- **HP**: 51-53/52-54
- **Moves**:
  - **Incantation**: Gains Ritual 5/6 (Strength per turn permanently)
  - **Dark Strike**: 1/3 damage (repeats)
- **Pattern**: Incantation -> Dark Strike -> Dark Strike -> ...
- **Notes**: High ritual value but very low base damage. Still scales dangerously over many turns.

### Decimillipede Segment

- **HP**: 40-46/46-52 (per segment)
- **Starting**: Reattach 25 (revives with 25 HP after death)
- **Moves**:
  - **Writhe**: 5/6 damage x2 hits
  - **Bulk**: 6/7 damage + gains 2 Strength
  - **Constrict**: 8/9 damage + 1 Weak
- **Pattern**: Staggered start per segment. Writhe -> Constrict -> Bulk -> rotate. After death + reattach: random (no repeat).
- **Notes**: Multi-segment boss encounter. Segments revive via Reattach. Must kill all segments while managing reattaches. Each segment has unique HP to avoid ties.

### Exoskeleton

- **HP**: 24-28/25-29
- **Starting**: Hard to Kill 9
- **Moves**:
  - **Skitter**: 1 damage x3/4 hits
  - **Mandibles**: 8/9 damage
  - **Enrage**: Gains 2 Strength
- **Pattern**: Slot-dependent start, then: Skitter -> random / Mandibles -> Enrage -> random
- **Notes**: Hard to Kill prevents dying until HP drops below threshold. Multi-hit Skitter benefits from Strength.

### Eye With Teeth

- **HP**: 6
- **Starting**: Illusion power (minion)
- **Moves**:
  - **Distract**: Adds 3 Dazed to draw pile
- **Pattern**: Distract (repeats)
- **Notes**: Fogmog minion. Low HP but Dazed cards are disruptive.

### Flyconid

- **HP**: 47-49/51-53
- **Moves**:
  - **Vuln Spores**: 2 Vulnerable
  - **Frail Spores**: 8/9 damage + 2 Frail
  - **Smash**: 11/12 damage
- **Pattern**: Random (weighted)

### Fogmog

- **HP**: 74/78
- **Moves**:
  - **Illusion**: Summons Eye With Teeth minion
  - **Swipe**: 8/9 damage + gains 1 Strength
  - **Headbutt**: 14/16 damage
- **Pattern**: Illusion -> Swipe -> random (Swipe or Headbutt, no repeat) -> loop
- **Notes**: Kill Eye With Teeth minions to stop Dazed flooding.

### Fossil Stalker

- **HP**: 51-53/54-56
- **Starting**: 3 Suck
- **Moves**:
  - **Tackle**: 9/11 damage + 1 Frail
  - **Latch**: 12/14 damage
  - **Lash**: 3/4 damage x2 hits
- **Pattern**: Random (weighted)

### Fuzzy Wurm Crawler

- **HP**: 55-57/58-59
- **Moves**:
  - **Acid Goop**: 4/6 damage
  - **Inhale**: Gains 7 Strength
- **Pattern**: Acid Goop -> Inhale -> Acid Goop -> Acid Goop -> Inhale -> loop
- **Notes**: Inhale gives massive Strength. Damage ramps fast after inhale.

### Gas Bomb

- **HP**: 7/8
- **Starting**: Minion
- **Moves**:
  - **Explode**: 8/9 damage (dies after exploding)
- **Pattern**: Explode (one-time, then dies)
- **Notes**: Living Fog minion. Kill before it explodes or accept the damage.

### Gremlin Merc

- **HP**: 47-49/51-53
- **Starting**: Surprise power + Thievery 20 (steals gold on attacks)
- **Moves**:
  - **Gimme**: 7/8 damage x2 hits (steals gold)
  - **Double Smash**: 6/7 damage x2 hits + 2 Weak (steals gold)
  - **Hehe**: 8/9 damage + gains 2 Strength (steals gold)
- **Pattern**: Gimme -> Double Smash -> Hehe -> repeat
- **Notes**: Steals gold with every attack. Kill quickly to minimize gold loss.

### Fat Gremlin

- **HP**: 13-17/14-18
- **Moves**:
  - **Spawned**: Stunned (does nothing first turn)
  - **Flee**: Escapes combat
- **Pattern**: Spawned -> Flee
- **Notes**: Gremlin Merc summon. Spawns stunned, then flees next turn. Free kill if you have spare damage.

### Sneaky Gremlin

- **HP**: 10-14/11-15
- **Moves**:
  - **Spawned**: Stunned (does nothing first turn)
  - **Tackle**: 9/10 damage (repeats)
- **Pattern**: Spawned -> Tackle -> Tackle -> ...
- **Notes**: Gremlin Merc summon. Spawns stunned, then attacks. Kill before it acts.

### Inklet

- **HP**: 11-17/12-18
- **Starting**: 1 Slippery
- **Moves**:
  - **Jab**: 3/4 damage
  - **Whirlwind**: 2/3 damage x3 hits
  - **Piercing Gaze**: 10/11 damage
- **Pattern**: Random

### Kin Follower

- **HP**: 58-59/62-63
- **Starting**: Minion
- **Moves**:
  - **Quick Slash**: 5 damage
  - **Boomerang**: 2 damage x2 hits
  - **Power Dance**: Gains 2/3 Strength
- **Pattern**: Quick Slash -> Boomerang -> Power Dance -> repeat (some start with Power Dance)
- **Notes**: Kin Priest minion. Scales with Power Dance. Kill to weaken the Kin encounter.

### Kin Priest

- **HP**: 190/199
- **Moves**:
  - **Orb of Frailty**: 8/9 damage + 1 Frail
  - **Orb of Weakness**: 8/9 damage + 1 Weak
  - **Beam**: 3 damage x3 hits
  - **Ritual**: Gains 2/3 Strength
- **Pattern**: Orb of Frailty -> Orb of Weakness -> Beam -> Ritual -> repeat
- **Notes**: Boss-tier enemy. Paired with Kin Followers. Applies debuffs and scales. Consider killing Followers first to reduce total damage.

### Leaf Slime (M)

- **HP**: 32-35/33-36
- **Moves**:
  - **Clump Shot**: 8/9 damage
  - **Sticky Shot**: Adds 2 Slimed to discard pile
- **Pattern**: Sticky Shot -> Clump Shot -> Sticky Shot -> repeat

### Leaf Slime (S)

- **HP**: 11-15/12-16
- **Moves**:
  - **Tackle**: 3/4 damage
  - **Goop**: Adds 1 Slimed to discard pile
- **Pattern**: Random (no repeat)

### Living Fog

- **HP**: 80/82
- **Moves**:
  - **Advanced Gas**: 8/9 damage + Smoggy debuff
  - **Bloat**: 5/6 damage + summons Gas Bombs (increasing count)
  - **Super Gas Blast**: 8/9 damage
- **Pattern**: Advanced Gas -> Bloat -> Super Gas Blast -> Bloat -> loop
- **Notes**: Summons explosive Gas Bomb minions. Kill bombs or accept splash damage.

### Living Shield

- **HP**: 55/65
- **Starting**: 25 Rampart
- **Moves**:
  - **Shield Slam**: 6 damage (while allies alive)
  - **Smash**: 16/18 damage + gains 3 Strength (when alone, repeats)
- **Notes**: Weak while allies alive. Becomes dangerous when alone. Kill allies first, then focus shield.

### Mawler

- **HP**: 72/76
- **Moves**:
  - **Rip and Tear**: 14/16 damage
  - **Roar**: 3 Vulnerable (used once)
  - **Claw**: 4/5 damage x2 hits
- **Pattern**: Starts with Claw. Random (no repeat). Roar used only once.

### Myte

- **HP**: 61-67/64-69
- **Moves**:
  - **Toxic**: Adds 2 Toxic cards to hand
  - **Bite**: 13/15 damage
  - **Suck**: 4/6 damage + gains 2/3 Strength
- **Pattern**: Slot-dependent start. Toxic -> Bite -> Suck -> repeat

### Nibbit

- **HP**: 42-46/44-48
- **Moves**:
  - **Butt**: 12/13 damage
  - **Slice**: 6/7 damage + 5/6 block
  - **Hiss**: Gains 2/3 Strength
- **Pattern**: Position-dependent start. Butt -> Slice -> Hiss -> repeat

### Ovicopter

- **HP**: 124-130/126-132
- **Moves**:
  - **Lay Eggs**: Summons 3 Tough Eggs
  - **Smash**: 16/17 damage
  - **Tenderizer**: 7/8 damage + 2 Vulnerable
  - **Nutritional Paste**: Gains 3/4 Strength (when >=4 allies)
- **Pattern**: Lay Eggs -> Smash -> Tenderizer -> [conditional summon or buff] -> repeat
- **Notes**: Summons Tough Eggs that hatch into Hatchlings. Kill eggs before they hatch.

### Parafright

- **HP**: 21
- **Starting**: Illusion power (minion)
- **Moves**:
  - **Slam**: 16/17 damage
- **Pattern**: Slam (repeats)
- **Notes**: Obscura minion. Low HP but surprisingly high damage.

### Phantasmal Gardener

- **HP**: 26-31/27-32
- **Starting**: Skittish 6/7
- **Moves**:
  - **Bite**: 5 damage
  - **Lash**: 7 damage
  - **Flail**: 1 damage x3 hits
  - **Enlarge**: Gains 2/3 Strength
- **Pattern**: Slot-dependent start. Bite -> Lash -> Flail -> Enlarge -> repeat

### Phrog Parasite

- **HP**: 61-64/66-68
- **Starting**: 4 Infested
- **Moves**:
  - **Infect**: Adds 3 Infection cards to deck
  - **Lash**: 4/5 damage x4 hits
- **Pattern**: Infect -> Lash -> Infect -> repeat
- **Notes**: Infection cards are dangerous status cards. Kill quickly.

### Punch Construct

- **HP**: 55/60
- **Starting**: 1 Artifact
- **Moves**:
  - **Ready**: 10 block
  - **Strong Punch**: 14/16 damage
  - **Fast Punch**: 5/6 damage x2 hits + 1 Weak
- **Pattern**: Ready -> Strong Punch -> Fast Punch -> repeat

### Rocket

- **Starting**: Surrounded + Back Attack Right + Crab Rage
- **Moves**:
  - **Target**: 3/4 damage
  - **Precision Beam**: 18/20 damage
  - **Charge Up**: Gains 2/3 Strength
  - **Laser**: 31/35 damage
  - **Recharge**: Sleeps (does nothing)
- **Pattern**: Target -> Precision Beam -> Charge Up -> Laser -> Recharge -> repeat
- **Notes**: Laser is extremely high damage. Block heavily on Laser turn.

### Scroll of Biting

- **HP**: 31-38/32-39
- **Starting**: Paper Cuts 2
- **Moves**:
  - **Chomp**: 14/16 damage
  - **Chew**: 5/6 damage x2 hits
  - **More Teeth**: Gains 2 Strength
- **Pattern**: Slot-dependent start. Chomp -> More Teeth -> Chew -> random (Chomp no-repeat, Chew x2 weight) -> loop

### Seapunk

- **HP**: 44-46/47-49
- **Moves**:
  - **Sea Kick**: 11/13 damage
  - **Spinning Kick**: 2 damage x4 hits
  - **Bubble Burp**: 7/8 block + gains 1/2 Strength
- **Pattern**: Sea Kick -> Spinning Kick -> Bubble Burp -> repeat

### Sewer Clam

- **HP**: 56/58
- **Starting**: 8/9 Plating
- **Moves**:
  - **Pressurize**: Gains 4 Strength
  - **Jet**: 10/11 damage
- **Pattern**: Jet -> Pressurize -> Jet -> repeat
- **Notes**: Scales 4 Strength every other turn. Kill quickly.

### Shrinker Beetle

- **HP**: 38-40/40-42
- **Moves**:
  - **Shrinker**: Applies Shrink debuff
  - **Chomp**: 7/8 damage
  - **Stomp**: 13/14 damage
- **Pattern**: Shrinker -> Chomp -> Stomp -> Chomp -> repeat

### Slithering Strangler

- **HP**: 53-55/54-56
- **Moves**:
  - **Constrict**: Applies 3 Constrict (damage per turn)
  - **Thwack**: 7/8 damage + 5 block
  - **Lash**: 12/13 damage
- **Pattern**: Constrict -> random (Thwack or Lash) -> Constrict -> repeat
- **Notes**: Constrict deals unblockable damage each turn. Kill to remove it.

### Sludge Spinner

- **HP**: 37-39/41-42
- **Moves**:
  - **Oil Spray**: 8/9 damage + 1 Weak
  - **Slam**: 11/12 damage
  - **Rage**: 6/7 damage + gains 3 Strength
- **Pattern**: Random (no repeat)

### Slumbering Beetle

- **HP**: 86/89
- **Starting**: 15/18 Plating + 3 Slumber (asleep)
- **Moves**:
  - **Snore**: Does nothing (while sleeping)
  - **Rollout**: 16/18 damage + gains 2 Strength (repeats after waking)
- **Pattern**: Snores until woken (Slumber removed by attacks). Rollout repeats forever after waking.
- **Notes**: Plating removed on wake. Scales with Strength each turn after waking.

### Snapping Jaxfruit

- **HP**: 31-33/34-36
- **Moves**:
  - **Energy Orb**: 3/4 damage + gains 2 Strength
- **Pattern**: Energy Orb (repeats every turn)
- **Notes**: Constant Strength scaling. Priority kill target.

### Soul Fysh

- **Moves**:
  - **Beckon**: Adds 2 Beckon cards to hand
  - **De-Gas**: 16/17 damage
  - **Gaze**: 7/8 damage + adds 1 Beckon card
  - **Fade**: Gains 2 Intangible
  - **Scream**: 11/12 damage + 3 Vulnerable
- **Pattern**: Beckon -> De-Gas -> Gaze -> Fade -> Scream -> repeat
- **Notes**: Intangible on Fade turn reduces all damage to 1. Don't waste big attacks on that turn.

### The Forgotten

- **HP**: 106/111
- **Starting**: Possess Speed
- **Moves**:
  - **Miasma**: Player loses 2/3 Dexterity + 8 block + gains 2/3 Dexterity
  - **Dread**: 13/15 damage + bonus from Dexterity
- **Pattern**: Miasma -> Dread -> repeat
- **Notes**: Steals your Dexterity, making your block weaker. Kill quickly.

### The Lost

- **HP**: 93/99
- **Starting**: Possess Strength
- **Moves**:
  - **Debilitating Smog**: Player loses 2/3 Strength + gains 2/3 Strength
  - **Eye Lasers**: 4/5 damage x2 hits
- **Pattern**: Debilitating Smog -> Eye Lasers -> repeat
- **Notes**: Steals your Strength, making your attacks weaker. Priority target.

### The Obscura

- **HP**: 123/129
- **Moves**:
  - **Illusion**: Summons Parafright minion
  - **Piercing Gaze**: 10/11 damage
  - **Wail**: All allies gain 3 Strength
  - **Hardening Strike**: 6/7 damage + 6/7 block
- **Pattern**: Illusion -> random (Piercing Gaze, Wail, or Hardening Strike, no repeat) -> loop
- **Notes**: Wail buffs all allies including minions. Kill minions to reduce Wail value.

### Toadpole

- **HP**: 21-25/22-26
- **Moves**:
  - **Spike Spit**: 3/4 damage x3 hits (removes 2 Thorns from self)
  - **Whirl**: 7/8 damage
  - **Spiken**: Gains 2 Thorns
- **Pattern**: Position-dependent start. Whirl -> Spiken -> Spike Spit -> repeat (or Spiken -> Spike Spit -> Whirl)
- **Notes**: Thorns damage you when attacking. Spike Spit consumes Thorns for the multi-hit.

### Tough Egg

- **HP**: 14-18/15-19 (egg), 19-22/20-23 (hatchling)
- **Starting**: Hatch power (hatches in 1-2 turns)
- **Moves**:
  - **Hatch**: Transforms into Hatchling with new HP
  - **Nibble**: 4/5 damage (repeats as hatchling)
- **Pattern**: [Egg phase with Hatch timer] -> Hatch -> Nibble -> Nibble -> ...
- **Notes**: Ovicopter summon. Kill before hatching to avoid extra enemies.

### Tunneler

- **HP**: 87/92
- **Moves**:
  - **Bite**: 13/15 damage
  - **Burrow**: Gains Burrowed power + 32/37 block
  - **Below**: 23/26 damage (while burrowed, repeats)
  - **Dizzy**: Stunned (does nothing)
- **Pattern**: Bite -> Burrow -> Below -> Below -> ...
- **Notes**: After burrowing, attacks from underground with high damage and huge block. Stun can interrupt.

### Turret Operator

- **HP**: 41/51
- **Moves**:
  - **Unload**: 3/4 damage x5 hits
  - **Reload**: Gains 1 Strength
- **Pattern**: Unload -> Unload -> Reload -> repeat
- **Notes**: Multi-hit attack scales with Strength. Each hit benefits from Strength buff.

### Twig Slime (M)

- **HP**: 26-28/27-29
- **Moves**:
  - **Clump Shot**: 11/12 damage
  - **Sticky Shot**: Adds 1 Slimed to discard pile
- **Pattern**: Sticky Shot -> random (Clump Shot x2 weight, Sticky Shot no-repeat)

### Twig Slime (S)

- **HP**: 7-11/8-12
- **Moves**:
  - **Tackle**: 4/5 damage
- **Pattern**: Tackle (repeats)

### Two-Tailed Rat

- **HP**: 17-21/18-22
- **Moves**:
  - **Scratch**: 8/9 damage
  - **Disease Bite**: 6/7 damage
  - **Screech**: 1 Frail
  - **Call for Backup**: Summons another Two-Tailed Rat
- **Pattern**: Slot-dependent start or random. Random (no repeat). Can summon after 2 turns (max 3 summons total).
- **Notes**: Can overwhelm with summons. Kill them before they multiply.

### Vantom

- **Starting**: 9 Slippery
- **Moves**:
  - **Ink Blot**: 7/8 damage
  - **Inky Lance**: 6/7 damage x2 hits
  - **Dismember**: 27/30 damage + adds 3 Wounds to deck
  - **Prepare**: Gains 2 Strength
- **Pattern**: Ink Blot -> Inky Lance -> Dismember -> Prepare -> repeat
- **Notes**: Slippery makes it dodge attacks. Dismember is a huge hit + Wounds clog deck.

### Vine Shambler

- **HP**: 61/64
- **Moves**:
  - **Grasping Vines**: 8/9 damage + applies Tangled (status card debuff)
  - **Swipe**: 6/7 damage x2 hits
  - **Chomp**: 16/18 damage
- **Pattern**: Swipe -> Grasping Vines -> Chomp -> Swipe -> repeat

### Wriggler

- **HP**: 17-21/18-22
- **Moves**:
  - **Nasty Bite**: 6/7 damage
  - **Wriggle**: 1 Infection card + gains 2 Strength
- **Pattern**: Bite -> Wriggle -> repeat (may start stunned if spawned mid-combat)

## Minions

> Summoned by other enemies. Usually have Minion power (die when summoner dies).

### Guardbot (Fabricator)

- **HP**: 16-20/17-21
- **Moves**:
  - **Guard**: 15 block to Fabricator
- **Pattern**: Guard (repeats)
- **Notes**: Protects the Fabricator. Kill to prevent blocking.

### Noisebot (Fabricator)

- **HP**: 18-23/19-24
- **Moves**:
  - **Noise**: Adds 2 Dazed (1 to discard, 1 to draw pile)
- **Pattern**: Noise (repeats)
- **Notes**: Disrupts draws with Dazed cards.

### Stabbot (Fabricator)

- **HP**: 18-23/19-24
- **Moves**:
  - **Stab**: 11/12 damage + 1 Frail
- **Pattern**: Stab (repeats)
- **Notes**: High damage for a minion. Priority kill target among bots.

### Zapbot (Fabricator)

- **HP**: 18-23/19-24
- **Starting**: High Voltage 2
- **Moves**:
  - **Zap**: 14/15 damage
- **Pattern**: Zap (repeats)
- **Notes**: High Voltage may trigger extra effects. High single-target damage.

### Torch Head Amalgam (Queen)

- **Moves**:
  - **Soul Beam**: 8 damage x3 hits
  - **Tackle**: 18/19 damage
- **Notes**: Queen's minion. Kill to reduce pressure during Queen fight.

### Ruby Raiders

> Appear as a group encounter. Small enemies with varied roles.

#### Assassin Ruby Raider

- **HP**: 18-23/19-24
- **Moves**:
  - **Killshot**: 11/12 damage
- **Pattern**: Killshot (repeats)

#### Axe Ruby Raider

- **HP**: 20-22/21-23
- **Moves**:
  - **Swing**: 5/6 damage + 5/6 block
  - **Big Swing**: 12/13 damage
- **Pattern**: Swing -> Swing -> Big Swing -> repeat

#### Brute Ruby Raider

- **HP**: 30-33/31-34
- **Moves**:
  - **Beat**: 7/8 damage
  - **Roar**: Gains 3 Strength
- **Pattern**: Beat -> Roar -> Beat -> repeat

#### Crossbow Ruby Raider

- **HP**: 18-21/19-22
- **Moves**:
  - **Fire**: 14/16 damage
  - **Reload**: 3 block
- **Pattern**: Reload -> Fire -> Reload -> repeat

#### Tracker Ruby Raider

- **HP**: 21-25/22-26
- **Moves**:
  - **Track**: 2 Frail
  - **Hounds**: 1 damage x8/9 hits
- **Pattern**: Track -> Hounds -> Hounds -> ...
- **Notes**: Hounds multi-hit benefits greatly from Strength. Track applies Frail to reduce your block.
