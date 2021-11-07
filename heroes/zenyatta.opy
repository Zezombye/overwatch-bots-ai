#!mainFile "../main.opy"

rule "Hero AI: Zenyatta Bot - Enemy":
    @Event eachPlayer
    @Hero zenyatta
    @Condition eventPlayer.Module_001_DummyBotEnemy == true
    
    if eventPlayer.isUsingAbility1() == false and eventPlayer.CanSeeDamagedAlly == true:
        eventPlayer.CanHeal = true
        wait(1)
        Action_Module_001_UseAbility1()
    else:
        eventPlayer.CanHeal = false
    if eventPlayer.getNormalizedHealth() <= 0.5:
        Action_Module_003_UseUltimate()
    if eventPlayer.DealtDamage == true:
        Action_Module_002_UseAbility2()
    Action_Module_004_UsePrimary_B()
    wait(eventPlayer.Bot_Waiting_Time)
    if RULE_CONDITION:
        goto RULE_START
