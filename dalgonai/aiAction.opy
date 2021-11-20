#!mainFile "main.opy"

rule "Action: Face Enemy":
    @Event eachPlayer
    @Condition eventPlayer.BotActive == true
    @Condition eventPlayer.CanSeeEnemy == true
    @Condition eventPlayer.StopFacing == false
    @Condition eventPlayer.L == false
    @Condition eventPlayer.CanSeeDamagedAlly == false
    @Condition eventPlayer.CanHeal == true
    @Condition eventPlayer.getCurrentHero() != Hero.MERCY
    
    eventPlayer.startFacing(directionTowards(eventPlayer.getEyePosition(), eventPlayer.CurrentTarget.last().getEyePosition()), eventPlayer.TurnRate, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)


rule "Action: Face Enemy":
    @Event eachPlayer
    @Condition eventPlayer.BotActive == true
    @Condition eventPlayer.CanSeeEnemy == true
    @Condition eventPlayer.StopFacing == false
    @Condition eventPlayer.L == false
    @Condition eventPlayer.CanHeal == false
    @Condition eventPlayer.getCurrentHero() != Hero.MERCY
    
    eventPlayer.startFacing(directionTowards(eventPlayer.getEyePosition(), eventPlayer.CurrentTarget.last().getEyePosition()), eventPlayer.TurnRate, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)


rule "Action: Face Damaged Ally":
    @Event eachPlayer
    @Condition eventPlayer.BotActive == true
    @Condition eventPlayer.CanSeeDamagedAlly == true
    @Condition eventPlayer.StopFacing == false
    @Condition eventPlayer.L == false
    @Condition eventPlayer.getCurrentHero() != Hero.BRIGITTE
    @Condition eventPlayer.CanHeal == true
    
    eventPlayer.startFacing(directionTowards(eventPlayer.getEyePosition(), eventPlayer.CurrentHealTarget[0].getEyePosition()), eventPlayer.TurnRate, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)


rule "Action: Face Current Waypoint (Path)":
    @Event eachPlayer
    @Condition eventPlayer.BotActive == true
    @Condition eventPlayer.CanSeeEnemy == false
    @Condition eventPlayer.StopFacing == false
    @Condition eventPlayer.L == false
    @Condition (isGameInProgress() or getCurrentGamemode() == Gamemode.SKIRMISH) == true
    @Condition getPlayersOnHero(Hero.WIDOWMAKER, eventPlayer.getTeam())[0].isUsingUltimate() == false
    @Condition eventPlayer.CanHeal == false
    @Condition eventPlayer.isOnObjective() == false
    @Condition eventPlayer.getCurrentHero() != Hero.MERCY
    
    eventPlayer.startFacing(directionTowards(eventPlayer.getEyePosition(), eventPlayer.CurrentVisibleWaypoints[0]), 200, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
    #eventPlayer.startFacing(directionTowards(eventPlayer.getEyePosition(), eventPlayer.RandomFacingDirection[0]), random.uniform(300, 600), Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)


rule "Action: Face Current Waypoint (Path)":
    @Event eachPlayer
    @Condition eventPlayer.BotActive == true
    @Condition eventPlayer.CanSeeEnemy == false
    @Condition eventPlayer.StopFacing == false
    @Condition eventPlayer.L == false
    @Condition (isGameInProgress() or getCurrentGamemode() == Gamemode.SKIRMISH) == true
    @Condition eventPlayer.CanSeeDamagedAlly == false
    @Condition getPlayersOnHero(Hero.WIDOWMAKER, eventPlayer.getTeam())[0].isUsingUltimate() == false
    @Condition eventPlayer.CanHeal == true
    @Condition eventPlayer.isOnObjective() == false
    @Condition eventPlayer.getCurrentHero() != Hero.MERCY
    
    eventPlayer.startFacing(directionTowards(eventPlayer.getEyePosition(), eventPlayer.CurrentVisibleWaypoints[0]), eventPlayer.TurnRate, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)


rule "Action: Face Current Waypoint (Objective)":
    @Event eachPlayer
    @Condition eventPlayer.BotActive == true
    @Condition eventPlayer.CanSeeEnemy == false
    @Condition eventPlayer.StopFacing == false
    @Condition eventPlayer.L == false
    @Condition (isGameInProgress() or getCurrentGamemode() == Gamemode.SKIRMISH) == true
    @Condition getPlayersOnHero(Hero.WIDOWMAKER, eventPlayer.getTeam())[0].isUsingUltimate() == false
    @Condition eventPlayer.CanHeal == false
    @Condition eventPlayer.isOnObjective() == true
    @Condition eventPlayer.getCurrentHero() != Hero.MERCY
    
    eventPlayer.startFacing(directionTowards(eventPlayer.getEyePosition(), eventPlayer.RandomFacingDirection[0]), eventPlayer.TurnRate, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)


rule "Action: Face Current Waypoint (Objective)":
    @Event eachPlayer
    @Condition eventPlayer.BotActive == true
    @Condition eventPlayer.CanSeeEnemy == false
    @Condition eventPlayer.StopFacing == false
    @Condition eventPlayer.L == false
    @Condition (isGameInProgress() or getCurrentGamemode() == Gamemode.SKIRMISH) == true
    @Condition eventPlayer.CanSeeDamagedAlly == false
    @Condition getPlayersOnHero(Hero.WIDOWMAKER, eventPlayer.getTeam())[0].isUsingUltimate() == false
    @Condition eventPlayer.CanHeal == true
    @Condition eventPlayer.isOnObjective() == true
    @Condition eventPlayer.getCurrentHero() != Hero.MERCY
    
    eventPlayer.startFacing(directionTowards(eventPlayer.getEyePosition(), eventPlayer.RandomFacingDirection[0]), eventPlayer.TurnRate, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)


rule "Action: Stop Facing":
    @Event eachPlayer
    @Condition eventPlayer.BotActive == true
    @Condition eventPlayer.StopFacing == true
    
    eventPlayer.stopFacing()


rule "Action: Chase Enemy":
    @Event eachPlayer
    @Condition eventPlayer.BotActive == true
    @Condition eventPlayer.ChaseEnemy == true
    @Condition eventPlayer.CanSeeEnemy == true
    
    eventPlayer.startThrottleInDirection(directionTowards(eventPlayer, eventPlayer.CurrentVisibleWaypoints[0]), 1, Relativity.TO_WORLD, Throttle.REPLACE_EXISTING, ThrottleReeval.DIRECTION_AND_MAGNITUDE)


rule "Action: Jump":
    @Event playerTookDamage
    @Condition eventPlayer.BotActive == true
    @Condition eventPlayer.getCurrentHero() != Hero.BAPTISTE
    @Condition Difficulty > 2 == true
    
    if eventPlayer.getCurrentHero() == Hero.WIDOWMAKER:
        goto lbl_0
    eventPlayer.forceButtonPress(Button.JUMP)
    lbl_0:

