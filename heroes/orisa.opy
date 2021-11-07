#!mainFile "../main.opy"

rule "Hero AI: Orisa Bot - Deafult":
    @Event eachPlayer
    @Hero orisa
    @Condition eventPlayer.Module_001_DummyBotEnemy == true
    
    if eventPlayer.TookDamage == true:
        Action_Module_002_UseAbility2()
    if eventPlayer.isUsingAbility2() == true:
        eventPlayer.stopForcingButton(Button.PRIMARY_FIRE)
        wait(0.083 * distance(eventPlayer, eventPlayer.CurrentTarget[0]))
        eventPlayer.forceButtonPress(Button.PRIMARY_FIRE)
    else:
        Action_Module_001_UseAbility1()
        Action_Module_005_UseSecondary_B()
        if eventPlayer.DealtDamage == true:
            Action_Module_003_UseUltimate()
        eventPlayer.startForcingButton(Button.PRIMARY_FIRE)
    wait(eventPlayer.Bot_Waiting_Time)
    if RULE_CONDITION:
        goto RULE_START

        
rule "Fix: Orisa":
    @Event eachPlayer
    @Hero orisa
    @Condition eventPlayer.BotActive == true
    @Condition eventPlayer.CanSeeEnemy == false
    @Condition eventPlayer.isFiringPrimaryFire() == true
    
    eventPlayer.stopForcingButton(Button.PRIMARY_FIRE)
    wait(0.25)
    if RULE_CONDITION:
        goto RULE_START
