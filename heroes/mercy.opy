#!mainFile "../main.opy"

rule "Hero AI: Mercy Bot - Default":
    @Event eachPlayer
    @Hero mercy
    @Condition eventPlayer.Module_002_DummyBot == true
    
    if eventPlayer.isFiringPrimaryFire() == false and eventPlayer.isFiringSecondaryFire() == false:
        eventPlayer.startForcingButton(Button.ABILITY_1)
    else:
        eventPlayer.stopForcingButton(Button.ABILITY_1)
    if eventPlayer.CanSeeEnemy and eventPlayer.CanSeeDamagedAlly:
        eventPlayer.forceButtonPress(Button.ULTIMATE)
    if eventPlayer.isUsingUltimate():
        eventPlayer.startForcingButton(Button.JUMP)
    else:
        if eventPlayer.isInAir() and eventPlayer.getNormalizedHealth() > 0.6:
            eventPlayer.startForcingButton(Button.JUMP)
        else:
            eventPlayer.stopForcingButton(Button.JUMP)
    if eventPlayer.CanSeeDamagedAlly == false and eventPlayer.CanSeeAlly == false:
        Action_Module_011_StartAction()
        eventPlayer.StopAutomaticGoTo = false
        if eventPlayer.isOnObjective():
            eventPlayer.startFacing(directionTowards(eventPlayer.getEyePosition(), eventPlayer.CurrentVisibleWaypoints[0]), 200, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
        else:
            eventPlayer.startFacing(directionTowards(eventPlayer.getEyePosition(), eventPlayer.RandomFacingDirection[0]), random.uniform(300, 600), Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
    wait(eventPlayer.Bot_Waiting_Time)
    if RULE_CONDITION:
        goto RULE_START


rule "Hero AI: Mercy Bot - Damaged Ally":
    @Event eachPlayer
    @Hero mercy
    @Condition eventPlayer.Module_007_DummyBot_SeeDamagedA == true
    @Condition (not eventPlayer.CanSeeDeadAlly and eventPlayer.Mercy_Rez or not eventPlayer.Mercy_Rez) == true
    
    eventPlayer.startFacing(directionTowards(eventPlayer.getEyePosition(), eventPlayer.CurrentHealTarget[0].getEyePosition()), 200, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
    eventPlayer.StopAutomaticGoTo = true
    Action_Module_011_StopAction()
    if distance(eventPlayer, eventPlayer.CurrentHealTarget[0]) > 1.5:
        eventPlayer.startThrottleInDirection(directionTowards(eventPlayer, eventPlayer.CurrentHealTarget[0]), 1, Relativity.TO_WORLD, Throttle.REPLACE_EXISTING, ThrottleReeval.DIRECTION_AND_MAGNITUDE)
    else:
        eventPlayer.stopThrottleInDirection()
    if distance(eventPlayer, eventPlayer.CurrentHealTarget[0]) > 7:
        eventPlayer.stopForcingButton(Button.PRIMARY_FIRE)
    else:
        eventPlayer.stopForcingButton(Button.SECONDARY_FIRE)
        Action_Module_006_UsePrimary_A()
    wait(eventPlayer.Bot_Waiting_Time)
    if RULE_CONDITION:
        goto RULE_START


rule "Hero AI: Mercy Bot - Ally":
    @Event eachPlayer
    @Hero mercy
    @Condition eventPlayer.Module_007_DummyBot_SeeDamagedA == false
    @Condition eventPlayer.Module_012_DummyBotAlly == true
    @Condition (not eventPlayer.CanSeeDeadAlly and eventPlayer.Mercy_Rez or not eventPlayer.Mercy_Rez) == true
    
    eventPlayer.startFacing(directionTowards(eventPlayer.getEyePosition(), eventPlayer.CurrentAllyTarget[0].getEyePosition()), 200, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
    eventPlayer.StopAutomaticGoTo = true
    Action_Module_011_StopAction()
    if distance(eventPlayer, eventPlayer.CurrentAllyTarget[0]) > 1.5:
        eventPlayer.startThrottleInDirection(directionTowards(eventPlayer, eventPlayer.CurrentAllyTarget[0]), 1, Relativity.TO_WORLD, Throttle.REPLACE_EXISTING, ThrottleReeval.DIRECTION_AND_MAGNITUDE)
    else:
        eventPlayer.stopThrottleInDirection()
    if distance(eventPlayer, eventPlayer.CurrentAllyTarget[0]) > 7:
        eventPlayer.stopForcingButton(Button.SECONDARY_FIRE)
    else:
        eventPlayer.stopForcingButton(Button.PRIMARY_FIRE)
        Action_Module_007_UseSecondary_A()
    wait(eventPlayer.Bot_Waiting_Time)
    if RULE_CONDITION:
        goto RULE_START


rule "Hero AI: Mercy Bot - Revive":
    @Event eachPlayer
    @Hero mercy
    @Condition eventPlayer.Module_002_DummyBot == true
    @Condition eventPlayer.CanSeeDeadAlly == true
    @Condition eventPlayer.isAlive() == true
    @Condition eventPlayer.Mercy_Rez == true
    
    Action_Module_011_StartAction()
    eventPlayer.StopAutomaticGoTo = true
    eventPlayer.startFacing(directionTowards(eventPlayer.getEyePosition(), eventPlayer.CurrentDeadAlly[0].getEyePosition()), 200, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
    if distance(eventPlayer, eventPlayer.CurrentDeadAlly[0]) > 1:
        eventPlayer.startThrottleInDirection(directionTowards(eventPlayer, eventPlayer.CurrentDeadAlly[0]), 1, Relativity.TO_WORLD, Throttle.REPLACE_EXISTING, ThrottleReeval.DIRECTION_AND_MAGNITUDE)
    else:
        eventPlayer.stopThrottleInDirection()
        eventPlayer.startForcingButton(Button.ABILITY_2)
        Action_Module_014_Ability2_S()
    eventPlayer.Mercy_Rez = false
    wait(25)
    eventPlayer.Mercy_Rez = true
    wait(eventPlayer.Bot_Waiting_Time)
    if RULE_CONDITION:
        goto RULE_START
