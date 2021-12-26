#!mainFile "main.opy"

rule "Enemy is in sight - switch to attacking mode":
    @Event eachPlayer
    @Condition eventPlayer.isBot
    @Condition eventPlayer.walkBehavior != BotWalkBehavior.FIGHTING
    @Condition any([isInLoS(eventPlayer.getEyePosition(), p.getEyePosition(), BarrierLos.PASS_THROUGH_BARRIERS) and distance(eventPlayer.getPosition(), p) < 20 for p in getPlayers(getOppositeTeam(eventPlayer.getTeam()))])

    do:
        # Get all the enemies that the bot sees.
        eventPlayer.seenEnemies = [p for p in getPlayers(getOppositeTeam(eventPlayer.getTeam())) if isInLoS(eventPlayer.getEyePosition(), p.getEyePosition(), BarrierLos.PASS_THROUGH_BARRIERS) and distance(eventPlayer.getPosition(), p) < 20]

        # Select target based on threat/attractiveness, distance, role (dps are most likely to attack, then tank, then support), personal health, and maybe some other shit idk
        # TODO: actually do those things lul
        eventPlayer.targetPlayer = sorted(eventPlayer.seenEnemies, lambda p: p.attractiveness - p.threat).last()

        #smallMessage(getAllPlayers(), "Bot found target")

        # TODO: evaluate whether it's actually worth it to go for the enemy
        eventPlayer.walkBehavior = BotWalkBehavior.FIGHTING
        wait()
    while RULE_CONDITION


rule "When an enemy is found, start attacking":
    @Event eachPlayer
    @Condition eventPlayer.isBot
    @Condition eventPlayer.walkBehavior == BotWalkBehavior.FIGHTING
    @Condition eventPlayer.targetPlayer != null

        eventPlayer.startThrottleInDirection(directionTowards(eventPlayer.getPosition(), eventPlayer.targetPlayer.getPosition()), 1, Relativity.TO_WORLD, Throttle.REPLACE_EXISTING, ThrottleReeval.DIRECTION_AND_MAGNITUDE)
        eventPlayer.startForcingButton(Button.PRIMARY_FIRE)
        eventPlayer.startFacing(directionTowards(eventPlayer.getEyePosition(), eventPlayer.targetPlayer.getEyePosition()), 500, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
       

rule "Enemy ran out of LOS - stop attacking":
    @Event eachPlayer
    @Condition eventPlayer.isBot
    @Condition eventPlayer.walkBehavior == BotWalkBehavior.FIGHTING
    @Condition not isInLoS(eventPlayer.getEyePosition(), eventPlayer.targetPlayer.getEyePosition(), BarrierLos.PASS_THROUGH_BARRIERS)

    do:
        wait(1, Wait.ABORT_WHEN_FALSE)

        eventPlayer.stopForcingButton(Button.PRIMARY_FIRE)
        eventPlayer.stopThrottleInDirection()
        eventPlayer.stopFacing()
        eventPlayer.targetPlayer = null
        eventPlayer.walkBehavior = BotWalkBehavior.WALKING
        wait()
    while RULE_CONDITION

    # This will stop the ai from jumping on the player head
rule "Enemy close, stop jumping":
        @Event eachPlayer
        @Condition eventPlayer.isBot
        @Condition eventPlayer.walkBehavior == BotWalkBehavior.FIGHTING
        
        if distance(eventPlayer, eventPlayer.targetPlayer.getPosition()) <= 2:
            eventPlayer.nearTarget = true
        else:
            eventPlayer.nearTarget = false
        wait(0.1)
        if RULE_CONDITION:
            goto RULE_START
    
    
