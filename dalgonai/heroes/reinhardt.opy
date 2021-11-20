#!mainFile "../main.opy"

rule "Hero AI: Reinhardt Bot - Default":
    @Event eachPlayer
    @Hero reinhardt
    @Condition eventPlayer.Module_001_DummyBotEnemy == true
    
    Action_Module_002_UseAbility2()
    Action_Module_009_Distance_Info()
    Action_Module_012_Health()
    if eventPlayer.Module_004_MidRange10m:
        Action_Module_003_UseUltimate()
    if eventPlayer.Module_003_LowRange5m and eventPlayer.getNormalizedHealth() >= 0.5:
        Action_Module_001_UseAbility1()
        wait(0.3)
        eventPlayer.stopForcingButton(Button.SECONDARY_FIRE)
        Action_Module_004_UsePrimary_B()
    else:
        Action_Module_007_UseSecondary_A()
    Action_Module_004_UsePrimary_B()
    wait(eventPlayer.Bot_Waiting_Time)
    if RULE_CONDITION:
        goto RULE_START


rule "Fix: Reinhardt":
    @Event eachPlayer
    @Hero reinhardt
    @Condition eventPlayer.Module_001_DummyBotEnemy == true
    @Condition distance(eventPlayer, eventPlayer.CurrentTarget[0]) < 5
    
    eventPlayer.forceButtonPress(Button.PRIMARY_FIRE)
    wait(0.25)
    if RULE_CONDITION:
        goto RULE_START
