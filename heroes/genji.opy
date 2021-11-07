
rule "Hero AI: Genji Bot - Default":
    @Event eachPlayer
    @Hero genji
    @Condition eventPlayer.Module_001_DummyBotEnemy == true
    
    Action_Module_009_Distance_Info()
    Action_Module_012_Health()
    if eventPlayer.Module_004_MidRange10m == true and eventPlayer.Module_011_OverHealth75 == true and eventPlayer.DealtDamage == true:
        eventPlayer.forceButtonPress(Button.ULTIMATE)
    if eventPlayer.isInAir() == true:
        eventPlayer.forceButtonPress(Button.JUMP)
        wait(0.25)
        eventPlayer.startForcingButton(Button.JUMP)
    else:
        eventPlayer.stopForcingButton(Button.JUMP)
    if eventPlayer.isUsingUltimate() == true:
        Action_Module_016_Chase_Ult()
    if eventPlayer.Module_010_HighHealth75 == true and eventPlayer.TookDamage == true:
        Action_Module_002_UseAbility2()
        Action_Module_014_Ability2_S()
    if distance(eventPlayer, eventPlayer.CurrentTarget[0]) <= 15 and eventPlayer.CurrentTarget[0].getHealth() <= 50:
        Action_Module_001_UseAbility1()
    wait(eventPlayer.Bot_Waiting_Time)
    if RULE_CONDITION:
        goto RULE_START


rule "Hero AI: Genji Bot - Shoot Logic":
    @Event eachPlayer
    @Hero genji
    @Condition eventPlayer.CanSeeEnemy == true
    @Condition eventPlayer.BotActive == true
    
    if distance(eventPlayer, eventPlayer.CurrentTarget[0]) <= 6:
        if eventPlayer.isUsingUltimate() == true:
            Action_Module_004_UsePrimary_B()
        else:
            Action_Module_005_UseSecondary_B()
    else:
        Action_Module_004_UsePrimary_B()
    wait(eventPlayer.Bot_Waiting_Time)
    if RULE_CONDITION:
        goto RULE_START
