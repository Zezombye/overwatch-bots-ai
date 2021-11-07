
rule "Hero AI: Hanzo Bot - Default":
    @Event eachPlayer
    @Hero hanzo
    @Condition eventPlayer.Module_001_DummyBotEnemy == true
    
    Action_Module_002_UseAbility2()
    if eventPlayer.isInAir() == true:
        eventPlayer.forceButtonPress(Button.JUMP)
        wait(0.25)
        eventPlayer.startForcingButton(Button.JUMP)
    else:
        eventPlayer.stopForcingButton(Button.JUMP)
    if eventPlayer.isUsingAbility1() == false and eventPlayer.isUsingAbility2() == false:
        Action_Module_001_UseAbility1()
    wait(eventPlayer.Bot_Waiting_Time)
    if RULE_CONDITION:
        goto RULE_START


rule "Hero AI: Hanzo Bot - Shoot Logic":
    @Event eachPlayer
    @Hero hanzo
    @Condition eventPlayer.Module_001_DummyBotEnemy == true
    
    if eventPlayer.isUsingAbility2() == true:
        Action_Module_004_UsePrimary_B()
    else:
        Action_Module_006_UsePrimary_A()
        wait(1.2)
        eventPlayer.stopForcingButton(Button.PRIMARY_FIRE)
    wait(eventPlayer.Bot_Waiting_Time)
    if RULE_CONDITION:
        goto RULE_START


rule "Hero AI: Hanzo Bot - Use Ult / No Zarya in team":
    @Event eachPlayer
    @Hero hanzo
    @Condition eventPlayer.BotActive == true
    @Condition StartBots == true
    @Condition eventPlayer.StopFacing == false
    @Condition getNumberOfPlayersOnObjective(Team.ALL) >= 3
    @Condition eventPlayer.getUltCharge() == 100
    @Condition getPlayersOnHero(Hero.ZARYA, eventPlayer.getTeam()) == []
    
    eventPlayer.StopFacing = true
    wait(0.25)
    eventPlayer.startFacing(directionTowards(eventPlayer.getEyePosition(), getObjectivePosition(getCurrentObjective())), 10000, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
    wait(0.25)
    eventPlayer.forceButtonPress(Button.ULTIMATE)
    wait(1.5)
    eventPlayer.StopFacing = false


rule "Hero AI: Hanzo Bot - Ult Combo":
    @Event eachPlayer
    @Hero hanzo
    @Condition eventPlayer.BotActive == true
    @Condition ([player for player in getPlayersOnHero(Hero.ZARYA, eventPlayer.getTeam()) if eventPlayer.isDummy() == true]).isUsingUltimate() == true
    @Condition eventPlayer.getUltCharge() == 100
    @Condition eventPlayer.StopFacing == false
    @Condition eventPlayer.hasStatusEffect(Status.HACKED) == false
    
    eventPlayer.StopFacing = true
    wait(0.25)
    eventPlayer.startFacing(directionTowards(eventPlayer.getEyePosition(), getObjectivePosition(getCurrentObjective())), 10000, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
    wait(0.25)
    eventPlayer.forceButtonPress(Button.ULTIMATE)
    wait(1.5)
    eventPlayer.StopFacing = false


rule "Hero AI: Hanzo Bot - Ult Combo 2":
    @Event eachPlayer
    @Hero hanzo
    @Condition eventPlayer.BotActive == true
    @Condition getPlayersOnHero(Hero.ZARYA, eventPlayer.getTeam()).isUsingUltimate() == true
    @Condition eventPlayer.getUltCharge() == 100
    @Condition eventPlayer.StopFacing == false
    @Condition eventPlayer.hasStatusEffect(Status.HACKED) == false
    @Condition [player for player in getPlayers(eventPlayer.getTeam()) if player.ZaryaUlt != true] == [] == true
    
    eventPlayer.StopFacing = true
    wait(0.25)
    eventPlayer.startFacing(directionTowards(eventPlayer.getEyePosition(), ((sorted([player for player in getPlayers(eventPlayer.getTeam()) if player.ZaryaUlt == true], lambda i: distance(eventPlayer, i)))[0]).CurrentTarget), 10000, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
    wait(0.25)
    eventPlayer.forceButtonPress(Button.ULTIMATE)
    wait(1.5)
    eventPlayer.StopFacing = false
