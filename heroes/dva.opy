
rule "Hero AI: D.Va Bot - Default":
    @Event eachPlayer
    @Hero dva
    @Condition eventPlayer.Module_001_DummyBotEnemy == true
    
    Action_Module_012_Health()
    Action_Module_001_UseAbility1()
    if eventPlayer.Module_009_HalfHealth50 == true:
        Action_Module_003_UseUltimate()
        wait(0.25)
        if eventPlayer.getNormalizedHealth() <= 200:
            eventPlayer.stopForcingButton(Button.PRIMARY_FIRE)
            Action_Module_007_UseSecondary_A()
    else:
        Action_Module_006_UsePrimary_A()
    if eventPlayer.getMaxHealth() <= 200 and eventPlayer.Module_009_HalfHealth50 == true and eventPlayer.isFiringSecondaryFire() == false:
        Action_Module_006_UsePrimary_A()
    if eventPlayer.isFiringSecondaryFire() == false and eventPlayer.isUsingAbility1() == false:
        Action_Module_002_UseAbility2()
    wait(eventPlayer.Bot_Waiting_Time)
    if RULE_CONDITION:
        goto RULE_START
