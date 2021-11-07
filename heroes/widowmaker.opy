

rule "Hero AI: Widowmaker Bot  - Sniper Shoot":
    @Event eachPlayer
    @Hero widowmaker
    @Condition eventPlayer.isFiringSecondaryFire() == true
    @Condition eventPlayer.Module_001_DummyBotEnemy == true
    
    wait(1.4)
    eventPlayer.forceButtonPress(Button.PRIMARY_FIRE)
    if RULE_CONDITION:
        goto RULE_START


rule "Hero AI: Widowmaker Bot  - Snipermode Without Sniperspot":
    @Event eachPlayer
    @Hero widowmaker
    @Condition distance(eventPlayer, eventPlayer.CurrentTarget[0]) > 5
    @Condition eventPlayer.isStanding() == false
    @Condition eventPlayer.Module_001_DummyBotEnemy == true
    
    eventPlayer.startForcingButton(Button.SECONDARY_FIRE)


rule "Hero AI: Widowmaker Bot  - Shoot Without Sniperspot":
    @Event eachPlayer
    @Hero widowmaker
    @Condition distance(eventPlayer, eventPlayer.CurrentTarget[0]) <= 5
    @Condition eventPlayer.isStanding() == false
    @Condition eventPlayer.Module_001_DummyBotEnemy == true
    
    eventPlayer.stopForcingButton(Button.SECONDARY_FIRE)
    eventPlayer.startForcingButton(Button.PRIMARY_FIRE)


rule "Hero AI: Widowmaker Bot  - Poison Mine + Ult":
    @Event eachPlayer
    @Hero widowmaker
    @Condition eventPlayer.Module_002_DummyBot == true
    
    if eventPlayer.CanSeeEnemy == false:
        goto lbl_0
    if distance(eventPlayer, eventPlayer.CurrentTarget[0]) > 10:
        goto lbl_1
    eventPlayer.forceButtonPress(Button.ABILITY_2)
    lbl_0:
    lbl_1:
    if eventPlayer.CanSeeEnemy == true:
        goto lbl_2
    if eventPlayer.getUltCharge() != 100:
        goto lbl_3
    eventPlayer.forceButtonPress(Button.ULTIMATE)
    lbl_2:
    lbl_3:
    wait(random.uniform(0.1, 0.5))
    if RULE_CONDITION:
        goto RULE_START


rule "Hero AI: Widowmaker Bot - Ultimate":
    @Event eachPlayer
    @Condition eventPlayer.BotActive == true
    @Condition getPlayersOnHero(Hero.WIDOWMAKER, eventPlayer.getTeam())[0].isUsingUltimate() == true
    @Condition eventPlayer.CanSeeEnemy == false
    
    wait(random.uniform(0.5, 1.5))
    eventPlayer.startFacing(directionTowards(eventPlayer.getEyePosition(), getClosestPlayer(eventPlayer, getOppositeTeam(eventPlayer.getTeam())).getEyePosition()), 500, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
    if RULE_CONDITION:
        goto RULE_START


rule "Fix: Widowmaker Grapple":
    @Event playerTookDamage
    @Hero widowmaker
    @Condition eventPlayer.CanSeeEnemy == true
    @Condition eventPlayer.BotActive == true
    @Condition (isGameInProgress() or getCurrentGamemode() == Gamemode.SKIRMISH) == true
    
    eventPlayer.startFacing(directionTowards(eventPlayer, vect(random.uniform(1, 100), -1, random.uniform(1, 100))), 10000, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
    wait(0.25)
    eventPlayer.forceButtonPress(Button.ABILITY_1)
    eventPlayer.startFacing(directionTowards(eventPlayer.getEyePosition(), eventPlayer.CurrentTarget.last().getEyePosition()), random.randint(200, 800), Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
