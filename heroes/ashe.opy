#!mainFile "../main.opy"

rule "Hero AI: Ashe Bot - Default":
    @Event eachPlayer
    @Hero ashe
    @Condition eventPlayer.Module_001_DummyBotEnemy == true
    
    Action_Module_003_UseUltimate()
    Action_Module_009_Distance_Info()
    if eventPlayer.Module_004_MidRange10m == true:
        Action_Module_002_UseAbility2()
    if eventPlayer.Module_003_LowRange5m == true:
        Action_Module_001_UseAbility1()
    elif eventPlayer.TookDamage == true:
        Action_Module_010_Selfuse_Start()
        Action_Module_001_UseAbility1()
        Action_Module_010_Selfuse_End()
        wait(15)
    wait(eventPlayer.Bot_Waiting_Time)
    if RULE_CONDITION:
        goto RULE_START


rule "Hero AI: Ashe Bot - Shoot Logic":
    @Event eachPlayer
    @Hero ashe
    @Condition eventPlayer.Module_001_DummyBotEnemy == true
    
    Action_Module_009_Distance_Info()
    if eventPlayer.Module_003_LowRange5m == true:
        eventPlayer.stopForcingButton(Button.SECONDARY_FIRE)
        Action_Module_004_UsePrimary_B()
    else:
        Action_Module_007_UseSecondary_A()
        wait(eventPlayer.Bot_Waiting_Time)
        Action_Module_004_UsePrimary_B()
    wait(eventPlayer.Bot_Waiting_Time)
    if RULE_CONDITION:
        goto RULE_START

