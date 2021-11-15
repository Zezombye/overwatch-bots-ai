#!mainFile "../main.opy"

rule "Hero AI: Symmetra Bot - Default":
    @Event eachPlayer
    @Hero symmetra
    @Condition eventPlayer.Module_001_DummyBotEnemy == true
    
    Action_Module_002_UseAbility2()
    if eventPlayer.isUsingAbility2():
        eventPlayer.forceButtonPress(Button.PRIMARY_FIRE)
    if eventPlayer.TookDamage:
        eventPlayer.forceButtonPress(Button.ULTIMATE)
    if eventPlayer.isUsingUltimate():
        eventPlayer.forceButtonPress(Button.PRIMARY_FIRE)
    wait(eventPlayer.Bot_Waiting_Time)
    if RULE_CONDITION:
        goto RULE_START


rule "Hero AI: Symmetra Bot - Shoot":
    @Event eachPlayer
    @Hero symmetra
    @Condition eventPlayer.Module_001_DummyBotEnemy == true
    
    if distance(eventPlayer, eventPlayer.CurrentTarget[0]) < 6:
        Action_Module_006_UsePrimary_A()
    else:
        eventPlayer.stopForcingButton(Button.PRIMARY_FIRE)
        Action_Module_007_UseSecondary_A()
        wait(2.5)
        eventPlayer.stopForcingButton(Button.SECONDARY_FIRE)
    wait(eventPlayer.Bot_Waiting_Time)
    if RULE_CONDITION:
        goto RULE_START
