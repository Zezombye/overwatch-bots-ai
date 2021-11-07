
rule "Hero AI: Winston Bot - Default":
    @Event eachPlayer
    @Hero winston
    @Condition eventPlayer.Module_001_DummyBotEnemy == true
    
    if eventPlayer.TookDamage == false:
        goto lbl_0
    if eventPlayer.getNormalizedHealth() > 0.4:
        goto lbl_1
    eventPlayer.forceButtonPress(Button.ULTIMATE)
    lbl_0:
    lbl_1:
    if eventPlayer.TookDamage == false:
        goto lbl_2
    eventPlayer.forceButtonPress(Button.ABILITY_1)
    if eventPlayer.isOnGround() == false:
        goto lbl_3
    lbl_2:
    eventPlayer.forceButtonPress(Button.ABILITY_2)
    lbl_3:
    Action_Module_006_UsePrimary_A()
    wait(eventPlayer.Bot_Waiting_Time)
    if RULE_CONDITION:
        goto RULE_START
