
rule "Hero AI: Lucio Bot - Default":
    @Event eachPlayer
    @Hero lucio
    @Condition eventPlayer.Module_002_DummyBot == true
    
    if eventPlayer.getNormalizedHealth() < 0.5:
        Action_Module_003_UseUltimate()
    if eventPlayer.isInAir() == true:
        eventPlayer.forceButtonPress(Button.JUMP)
        wait(0.25)
        eventPlayer.startForcingButton(Button.JUMP)
    else:
        eventPlayer.stopForcingButton(Button.JUMP)
    if eventPlayer.CanSeeDamagedAlly == true and distance(eventPlayer, eventPlayer.CurrentHealTarget) <= 15:
        Action_Module_001_UseAbility1()
        if eventPlayer.isUsingAbility1() == false:
            goto lbl_0
        eventPlayer.LucioAuraMode = 2
        lbl_0:
    elif eventPlayer.LucioAuraMode == 2:
        Action_Module_001_UseAbility1()
        if eventPlayer.isUsingAbility1() == false:
            goto lbl_1
        eventPlayer.LucioAuraMode = 1
        lbl_1:
    if eventPlayer.isOnObjective() == false and eventPlayer.isInSpawnRoom() == false and eventPlayer.isMoving() == true and eventPlayer.LucioAuraMode == 1:
        Action_Module_002_UseAbility2()
    if eventPlayer.CanSeeDamagedAlly == true:
        if eventPlayer.CurrentHealTarget[0].getNormalizedHealth() <= 0.6:
            Action_Module_002_UseAbility2()
    if eventPlayer.CanSeeEnemy == true:
        Action_Module_006_UsePrimary_A()
    wait(eventPlayer.Bot_Waiting_Time)
    if RULE_CONDITION:
        goto RULE_START
