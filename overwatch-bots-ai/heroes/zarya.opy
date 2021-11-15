#!mainFile "../main.opy"


rule "Hero AI: Zarya Bot - Deault":
    @Event eachPlayer
    @Hero zarya
    @Condition eventPlayer.StopShoot == false
    @Condition eventPlayer.Module_001_DummyBotEnemy == true
    
    if distance(eventPlayer.getEyePosition(), getClosestPlayer(eventPlayer, getOppositeTeam(eventPlayer.getTeam())).getEyePosition()) > 8:
        goto lbl_0
    eventPlayer.startForcingButton(Button.PRIMARY_FIRE)
    lbl_0:
    if distance(eventPlayer.getEyePosition(), getClosestPlayer(eventPlayer, getOppositeTeam(eventPlayer.getTeam())).getEyePosition()) <= 8:
        goto lbl_1
    eventPlayer.stopForcingButton(Button.PRIMARY_FIRE)
    eventPlayer.forceButtonPress(Button.SECONDARY_FIRE)
    lbl_1:
    if eventPlayer.TookDamage == false:
        goto lbl_2
    eventPlayer.forceButtonPress(Button.ABILITY_1)
    lbl_2:
    wait(eventPlayer.Bot_Waiting_Time)
    if RULE_CONDITION:
        goto RULE_START


rule "Hero AI: Zarya Bot - Ally Shield":
    @Event eachPlayer
    @Hero zarya
    @Condition eventPlayer.BotActive == true
    @Condition eventPlayer.isAlive() == true
    @Condition eventPlayer.CanSeeDamagedAlly == true
    @Condition eventPlayer.CanSeeEnemy == true
    @Condition eventPlayer.CurrentHealTarget[0].TookDamage == true
    
    eventPlayer.StopShoot = true
    wait(0.25, Wait.ABORT_WHEN_FALSE)
    eventPlayer.forceButtonPress(Button.ABILITY_2)
    if eventPlayer.isUsingAbility2() == false:
        goto RULE_START
    eventPlayer.CanHeal = false
    eventPlayer.StopShoot = false
    wait(8)
    eventPlayer.CanHeal = true


rule "Hero AI: Zarya Bot - Ult if CC":
    @Event eachPlayer
    @Hero zarya
    @Condition eventPlayer.BotActive == true
    @Condition StartBots == true
    @Condition eventPlayer.getUltCharge() == 100
    @Condition eventPlayer.L == false == true
    @Condition eventPlayer.CurrentTarget.HasCC == true
    
    eventPlayer.forceButtonPress(Button.ULTIMATE)
    eventPlayer.ZaryaUlt = true


rule "Hero AI: Zarya Bot - Ult":
    @Event eachPlayer
    @Hero zarya
    @Condition eventPlayer.BotActive == true
    @Condition StartBots == true
    @Condition eventPlayer.getUltCharge() == 100
    @Condition eventPlayer.L == false
    @Condition getNumberOfPlayersOnObjective(getOppositeTeam(eventPlayer.getTeam())) > 2
    @Condition eventPlayer.PlayerClosestToObjectiveCenter != []
    @Condition isInLoS(eventPlayer, eventPlayer.PlayerClosestToObjectiveCenter[0], BarrierLos.PASS_THROUGH_BARRIERS) == true
    
    eventPlayer.StopFacing = true
    wait(0.25)
    eventPlayer.startFacing(directionTowards(eventPlayer.getEyePosition(), getObjectivePosition(getCurrentObjective())), 10000, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
    wait(0.25)
    eventPlayer.forceButtonPress(Button.ULTIMATE)
    wait(1.5)
    eventPlayer.StopFacing = false
