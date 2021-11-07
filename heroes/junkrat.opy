#!mainFile "../main.opy"

rule "Hero AI: Junkrat Bot - Default":
    @Event eachPlayer
    @Hero junkrat
    @Condition eventPlayer.Module_001_DummyBotEnemy == true
    
    Action_Module_012_Health()
    if eventPlayer.isOnObjective() == true:
        Action_Module_002_UseAbility2()
    if eventPlayer.TookDamage and eventPlayer.Module_009_HalfHealth50 == true:
        Action_Module_010_Selfuse_Start()
        Action_Module_001_UseAbility1()
        wait(0.25)
        Action_Module_005_UseSecondary_B()
        Action_Module_010_Selfuse_End()
        wait(8)
    if eventPlayer.getUltCharge() == 100:
        eventPlayer.forceButtonPress(Button.ULTIMATE)
        wait(1)
        wait(0.083 * distance(eventPlayer, eventPlayer.CurrentTarget[0]))
        eventPlayer.forceButtonPress(Button.PRIMARY_FIRE)
    if eventPlayer.DealtDamage == true:
        Action_Module_005_UseSecondary_B()
        wait(0.25)
        Action_Module_001_UseAbility1()
    if eventPlayer.isUsingUltimate() == false:
        Action_Module_004_UsePrimary_B()
    wait(eventPlayer.Bot_Waiting_Time)
    if RULE_CONDITION:
        goto RULE_START
