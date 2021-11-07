#!mainFile "../main.opy"

rule "Hero AI: Reaper Bot - Default":
    @Event eachPlayer
    @Hero reaper
    @Condition eventPlayer.Module_001_DummyBotEnemy == true
    
    Action_Module_009_Distance_Info()
    Action_Module_012_Health()
    if eventPlayer.Module_003_LowRange5m == true:
        Action_Module_003_UseUltimate()
    if eventPlayer.isUsingAbility1() == false and eventPlayer.isUsingAbility2() == false:
        eventPlayer.forceButtonPress(Button.PRIMARY_FIRE)
    if eventPlayer.TookDamage == eventPlayer.Module_009_HalfHealth50 and true:
        Action_Module_001_UseAbility1()
    if eventPlayer.Module_006_HighRange20m == true:
        Action_Module_002_UseAbility2()
        if eventPlayer.isUsingAbility2() == true:
            eventPlayer.forceButtonPress(Button.PRIMARY_FIRE)
    wait(eventPlayer.Bot_Waiting_Time)
    if RULE_CONDITION:
        goto RULE_START
