#!mainFile "../main.opy"

rule "Hero AI: Tracer Bot - Default":
    @Event eachPlayer
    @Hero tracer
    @Condition eventPlayer.Module_001_DummyBotEnemy == true
    
    Action_Module_009_Distance_Info()
    Action_Module_012_Health()
    if eventPlayer.TookDamage:
        Action_Module_001_UseAbility1()
    if eventPlayer.DealtDamage:
        Action_Module_001_UseAbility1()
    if eventPlayer.Module_009_HalfHealth50:
        Action_Module_002_UseAbility2()
    if eventPlayer.Module_003_LowRange5m:
        Action_Module_003_UseUltimate()
    wait(eventPlayer.Bot_Waiting_Time)
    if RULE_CONDITION:
        goto RULE_START
