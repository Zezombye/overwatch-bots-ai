
rule "Hero AI: Roadhog Bot - Shoot Logic":
    @Event eachPlayer
    @Hero roadhog
    @Condition eventPlayer.Module_001_DummyBotEnemy == true
    
    if distance(eventPlayer, eventPlayer.CurrentTarget[0]) < 6:
        Action_Module_004_UsePrimary_B()
    else:
        Action_Module_005_UseSecondary_B()
    wait(eventPlayer.Bot_Waiting_Time)
    if RULE_CONDITION:
        goto RULE_START


rule "Hero AI: Roadhog Bot - Default":
    @Event eachPlayer
    @Hero roadhog
    @Condition eventPlayer.Module_001_DummyBotEnemy == true
    
    Action_Module_012_Health()
    Action_Module_009_Distance_Info()
    if eventPlayer.Module_009_HalfHealth50 == true:
        Action_Module_002_UseAbility2()
    if eventPlayer.Module_005_LongRange15m == true:
        Action_Module_001_UseAbility1()
    if eventPlayer.Module_003_LowRange5m == true:
        Action_Module_003_UseUltimate()
    wait(eventPlayer.Bot_Waiting_Time)
    if RULE_CONDITION:
        goto RULE_START
