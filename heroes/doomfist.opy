
rule "Hero AI: Doomfist Bot - Default":
    @Event eachPlayer
    @Hero doomfist
    @Condition eventPlayer.Module_001_DummyBotEnemy == true
    
    if eventPlayer.getUltCharge() == 100 and eventPlayer.DealtDamage == true:
        Action_Module_003_UseUltimate()
    if distance(eventPlayer, eventPlayer.CurrentTarget[0]) <= 1 and eventPlayer.isUsingUltimate() == true:
        Action_Module_004_UsePrimary_B()
    if eventPlayer.isUsingUltimate() == false:
        Action_Module_011_StartAction()
        Action_Module_009_Distance_Info()
        if eventPlayer.Module_006_HighRange20m == true:
            Action_Module_007_UseSecondary_A()
            Action_Module_008_UseSecondary_S()
            Action_Module_001_UseAbility1()
            Action_Module_013_Ability1_S()
        if eventPlayer.Module_003_LowRange5m == true:
            Action_Module_002_UseAbility2()
            Action_Module_014_Ability2_S()
            Action_Module_005_UseSecondary_B()
            Action_Module_008_UseSecondary_S()
            Action_Module_001_UseAbility1()
            Action_Module_013_Ability1_S()
        if eventPlayer.Module_004_MidRange10m == true:
            Action_Module_001_UseAbility1()
            Action_Module_013_Ability1_S()
        if eventPlayer.Module_005_LongRange15m == true:
            Action_Module_007_UseSecondary_A()
            Action_Module_008_UseSecondary_S()
            Action_Module_002_UseAbility2()
            Action_Module_014_Ability2_S()
            Action_Module_001_UseAbility1()
            Action_Module_013_Ability1_S()
        if eventPlayer.isUsingAbility1() == false and eventPlayer.isUsingAbility2() == false and eventPlayer.isFiringSecondaryFire() == false:
            Action_Module_004_UsePrimary_B()
    else:
        Action_Module_016_Chase_Ult()
    wait(eventPlayer.Bot_Waiting_Time)
    if RULE_CONDITION:
        goto RULE_START
