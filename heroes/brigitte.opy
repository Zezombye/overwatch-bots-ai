#!mainFile "../main.opy"



rule "Hero AI: Brigitte Bot - Heal Allies":
    @Event eachPlayer
    @Hero brigitte
    @Condition eventPlayer.getAbilityCharge(Button.ABILITY_2) != 0
    @Condition eventPlayer.Module_007_DummyBot_SeeDamagedA == true
    
    eventPlayer.CanHeal = true
    Action_Module_002_UseAbility2()
    if eventPlayer.CurrentHealTarget[0].TookDamage == true and distance(eventPlayer, eventPlayer.CurrentHealTarget[0]) < 8 and eventPlayer.CurrentHealTarget[0].getNormalizedHealth() < 0.6:
        eventPlayer.forceButtonPress(Button.ULTIMATE)
    wait(eventPlayer.Bot_Waiting_Time)
    if RULE_CONDITION:
        goto RULE_START


rule "Hero AI: Brigitte Bot - Cant Heal":
    @Event eachPlayer
    @Hero brigitte
    @Condition eventPlayer.BotActive == true
    @Condition eventPlayer.getAbilityCharge(Button.ABILITY_2) == 0
    
    eventPlayer.CanHeal = false


rule "Hero AI: Brigitte Bot - Default":
    @Event eachPlayer
    @Hero brigitte
    @Condition eventPlayer.Module_001_DummyBotEnemy == true
    
    Action_Module_009_Distance_Info()
    Action_Module_012_Health()
    if eventPlayer.Module_003_LowRange5m == true and eventPlayer.getNormalizedHealth() >= 0.5:
        Action_Module_001_UseAbility1()
        wait(0.3)
        eventPlayer.stopForcingButton(Button.SECONDARY_FIRE)
        Action_Module_004_UsePrimary_B()
    else:
        Action_Module_007_UseSecondary_A()
    wait(eventPlayer.Bot_Waiting_Time)
    if RULE_CONDITION:
        goto RULE_START

rule "Fix: Brigitte":
    @Event eachPlayer
    @Hero brigitte
    @Condition eventPlayer.Module_001_DummyBotEnemy == true
    @Condition distance(eventPlayer, eventPlayer.CurrentTarget[0]) < 5
    
    eventPlayer.forceButtonPress(Button.PRIMARY_FIRE)
    wait(0.25)
    if RULE_CONDITION:
        goto RULE_START
