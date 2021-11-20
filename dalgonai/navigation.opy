#!mainFile "main.opy"

rule "Current Waypoint - Automatic":
    @Event eachPlayer
    @Condition eventPlayer.BotActive == true
    @Condition StartBots == 1
    @Condition eventPlayer.StopAutomaticGoTo == false
    @Condition eventPlayer.T == false
    @Condition (eventPlayer.getCurrentHero() == Hero.GENJI and eventPlayer.isUsingUltimate()) == false
    
    if eventPlayer.getNormalizedHealth() < 0.6 and eventPlayer.CanSeeEnemy == false:
        eventPlayer.ClosestHealthpackPosition = sorted(HealthpackLocations, lambda player: distance(eventPlayer, player))
        eventPlayer.CurrentVisibleWaypoints = sorted([i for i in [player for player in Waypoints if isInLoS(eventPlayer, player, BarrierLos.PASS_THROUGH_BARRIERS)] if i in eventPlayer.WaypointBlacklist == false], lambda i: distance(i, eventPlayer.ClosestHealthpackPosition[0]))
    else:
        if eventPlayer.getCurrentHero() == Hero.GENJI and eventPlayer.isUsingUltimate() or eventPlayer.getCurrentHero() == Hero.DOOMFIST and eventPlayer.isUsingUltimate():
            if eventPlayer.CanSeeEnemy == false:
                eventPlayer.CurrentVisibleWaypoints = sorted([i for i in [player for player in Waypoints if isInLoS(eventPlayer, player, BarrierLos.PASS_THROUGH_BARRIERS)] if i in eventPlayer.WaypointBlacklist == false], lambda i: distance(i, getClosestPlayer(eventPlayer, getOppositeTeam(eventPlayer.getTeam())).getPosition()))
            else:
                eventPlayer.startThrottleInDirection(directionTowards(eventPlayer, eventPlayer.CurrentTarget[0]), 1, Relativity.TO_WORLD, Throttle.REPLACE_EXISTING, ThrottleReeval.DIRECTION_AND_MAGNITUDE)
        else:
            if teamScore(getOppositeTeam(eventPlayer.getTeam())) < 70:
                eventPlayer.CurrentVisibleWaypoints = sorted([i for i in [player for player in Waypoints if isInLoS(eventPlayer, player, BarrierLos.PASS_THROUGH_BARRIERS)] if i in eventPlayer.WaypointBlacklist == false], lambda i: distance(i, eventPlayer.CurrentGoToTarget))
            else:
                if eventPlayer.isOnObjective() and eventPlayer.CurrentGoToTarget == getObjectivePosition(getCurrentObjective()):
                    eventPlayer.CurrentVisibleWaypoints = sorted([i for i in [player for player in Waypoints if isInLoS(eventPlayer, player, BarrierLos.PASS_THROUGH_BARRIERS)] if i in eventPlayer.WaypointBlacklist == false], lambda i: distance(i, eventPlayer))
                    eventPlayer.CurrentVisibleWaypoints = random.shuffle(eventPlayer.CurrentVisibleWaypoints)
                else:
                    eventPlayer.CurrentVisibleWaypoints = sorted([i for i in [player for player in Waypoints if isInLoS(eventPlayer, player, BarrierLos.PASS_THROUGH_BARRIERS)] if i in eventPlayer.WaypointBlacklist == false], lambda i: distance(i, eventPlayer.CurrentGoToTarget[0]))
            eventPlayer.startThrottleInDirection(directionTowards(eventPlayer, eventPlayer.CurrentVisibleWaypoints[0]), 1, Relativity.TO_WORLD, Throttle.REPLACE_EXISTING, ThrottleReeval.DIRECTION_AND_MAGNITUDE)
    wait(random.randint(1, 2))
    if RULE_CONDITION:
        goto RULE_START


rule "Current Waypoint - After Reached Waypoint":
    @Event eachPlayer
    @Condition eventPlayer.BotActive == true
    @Condition eventPlayer.CurrentVisibleWaypoints != [] == true
    @Condition distance(eventPlayer.getEyePosition(), eventPlayer.CurrentVisibleWaypoints[0]) <= 1
    @Condition (isGameInProgress() or getCurrentGamemode() == Gamemode.SKIRMISH) == true
    @Condition StartBots == 1
    @Condition eventPlayer.StopAutomaticGoTo == false
    @Condition eventPlayer.T == false
    
    eventPlayer.WaypointBlacklist.append(eventPlayer.CurrentVisibleWaypoints[0])
    if eventPlayer.getNormalizedHealth() < 0.6 and eventPlayer.CanSeeEnemy == false:
        eventPlayer.ClosestHealthpackPosition = sorted(HealthpackLocations, lambda player: distance(eventPlayer, player))
        eventPlayer.CurrentVisibleWaypoints = sorted([i for i in [player for player in Waypoints if isInLoS(eventPlayer, player, BarrierLos.PASS_THROUGH_BARRIERS)] if i in eventPlayer.WaypointBlacklist == false], lambda i: distance(i, eventPlayer.ClosestHealthpackPosition[0]))
    else:
        if eventPlayer.getCurrentHero() == Hero.GENJI and eventPlayer.isUsingUltimate() or eventPlayer.getCurrentHero() == Hero.DOOMFIST and eventPlayer.isUsingUltimate():
            if eventPlayer.CanSeeEnemy == false:
                eventPlayer.CurrentVisibleWaypoints = sorted([i for i in [player for player in Waypoints if isInLoS(eventPlayer, player, BarrierLos.PASS_THROUGH_BARRIERS)] if i in eventPlayer.WaypointBlacklist == false], lambda i: distance(i, getClosestPlayer(eventPlayer, getOppositeTeam(eventPlayer.getTeam())).getPosition()))
            else:
                eventPlayer.startThrottleInDirection(directionTowards(eventPlayer, eventPlayer.CurrentTarget[0]), 1, Relativity.TO_WORLD, Throttle.REPLACE_EXISTING, ThrottleReeval.DIRECTION_AND_MAGNITUDE)
        else:
            if teamScore(getOppositeTeam(eventPlayer.getTeam())) < 70:
                eventPlayer.CurrentVisibleWaypoints = sorted([i for i in [player for player in Waypoints if isInLoS(eventPlayer, player, BarrierLos.PASS_THROUGH_BARRIERS)] if i in eventPlayer.WaypointBlacklist == false], lambda i: distance(i, eventPlayer.CurrentGoToTarget))
            else:
                if eventPlayer.isOnObjective() and eventPlayer.CurrentGoToTarget == getObjectivePosition(getCurrentObjective()):
                    eventPlayer.CurrentVisibleWaypoints = sorted([i for i in [player for player in Waypoints if isInLoS(eventPlayer, player, BarrierLos.PASS_THROUGH_BARRIERS)] if i in eventPlayer.WaypointBlacklist == false], lambda i: distance(i, eventPlayer))
                    eventPlayer.CurrentVisibleWaypoints = random.shuffle(eventPlayer.CurrentVisibleWaypoints)
                else:
                    eventPlayer.CurrentVisibleWaypoints = sorted([i for i in [player for player in Waypoints if isInLoS(eventPlayer, player, BarrierLos.PASS_THROUGH_BARRIERS)] if i in eventPlayer.WaypointBlacklist == false], lambda i: distance(i, eventPlayer.CurrentGoToTarget[0]))
            eventPlayer.startThrottleInDirection(directionTowards(eventPlayer, eventPlayer.CurrentVisibleWaypoints[0]), 1, Relativity.TO_WORLD, Throttle.REPLACE_EXISTING, ThrottleReeval.DIRECTION_AND_MAGNITUDE)



rule "Navigation: Jump - Variable":
    @Event eachPlayer
    @Condition eventPlayer.BotActive == true
    @Condition (isGameInProgress() or getCurrentGamemode() == Gamemode.SKIRMISH) == true
    
    eventPlayer.JumpPoint = sorted([player for player in JumpPointsGlobal if isInLoS(eventPlayer, player, BarrierLos.PASS_THROUGH_BARRIERS)], lambda i: distance(eventPlayer, i))
    wait(random.uniform(0.2, 0.4))
    goto RULE_START


rule "Navigation: Jump - SmartObject":
    @Event eachPlayer
    @Condition (isGameInProgress() or getCurrentGamemode() == Gamemode.SKIRMISH) == true
    @Condition eventPlayer.BotActive == true
    @Condition StartBots == true
    @Condition distance(eventPlayer.getEyePosition(), eventPlayer.JumpPoint[0]) <= 2.5
    @Condition eventPlayer.JumpPoint != []
    
    eventPlayer.forceButtonPress(Button.JUMP)
    wait(random.uniform(0.2, 0.4))
    if RULE_CONDITION:
        goto RULE_START
