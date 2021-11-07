#!mainFile "main.opy"

rule "Condition: Ally is in LOS [TRUE]":
    @Event eachPlayer
    @Condition eventPlayer.BotActive == true
    
    eventPlayer.CurrentAllyTarget = sorted([i for i in getLivingPlayers(eventPlayer.getTeam()).exclude(eventPlayer) if isInLoS(eventPlayer, i, BarrierLos.PASS_THROUGH_BARRIERS) == true], lambda i: distance(eventPlayer, i))
    wait(1.6)
    if RULE_CONDITION:
        goto RULE_START


rule "Condition: Ally is in LOS [TRUE]":
    @Event eachPlayer
    @Condition eventPlayer.BotActive == true
    @Condition eventPlayer.CurrentAllyTarget != [] == true
    @Condition eventPlayer.StopFacing == false
    
    eventPlayer.CanSeeAlly = true


rule "Condition: Ally is in LOS  [FALSE]":
    @Event eachPlayer
    @Condition eventPlayer.BotActive == true
    @Condition eventPlayer.CurrentAllyTarget == [] == true
    
    eventPlayer.CanSeeAlly = false


rule "Condition: Dead Ally is in LOS [TRUE]":
    @Event eachPlayer
    @Condition eventPlayer.BotActive == true
    
    eventPlayer.CurrentDeadAlly = sorted([i for i in getDeadPlayers(eventPlayer.getTeam()).exclude(eventPlayer) if isInLoS(eventPlayer, i, BarrierLos.PASS_THROUGH_BARRIERS) == true], lambda i: distance(eventPlayer, i))
    wait(1.6)
    if RULE_CONDITION:
        goto RULE_START


rule "Condition: Dead Ally is in LOS [TRUE]":
    @Event eachPlayer
    @Condition eventPlayer.BotActive == true
    @Condition eventPlayer.CurrentDeadAlly != [] == true
    @Condition eventPlayer.StopFacing == false
    
    eventPlayer.CanSeeDeadAlly = true


rule "Condition: Dead Ally is in LOS  [FALSE]":
    @Event eachPlayer
    @Condition eventPlayer.BotActive == true
    @Condition eventPlayer.CurrentDeadAlly == [] == true
    
    eventPlayer.CanSeeDeadAlly = false


rule "Condition: Enemy is in LOS [TRUE]":
    @Event eachPlayer
    @Condition eventPlayer.BotActive == true
    
    eventPlayer.CurrentTarget = [i for i in [i for i in [i for i in [i for i in [i for i in [i for i in [player for player in TargetArray if player.Stealth == false] if i.getTeam() == getOppositeTeam(eventPlayer.getTeam())] if i.hasStatusEffect(Status.UNKILLABLE) == false] if i.hasStatusEffect(Status.INVINCIBLE) == false] if eventPlayer.hasStatusEffect(Status.PHASED_OUT) == false] if i.isAlive() == true] if isInLoS(eventPlayer, i, BarrierLos.PASS_THROUGH_BARRIERS) == true]
    wait(0.12)
    goto RULE_START


rule "Condition: Enemy is in LOS [TRUE]":
    @Event eachPlayer
    @Condition eventPlayer.BotActive == true
    @Condition isInLoS(eventPlayer, eventPlayer.CurrentTarget[0], BarrierLos.PASS_THROUGH_BARRIERS) == true
    @Condition eventPlayer.CurrentTarget != [] == true
    @Condition eventPlayer.StopFacing == false
    
    eventPlayer.CanSeeEnemy = true


rule "Condition: Enemy is in LOS  [FALSE]":
    @Event eachPlayer
    @Condition eventPlayer.BotActive == true
    @Condition eventPlayer.CurrentTarget == [] == true
    
    eventPlayer.CanSeeEnemy = false
    eventPlayer.stopForcingButton(Button.INTERACT)
    eventPlayer.VisibleEnemies = []


rule "Condition: Damaged Ally is in LOS [TRUE]":
    @Event eachPlayer
    @Condition eventPlayer.BotActive == true
    @Condition eventPlayer.CurrentHealTarget != []
    
    eventPlayer.CanSeeDamagedAlly = true


rule "Condition: Damaged Ally is in LOS [FALSE]":
    @Event eachPlayer
    @Condition eventPlayer.BotActive == true
    @Condition eventPlayer.CurrentHealTarget == []
    
    eventPlayer.CanSeeDamagedAlly = false


rule "Condition: Touched Objective  [TRUE]":
    @Event eachPlayer
    @Condition eventPlayer.BotActive == true
    @Condition eventPlayer.isOnObjective() == true
    @Condition eventPlayer.T == false
    
    eventPlayer.TouchedTheObjective = true
    if eventPlayer.getCurrentHero() == Hero.MERCY:
        goto lbl_0
    eventPlayer.StopFacing = false
    eventPlayer.StopAutomaticGoTo = false
    lbl_0:


rule "Condition: Touched Objective  [FALSE]":
    @Event eachPlayer
    @Condition eventPlayer.BotActive == true
    @Condition eventPlayer.isInSpawnRoom() == true
    
    eventPlayer.TouchedTheObjective = false


rule "Condition: Dealt Damage (PV->E)":
    @Event playerDealtDamage
    @Condition eventPlayer.BotActive == true
    
    eventPlayer.DealtDamage = true
    wait(random.uniform(1, 2))
    eventPlayer.DealtDamage = false


rule "Condition: Took Damage (PV->F)":
    @Event playerTookDamage
    @Condition eventPlayer.BotActive == true
    
    eventPlayer.TookDamage = true
    wait(random.uniform(1, 2))
    eventPlayer.TookDamage = false


rule "Condition: Got Elimination":
    @Event playerEarnedElimination
    @Condition eventPlayer.BotActive == true
    
    eventPlayer.GotElimination = true
    wait(2)
    eventPlayer.GotElimination = false


rule "Condition: Stop facing if has status  [TRUE]":
    @Event eachPlayer
    @Condition eventPlayer.BotActive == true
    @Condition (eventPlayer.hasStatusEffect(Status.KNOCKED_DOWN) or eventPlayer.hasStatusEffect(Status.ASLEEP) or eventPlayer.hasStatusEffect(Status.FROZEN) or eventPlayer.hasStatusEffect(Status.STUNNED)) == true
    
    eventPlayer.StopFacing = true
    eventPlayer.HasCC = true


rule "Condition: Stop facing if has status [FALSE]":
    @Event eachPlayer
    @Condition eventPlayer.BotActive == true
    @Condition (eventPlayer.hasStatusEffect(Status.KNOCKED_DOWN) or eventPlayer.hasStatusEffect(Status.ASLEEP) or eventPlayer.hasStatusEffect(Status.FROZEN) or eventPlayer.hasStatusEffect(Status.STUNNED)) == false
    
    eventPlayer.StopFacing = false
    eventPlayer.HasCC = false


rule "Condition: Chase Enemy (PV->K)":
    @Event eachPlayer
    @Hero reinhardt
    @Condition eventPlayer.BotActive == true
    @Condition eventPlayer.CanSeeEnemy == true
    @Condition eventPlayer.TouchedTheObjective == true
    
    eventPlayer.ChaseEnemy = true


rule "Condition: See Damaged Allies for Heal":
    @Event eachPlayer
    @Condition (isGameInProgress() or getCurrentGamemode() == Gamemode.SKIRMISH) == true
    
    eventPlayer.CurrentHealTarget = sorted([i for i in [i for i in [i for i in [player for player in getPlayers(eventPlayer.getTeam()) if eventPlayer != player] if isInLoS(eventPlayer, i, BarrierLos.PASS_THROUGH_BARRIERS) == true] if i.isAlive() == true] if i.getNormalizedHealth() != 1], lambda i: i.getHealth())
    wait(random.uniform(0.1, 0.3))
    goto RULE_START
