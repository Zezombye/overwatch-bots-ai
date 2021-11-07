#!mainFile "../main.opy"

rule "Hero AI: Mei Bot - Default":
    @Event eachPlayer
    @Hero mei
    @Condition eventPlayer.Module_001_DummyBotEnemy == true
    
    Action_Module_012_Health()
    if eventPlayer.Module_009_HalfHealth50 == true:
        eventPlayer.forceButtonPress(Button.ABILITY_1)
        if eventPlayer.isUsingAbility1() == false:
            Action_Module_010_Selfuse_Start()
            Action_Module_002_UseAbility2()
            wait(0.25)
            Action_Module_004_UsePrimary_B()
            Action_Module_010_Selfuse_End()
        Action_Module_013_Ability1_S()
    if eventPlayer.getUltCharge() == 100 and eventPlayer.Module_004_MidRange10m == true:
        eventPlayer.forceButtonPress(Button.ULTIMATE)
    wait(eventPlayer.Bot_Waiting_Time)
    if RULE_CONDITION:
        goto RULE_START



rule "Hero AI: Mei Bot - Shoot Logic":
    @Event eachPlayer
    @Hero mei
    @Condition eventPlayer.Module_001_DummyBotEnemy == true
    
    if distance(eventPlayer, eventPlayer.CurrentTarget[0]) < 6:
        if eventPlayer.CurrentTarget[0].hasStatusEffect(Status.FROZEN) == true:
            eventPlayer.forceButtonPress(Button.SECONDARY_FIRE)
        else:
            Action_Module_006_UsePrimary_A()
    else:
        eventPlayer.stopForcingButton(Button.PRIMARY_FIRE)
        eventPlayer.forceButtonPress(Button.SECONDARY_FIRE)
    wait(eventPlayer.Bot_Waiting_Time)
    if RULE_CONDITION:
        goto RULE_START
