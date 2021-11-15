#!mainFile "../main.opy"


rule "Bastion use Turret":
    @Event eachPlayer
    @Hero bastion
    @Condition eventPlayer.isInAlternateForm() == true
    
    eventPlayer.BastionTurretMode = true


rule "Bastion don't use Turret":
    @Event eachPlayer
    @Hero bastion
    @Condition eventPlayer.isInAlternateForm() == false
    
    eventPlayer.BastionTurretMode = false


rule "Hero AI: Bastion Bot - Default Enemy":
    @Event eachPlayer
    @Hero bastion
    @Condition eventPlayer.Module_001_DummyBotEnemy == true
    
    eventPlayer.stopForcingButton(Button.ABILITY_2)
    if eventPlayer.getUltCharge() == 100:
        goto lbl_0
    if eventPlayer.BastionTurretMode == false and eventPlayer.isReloading():
        Action_Module_001_UseAbility1()
        wait(0.5)
        if eventPlayer.BastionTurretMode:
            return
        else:
            goto RULE_START
    lbl_0:
    Action_Module_003_UseUltimate()
    wait(eventPlayer.Bot_Waiting_Time)
    if RULE_CONDITION:
        goto RULE_START


rule "Hero AI: Bastion Bot - Default No Enemy":
    @Event eachPlayer
    @Hero bastion
    @Condition eventPlayer.CanSeeEnemy == false
    @Condition eventPlayer.BotActive == true
    
    Action_Module_012_Health()
    if eventPlayer.Module_011_OverHealth75 == false:
        eventPlayer.startForcingButton(Button.ABILITY_2)
        wait(eventPlayer.Bot_Waiting_Time, Wait.ABORT_WHEN_FALSE)
        if RULE_CONDITION:
            goto RULE_START
    else:
        eventPlayer.stopForcingButton(Button.ABILITY_2)
    wait(3, Wait.ABORT_WHEN_FALSE)
    if eventPlayer.BastionTurretMode:
        Action_Module_001_UseAbility1()
    wait(eventPlayer.Bot_Waiting_Time)
    if RULE_CONDITION:
        goto RULE_START
