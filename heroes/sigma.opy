#!mainFile "../main.opy"

rule "Hero AI: Sigma Bot - Default":
    @Event eachPlayer
    @Hero sigma
    @Condition eventPlayer.Module_001_DummyBotEnemy == true
    
    if eventPlayer.isFiringSecondaryFire() == false:
        Action_Module_005_UseSecondary_B()
        wait(eventPlayer.Bot_Waiting_Time)
        if eventPlayer.isFiringSecondaryFire():
            eventPlayer.setStatusEffect(null, Status.ROOTED, 5)
    Action_Module_012_Health()
    if eventPlayer.TookDamage and eventPlayer.Module_009_HalfHealth50:
        eventPlayer.startForcingButton(Button.ABILITY_1)
        if eventPlayer.isUsingAbility1():
            wait(random.uniform(3, 5))
            eventPlayer.stopForcingButton(Button.ABILITY_1)
    if eventPlayer.getUltCharge() == 100:
        Action_Module_003_UseUltimate()
    if eventPlayer.isUsingUltimate():
        eventPlayer.stopForcingButton(Button.PRIMARY_FIRE)
        eventPlayer.startForcingButton(Button.JUMP)
        wait(2)
        eventPlayer.forceButtonPress(Button.PRIMARY_FIRE)
    else:
        eventPlayer.forceButtonPress(Button.ABILITY_2)
        eventPlayer.forceButtonPress(Button.PRIMARY_FIRE)
    wait(eventPlayer.Bot_Waiting_Time)
    if RULE_CONDITION:
        goto RULE_START
