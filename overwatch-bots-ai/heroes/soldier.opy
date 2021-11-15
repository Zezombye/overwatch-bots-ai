#!mainFile "../main.opy"

rule "Hero AI: Soldier: 76 Bot - Default":
    @Event eachPlayer
    @Hero soldier
    @Condition eventPlayer.Module_002_DummyBot == true
    
    if eventPlayer.CanSeeEnemy:
        Action_Module_005_UseSecondary_B()
        eventPlayer.forceButtonPress(Button.ULTIMATE)
    if eventPlayer.TookDamage:
        Action_Module_002_UseAbility2()
    if eventPlayer.isUsingAbility2():
        Action_Module_018_Hold_POS()
        #eventPlayer.setStatusEffect(null, Status.ROOTED, 2)
    if eventPlayer.isOnObjective() == false and eventPlayer.isMoving():
        if eventPlayer.isUsingAbility1():
            goto lbl_0
        eventPlayer.startForcingButton(Button.ABILITY_1)
        lbl_0:
    else:
        eventPlayer.stopForcingButton(Button.ABILITY_1)
    wait(eventPlayer.Bot_Waiting_Time)
    if RULE_CONDITION:
        goto RULE_START
