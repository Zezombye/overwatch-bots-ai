
rule "Hero AI: Pharah Bot - Deafult":
    @Event eachPlayer
    @Hero pharah
    @Condition eventPlayer.Module_001_DummyBotEnemy == true
    
    Action_Module_001_UseAbility1()
    wait(1.3, Wait.ABORT_WHEN_FALSE)
    Action_Module_002_UseAbility2()
    if eventPlayer.isInAir() == false:
        goto lbl_0
    eventPlayer.forceButtonPress(Button.ULTIMATE)
    lbl_0:
    Action_Module_004_UsePrimary_B()
    wait(eventPlayer.Bot_Waiting_Time)
    if RULE_CONDITION:
        goto RULE_START


rule "Hero AI: Pharah Bot - Fly":
    @Event eachPlayer
    @Hero pharah
    @Condition eventPlayer.getNormalizedHealth() > 0.4
    @Condition eventPlayer.isInAir() == true
    @Condition eventPlayer.Module_001_DummyBotEnemy == true
    
    eventPlayer.startForcingButton(Button.JUMP)


rule "Hero AI: Pharah Bot - Stop Fly on Low Health":
    @Event eachPlayer
    @Hero pharah
    @Condition StartBots == true
    @Condition eventPlayer.BotActive == true
    @Condition eventPlayer.getNormalizedHealth() <= 0.4
    @Condition eventPlayer.isHoldingButton(Button.JUMP) == true
    
    eventPlayer.stopForcingButton(Button.JUMP)


rule "Hero AI: Pharah Bot - Stop Fly if on Ground":
    @Event eachPlayer
    @Hero pharah
    @Condition StartBots == true
    @Condition eventPlayer.BotActive == true
    @Condition eventPlayer.isHoldingButton(Button.JUMP) == true
    @Condition eventPlayer.isInAir() == false
    
    eventPlayer.stopForcingButton(Button.JUMP)
