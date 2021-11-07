
rule "Hero AI: Ana Bot - Default Enemy":
    @Event eachPlayer
    @Hero ana
    @Condition eventPlayer.Module_001_DummyBotEnemy == true
    @Condition eventPlayer.Module_007_DummyBot_SeeDamagedA == false
    
    Action_Module_012_Health()
    if eventPlayer.DealtDamage == true:
        Action_Module_001_UseAbility1()
    if eventPlayer.Module_009_HalfHealth50 == true:
        Action_Module_010_Selfuse_Start()
        Action_Module_002_UseAbility2()
        Action_Module_010_Selfuse_End()
    else:
        Action_Module_002_UseAbility2()
    if eventPlayer.CanSeeEnemy == true:
        Action_Module_006_UsePrimary_A()
    wait(eventPlayer.Bot_Waiting_Time)
    if RULE_CONDITION:
        goto RULE_START


rule "Hero AI: Ana Bot - Default Ally":
    @Event playerTookDamage
    @Hero ana
    @Condition eventPlayer.Module_007_DummyBot_SeeDamagedA == true
    
    Action_Module_012_Health()
    Action_Module_006_UsePrimary_A()
    if eventPlayer.Module_009_HalfHealth50 == true:
        Action_Module_010_Selfuse_Start()
        Action_Module_002_UseAbility2()
        Action_Module_010_Selfuse_End()
    else:
        Action_Module_002_UseAbility2()
    if eventPlayer.CurrentHealTarget[0].getNormalizedHealth() == (eventPlayer.CurrentHealTarget[0].TookDamage == true) and true:
        Action_Module_003_UseUltimate()
    Action_Module_006_UsePrimary_A()
    wait(eventPlayer.Bot_Waiting_Time)
    if RULE_CONDITION:
        goto RULE_START
