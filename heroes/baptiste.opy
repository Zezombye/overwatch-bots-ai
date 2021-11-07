#!mainFile "../main.opy"

rule "Hero AI: Baptiste Bot - Deafult Enemy":
    @Event eachPlayer
    @Hero baptiste
    @Condition eventPlayer.Module_001_DummyBotEnemy == true
    @Condition eventPlayer.Module_007_DummyBot_SeeDamagedA == false
    
    Action_Module_012_Health()
    if eventPlayer.Module_011_OverHealth75 == true and eventPlayer.getUltCharge() == 100:
        Action_Module_010_Selfuse_Start()
        Action_Module_003_UseUltimate()
        Action_Module_010_Selfuse_End()
    if eventPlayer.Module_010_HighHealth75 == true:
        Action_Module_001_UseAbility1()
    if eventPlayer.Module_009_HalfHealth50 == true:
        Action_Module_010_Selfuse_Start()
        Action_Module_002_UseAbility2()
        Action_Module_010_Selfuse_End()
        wait(15)
    wait(eventPlayer.Bot_Waiting_Time)
    if RULE_CONDITION:
        goto RULE_START


rule "Hero AI: Baptiste Bot - Deafult Ally":
    @Event eachPlayer
    @Hero baptiste
    @Condition eventPlayer.Module_007_DummyBot_SeeDamagedA == true
    
    if eventPlayer.CurrentHealTarget[0].getNormalizedHealth() <= 0.6:
        Action_Module_001_UseAbility1()
    if eventPlayer.CurrentHealTarget[0].getNormalizedHealth() <= 0.4:
        Action_Module_010_Selfuse_Start()
        Action_Module_002_UseAbility2()
        Action_Module_010_Selfuse_End()
        wait(15)
    wait(eventPlayer.Bot_Waiting_Time)
    if RULE_CONDITION:
        goto RULE_START


rule "Hero AI: Baptiste Bot - Shoot Logic":
    @Event eachPlayer
    @Hero baptiste
    @Condition eventPlayer.Module_002_DummyBot == true
    
    if eventPlayer.CanSeeEnemy == true and eventPlayer.CanSeeDamagedAlly == false:
        Action_Module_004_UsePrimary_B()
    if eventPlayer.CanSeeDamagedAlly == true:
        Action_Module_005_UseSecondary_B()
    wait(eventPlayer.Bot_Waiting_Time)
    if RULE_CONDITION:
        goto RULE_START


rule "Hero AI: Baptiste Bot - Jump":
    @Event eachPlayer
    @Hero baptiste
    @Condition eventPlayer.Module_001_DummyBotEnemy == true
    
    eventPlayer.startForcingButton(Button.CROUCH)
    wait(random.uniform(1.5, 4))
    eventPlayer.forceButtonPress(Button.JUMP)
    eventPlayer.stopForcingButton(Button.CROUCH)
    wait(eventPlayer.Bot_Waiting_Time)
    if RULE_CONDITION:
        goto RULE_START
