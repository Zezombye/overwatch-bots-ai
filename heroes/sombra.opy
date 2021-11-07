#!mainFile "../main.opy"


rule "Hero AI: Sombra Bot - Hack Healthpack":
    @Event eachPlayer
    @Hero sombra
    @Condition eventPlayer.CurrentHealthpack != []
    @Condition distance(eventPlayer, eventPlayer.CurrentHealthpack[0]) <= 7.777
    @Condition eventPlayer.Module_001_DummyBotEnemy == true
    
    eventPlayer.setStatusEffect(null, Status.ROOTED, 3.5)
    eventPlayer.StopFacing = true
    wait(0.5)
    eventPlayer.startFacing(directionTowards(eventPlayer.getEyePosition(), eventPlayer.CurrentHealthpack[0]), 1000, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
    eventPlayer.startForcingButton(Button.SECONDARY_FIRE)
    wait(3.5)
    eventPlayer.stopForcingButton(Button.SECONDARY_FIRE)
    eventPlayer.StopFacing = false
    wait(6)


rule "Hero AI: Sombra Bot - See Healthpack":
    @Event eachPlayer
    @Condition eventPlayer.BotActive == true
    
    eventPlayer.CurrentHealthpack = sorted([player for player in HealthpackLocations if isInLoS(eventPlayer, player, BarrierLos.PASS_THROUGH_BARRIERS) == true], lambda i: distance(eventPlayer, i))
    wait(random.uniform(0.1, 0.3))
    goto RULE_START


rule "Hero AI: Sombra Bot - Stealth":
    @Event eachPlayer
    @Hero sombra
    @Condition eventPlayer.Stealth == false
    @Condition eventPlayer.Module_001_DummyBotEnemy == true
    
    eventPlayer.forceButtonPress(Button.ABILITY_1)


rule "Hero AI: Sombra Bot - Teleport 1":
    @Event eachPlayer
    @Hero sombra
    @Condition eventPlayer.Stealth == false
    @Condition eventPlayer.isUsingAbility2() == false
    @Condition eventPlayer.Module_001_DummyBotEnemy == true
    
    eventPlayer.forceButtonPress(Button.ABILITY_2)


rule "Hero AI: Sombra Bot - Teleport 2":
    @Event eachPlayer
    @Hero sombra
    @Condition eventPlayer.isUsingAbility2() == true
    @Condition eventPlayer.getNormalizedHealth() <= 0.6
    @Condition eventPlayer.Module_001_DummyBotEnemy == true
    
    eventPlayer.forceButtonPress(Button.ABILITY_2)


rule "Hero AI: Sombra Bot - Hack Enemies":
    @Event eachPlayer
    @Hero sombra
    @Condition eventPlayer.Stealth == true
    @Condition eventPlayer.Module_001_DummyBotEnemy == true
    
    eventPlayer.startForcingButton(Button.SECONDARY_FIRE)
    wait(2)
    eventPlayer.stopForcingButton(Button.SECONDARY_FIRE)
    wait(15)


rule "Hero AI: Sombra Bot - Ultimate":
    @Event eachPlayer
    @Hero sombra
    @Condition eventPlayer.getUltCharge() == 100
    @Condition distance(eventPlayer, eventPlayer.CurrentTarget) <= 7.777
    @Condition eventPlayer.Module_001_DummyBotEnemy == true
    
    eventPlayer.forceButtonPress(Button.ULTIMATE)


rule "Hero AI: Sombra Bot - Shoot (with stealth)":
    @Event eachPlayer
    @Hero sombra
    @Condition eventPlayer.Stealth == true
    @Condition distance(eventPlayer, eventPlayer.CurrentTarget) <= 7
    @Condition eventPlayer.Module_001_DummyBotEnemy == true
    
    eventPlayer.startForcingButton(Button.PRIMARY_FIRE)


rule "Hero AI: Sombra Bot - Shoot (without stealth)":
    @Event eachPlayer
    @Hero sombra
    @Condition eventPlayer.Stealth == false
    @Condition eventPlayer.Module_001_DummyBotEnemy == true
    
    eventPlayer.startForcingButton(Button.PRIMARY_FIRE)



rule "Hack: See Healthpack":
    @Event eachPlayer
    @Hero sombra
    @Condition eventPlayer.BotActive == true
    @Condition getNumberOfPlayersOnObjective(eventPlayer.getTeam()) > 0
    @Condition getNumberOfPlayersOnObjective(getOppositeTeam(eventPlayer.getTeam())) == 0
    @Condition (isGameInProgress() or getCurrentGamemode() == Gamemode.SKIRMISH) == true
    @Condition StartBots == true
    
    eventPlayer.HackTargets = sorted([player for player in HealthpackLocations if player in HackedHealthpack == false], lambda i: distance(eventPlayer, i))
    eventPlayer.CurrentGoToTarget = eventPlayer.HackTargets[0]
    wait(random.uniform(0.3, 1.5))
    if RULE_CONDITION:
        goto RULE_START
    eventPlayer.CurrentGoToTarget = getObjectivePosition(getCurrentObjective())


rule "Hack: Add Hacked Point to the Blacklist":
    @Event eachPlayer
    @Hero sombra
    @Condition eventPlayer.isFiringSecondaryFire() == true
    @Condition eventPlayer.BotActive == true
    @Condition eventPlayer.CanSeeEnemy == false
    @Condition ServerLoadIsHigh == false
    @Condition eventPlayer.CurrentHealthpack != []
    @Condition distance(eventPlayer, eventPlayer.CurrentHealthpack[0]) <= 7.777
    
    wait(0.5, Wait.ABORT_WHEN_FALSE)
    if eventPlayer.getTeam() == Team.1:
        goto lbl_0
    HackedHealthpack.append(eventPlayer.ClosestHealthpackPosition[0])
    lbl_0:


rule "Hack: Remove Hacked Healthpack from Blacklist":
    @Condition HackedHealthpack != []
    
    wait(30)
    del HackedHealthpack[0]

