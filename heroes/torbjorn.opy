#!mainFile "../main.opy"

rule "Hero AI: Torbjörn Bot - Default":
    @Event eachPlayer
    @Hero torbjorn
    @Condition eventPlayer.Module_001_DummyBotEnemy == true
    
    Action_Module_001_UseAbility1()
    if eventPlayer.TookDamage:
        Action_Module_002_UseAbility2()
    if eventPlayer.DealtDamage:
        Action_Module_003_UseUltimate()
    wait(eventPlayer.Bot_Waiting_Time)
    if RULE_CONDITION:
        goto RULE_START


rule "Hero AI: Torbjörn Bot - Destroy Turret (Count for Human too)":
    @Event eachPlayer
    @Hero torbjorn
    @Condition eventPlayer.isUsingAbility1() == true
    
    wait(random.randint(4, 8))
    eventPlayer.forceButtonPress(Button.CROUCH)


rule "Hero AI: Torbjörn Bot - Shoot Logic":
    @Event eachPlayer
    @Hero torbjorn
    @Condition eventPlayer.Module_001_DummyBotEnemy == true
    
    if distance(eventPlayer, eventPlayer.CurrentTarget[0]) < 6:
        Action_Module_005_UseSecondary_B()
    else:
        Action_Module_004_UsePrimary_B()
    wait(eventPlayer.Bot_Waiting_Time)
    if RULE_CONDITION:
        goto RULE_START
