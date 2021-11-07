#!mainFile "../main.opy"

rule "Hero AI: Wrecking Ball - Default":
    @Event eachPlayer
    @Hero hammond
    @Condition eventPlayer.Module_002_DummyBot == true
    
    if eventPlayer.isInAir() == true:
        eventPlayer.forceButtonPress(Button.CROUCH)
    Action_Module_009_Distance_Info()
    if eventPlayer.CanSeeEnemy == true and eventPlayer.TookDamage == true:
        Action_Module_002_UseAbility2()
    if eventPlayer.CanSeeEnemy == true and eventPlayer.Module_003_LowRange5m == true and eventPlayer.isOnObjective() == true:
        Action_Module_003_UseUltimate()
    if eventPlayer.isOnObjective() == false and distance(eventPlayer, eventPlayer.CurrentVisibleWaypoints[0]) <= 10:
        eventPlayer.startForcingButton(Button.SECONDARY_FIRE)
        wait(2.25)
        eventPlayer.stopForcingButton(Button.SECONDARY_FIRE)
    if eventPlayer.CanSeeEnemy == true:
    wait(eventPlayer.Bot_Waiting_Time)
    if RULE_CONDITION:
        goto RULE_START


rule "Hero AI: Wrecking Ball - Default":
    @Event eachPlayer
    @Hero hammond
    @Condition eventPlayer.Module_002_DummyBot == true
    @Condition eventPlayer.isOnObjective() == true
    @Condition eventPlayer.CanSeeEnemy == false
    
    eventPlayer.forceButtonPress(Button.ABILITY_1)


rule "Hero AI: Wrecking Ball - Default":
    @Event eachPlayer
    @Hero hammond
    @Condition eventPlayer.Module_002_DummyBot == true
    @Condition eventPlayer.isInSpawnRoom() == false
    @Condition isControlPointLocked() == false
    
    eventPlayer.forceButtonPress(Button.ABILITY_1)
