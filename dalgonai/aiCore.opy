#!mainFile "main.opy"

rule "Behavior: No Active CP (Control)":
    @Event eachPlayer
    @Condition (isGameInProgress() or getCurrentGamemode() == Gamemode.SKIRMISH) == true
    @Condition eventPlayer.isInSpawnRoom() == true
    @Condition getCurrentGamemode() == Gamemode.CONTROL
    
    eventPlayer.CurrentGoToTarget = random.choice(getLivingPlayers(getOppositeTeam(eventPlayer.getTeam())))
    wait(random.uniform(1, 10))
    if RULE_CONDITION:
        goto RULE_START


rule "Behavior: Capture Neutral Objective (Control)":
    @Event eachPlayer
    @Condition (isGameInProgress() or getCurrentGamemode() == Gamemode.SKIRMISH) == true
    @Condition isControlPointLocked() == false
    @Condition getCurrentGamemode() == Gamemode.CONTROL
    @Condition getControlScorePercentage(Team.1) == 0
    @Condition getControlScorePercentage(Team.2) == 0
    
    eventPlayer.CurrentGoToTarget = getObjectivePosition(getCurrentObjective())


rule "Behavior: Tanks":
    @Event eachPlayer
    @Condition (isGameInProgress() or getCurrentGamemode() == Gamemode.SKIRMISH) == true
    @Condition isControlPointLocked() == false
    @Condition getCurrentGamemode() == Gamemode.CONTROL
    @Condition eventPlayer.isInSpawnRoom() == false
    @Condition eventPlayer.getCurrentHero() in getTankHeroes() == true
    @Condition getControlScoringTeam() == eventPlayer.getTeam()
    @Condition getControlScorePercentage(getOppositeTeam(eventPlayer.getTeam())) < 70
    
    eventPlayer.CurrentGoToTarget = random.choice([player for player in getPlayers(getOppositeTeam(eventPlayer.getTeam())) if distance(getObjectivePosition(getCurrentObjective()), player) <= 45])
    wait(random.uniform(1, 10))
    if RULE_CONDITION:
        goto RULE_START


rule "Behavior: Support Tanks":
    @Event eachPlayer
    @Condition (isGameInProgress() or getCurrentGamemode() == Gamemode.SKIRMISH) == true
    @Condition isControlPointLocked() == false
    @Condition getCurrentGamemode() == Gamemode.CONTROL
    @Condition eventPlayer.isInSpawnRoom() == false
    @Condition eventPlayer.getCurrentHero() in getSupportHeroes() == true
    @Condition getControlScorePercentage(getOppositeTeam(eventPlayer.getTeam())) < 70
    
    eventPlayer.CurrentGoToTarget = sorted(getLivingPlayers(eventPlayer.getTeam()), lambda player: eventPlayer.getMaxHealth()).last()


rule "Behavior: Damage Hero":
    @Event eachPlayer
    @Condition (isGameInProgress() or getCurrentGamemode() == Gamemode.SKIRMISH) == true
    @Condition isControlPointLocked() == false
    @Condition getCurrentGamemode() == Gamemode.CONTROL
    @Condition eventPlayer.isInSpawnRoom() == false
    @Condition eventPlayer.getCurrentHero() in getDamageHeroes() == true
    @Condition getControlScoringTeam() == eventPlayer.getTeam()
    @Condition getControlScorePercentage(getOppositeTeam(eventPlayer.getTeam())) < 70
    
    eventPlayer.CurrentGoToTarget = random.choice([player for player in getPlayers(getOppositeTeam(eventPlayer.getTeam())) if distance(getObjectivePosition(getCurrentObjective()), player) <= 45])
    wait(random.uniform(1, 10))
    if RULE_CONDITION:
        goto RULE_START


rule "Behavior: Capture Objective (enemy controls it)":
    @Event eachPlayer
    @Condition (isGameInProgress() or getCurrentGamemode() == Gamemode.SKIRMISH) == true
    @Condition isControlPointLocked() == false
    @Condition getCurrentGamemode() == Gamemode.CONTROL
    @Condition getControlScoringTeam() == getOppositeTeam(eventPlayer.getTeam())
    @Condition eventPlayer.isInSpawnRoom() == false
    
    eventPlayer.CurrentGoToTarget = getObjectivePosition(getCurrentObjective())


rule "Skirmish AI":
    @Event eachPlayer
    @Condition getCurrentGamemode() == Gamemode.SKIRMISH
    
    eventPlayer.CurrentGoToTarget = random.choice([player for player in getPlayers(getOppositeTeam(eventPlayer.getTeam())) if distance(getClosestPlayer(eventPlayer, getOppositeTeam(eventPlayer.getTeam())), player) <= 45])
    wait(random.uniform(1, 10))
    if RULE_CONDITION:
        goto RULE_START


rule "Behavior: Healthpack":
    @Event eachPlayer
    @Condition (isGameInProgress() or getCurrentGamemode() == Gamemode.SKIRMISH) == true
    @Condition eventPlayer.isAlive() == true
    @Condition eventPlayer.getNormalizedHealth() < 0.6
    @Condition distance(eventPlayer, eventPlayer.ClosestHealthpackPosition[0]) <= 5
    @Condition eventPlayer.isInSpawnRoom() == false
    @Condition eventPlayer.BotActive == true
    @Condition isInLoS(eventPlayer, eventPlayer.ClosestHealthpackPosition[0], BarrierLos.PASS_THROUGH_BARRIERS) == true
    
    if distance(eventPlayer, eventPlayer.ClosestHealthpackPosition[0]) > 1:
        eventPlayer.StopAutomaticGoTo = true
        wait(0.1)
        eventPlayer.startThrottleInDirection(directionTowards(eventPlayer, eventPlayer.ClosestHealthpackPosition[0]), 1, Relativity.TO_WORLD, Throttle.REPLACE_EXISTING, ThrottleReeval.DIRECTION_AND_MAGNITUDE)
    else:
        eventPlayer.stopThrottleInDirection()
    wait(0.25)
    if RULE_CONDITION:
        goto RULE_START
    eventPlayer.StopAutomaticGoTo = false
    eventPlayer.startThrottleInDirection(directionTowards(eventPlayer, eventPlayer.CurrentWaypoint[0]), 1, Relativity.TO_WORLD, Throttle.REPLACE_EXISTING, ThrottleReeval.DIRECTION_AND_MAGNITUDE)
