#!mainFile "../main.opy"

rule "Hero AI: Echo Bot":
    @Event eachPlayer
    @Hero echo
    @Condition eventPlayer.Module_001_DummyBotEnemy == true
    
    Action_Module_006_UsePrimary_A()
    if eventPlayer.DealtDamage == true:
        Action_Module_003_UseUltimate()
        Action_Module_002_UseAbility2()
        Action_Module_005_UseSecondary_B()
    if eventPlayer.TookDamage == true:
        Action_Module_001_UseAbility1()
    if eventPlayer.isUsingAbility1() == true:
        eventPlayer.startForcingButton(Button.JUMP)
    else:
        eventPlayer.stopForcingButton(Button.JUMP)
    wait(eventPlayer.Bot_Waiting_Time)
    if RULE_CONDITION:
        goto RULE_START
