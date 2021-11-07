#!mainFile "../main.opy"

rule "Hero AI: Mccree Bot - Default":
    @Event eachPlayer
    @Hero mccree
    @Condition eventPlayer.Module_001_DummyBotEnemy == true
    
    Action_Module_012_Health()
    Action_Module_009_Distance_Info()
    if eventPlayer.getUltCharge() == 100 and distance(eventPlayer, eventPlayer.CurrentTarget[0]) >= 12:
        eventPlayer.forceButtonPress(Button.ULTIMATE)
    if eventPlayer.Module_003_LowRange5m == true:
        Action_Module_002_UseAbility2()
        if eventPlayer.isUsingAbility2() == true:
            Action_Module_005_UseSecondary_B()
            if eventPlayer.isFiringSecondaryFire() == true:
                Action_Module_017_Sec_S()
                Action_Module_001_UseAbility1()
    if eventPlayer.Module_009_HalfHealth50 == true and eventPlayer.TookDamage == true:
        Action_Module_001_UseAbility1()
        Action_Module_013_Ability1_S()
    if eventPlayer.isUsingUltimate() == true:
        wait(random.uniform(3, 4.5))
        eventPlayer.forceButtonPress(Button.PRIMARY_FIRE)
    Action_Module_004_UsePrimary_B()
    wait(eventPlayer.Bot_Waiting_Time)
    if RULE_CONDITION:
        goto RULE_START
