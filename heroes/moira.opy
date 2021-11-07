#!mainFile "../main.opy"

rule "Hero AI: Moira Bot - Default":
    @Event eachPlayer
    @Hero moira
    @Condition eventPlayer.Module_002_DummyBot == true
    
    if eventPlayer.isUsingUltimate() == true:
        eventPlayer.CanHeal = true
    if eventPlayer.TookDamage == true:
        Action_Module_001_UseAbility1()
    wait(eventPlayer.Bot_Waiting_Time)
    if RULE_CONDITION:
        goto RULE_START


rule "Hero AI: Moira Bot - Enemy":
    @Event eachPlayer
    @Hero moira
    @Condition eventPlayer.Module_001_DummyBotEnemy == true
    
    if eventPlayer.isUsingUltimate() == false:
        eventPlayer.CanHeal = false
    if eventPlayer.getUltCharge() == 100:
        Action_Module_003_UseUltimate()
    Action_Module_009_Distance_Info()
    if eventPlayer.Module_004_MidRange10m == true:
        eventPlayer.stopForcingButton(Button.PRIMARY_FIRE)
        Action_Module_007_UseSecondary_A()
    else:
        eventPlayer.stopForcingButton(Button.SECONDARY_FIRE)
    if eventPlayer.MoiraOrbReady == true:
        Action_Module_002_UseAbility2()
        wait(0.25)
        eventPlayer.forceButtonPress(Button.SECONDARY_FIRE)
    wait(eventPlayer.Bot_Waiting_Time)
    if RULE_CONDITION:
        goto RULE_START


rule "Hero AI: Moira Bot - Ally":
    @Event eachPlayer
    @Hero moira
    @Condition eventPlayer.Module_007_DummyBot_SeeDamagedA == true
    @Condition eventPlayer.CanSeeEnemy == false
    
    eventPlayer.CanHeal = true
    Action_Module_009_Distance_Info()
    if eventPlayer.Module_004_MidRange10m == true:
        eventPlayer.stopForcingButton(Button.SECONDARY_FIRE)
        eventPlayer.startForcingButton(Button.PRIMARY_FIRE)
    else:
        eventPlayer.stopForcingButton(Button.PRIMARY_FIRE)
    if eventPlayer.MoiraOrbReady == true:
        Action_Module_002_UseAbility2()
        wait(0.25)
        eventPlayer.forceButtonPress(Button.PRIMARY_FIRE)
    wait(eventPlayer.Bot_Waiting_Time)
    if RULE_CONDITION:
        goto RULE_START


rule "Hero AI: Moira Bot - Orb CD":
    @Event eachPlayer
    @Hero moira
    @Condition eventPlayer.MoiraOrbReady == false
    
    wait(15)
    eventPlayer.MoiraOrbReady = true
    if RULE_CONDITION:
        goto RULE_START
