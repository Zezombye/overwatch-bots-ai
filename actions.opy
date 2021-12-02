#!mainFile "main.opy"

rule "Enemy is in sight - switch to attacking mode":
    @Event eachPlayer
    @Condition eventPlayer.isDummy()
    @Condition eventPlayer.walkBehavior != BotWalkBehavior.FIGHTING
    @Condition any([isInLoS(eventPlayer.getEyePosition(), p.getEyePosition(), BarrierLos.PASS_THROUGH_BARRIERS) for p in getPlayers(Team.1)])

    # Get all the enemies that the bot sees.
    eventPlayer.seenEnemies = [p for p in getPlayers(Team.1) if isInLoS(eventPlayer.getEyePosition(), p.getEyePosition(), BarrierLos.PASS_THROUGH_BARRIERS) and distance(eventPlayer.getPosition(), p) < 20]

    # Select target based on threat/attractiveness, distance, role (dps are most likely to attack, then tank, then support), personal health, and maybe some other shit idk
    # TODO: actually do those things lul
    eventPlayer.targetPlayer = sorted(eventPlayer.seenEnemies, lambda p: p.attractiveness - p.threat).last()

    smallMessage(getAllPlayers(), "Bot found target")

    # TODO: evaluate whether it's actually worth it to go for the enemy

    if entityExists(eventPlayer.targetPlayer):
        eventPlayer.walkBehavior = BotWalkBehavior.FIGHTING


rule "When an enemy is found, start attacking":
    @Event eachPlayer
    @Condition eventPlayer.isDummy()
    @Condition eventPlayer.walkBehavior == BotWalkBehavior.FIGHTING
    @Condition eventPlayer.targetPlayer != null

    wait(0.016, Wait.ABORT_WHEN_FALSE)


    eventPlayer.startThrottleInDirection(directionTowards(eventPlayer.getPosition(), eventPlayer.targetPlayer.getPosition()), 1, Relativity.TO_WORLD, Throttle.REPLACE_EXISTING, ThrottleReeval.DIRECTION_AND_MAGNITUDE)
    eventPlayer.startForcingButton(Button.PRIMARY_FIRE)
    eventPlayer.startFacing(directionTowards(eventPlayer.getEyePosition(), eventPlayer.targetPlayer.getEyePosition()), 120, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)


rule "Enemy ran out of LOS - stop attacking":
    @Event eachPlayer
    @Condition eventPlayer.isDummy()
    @Condition eventPlayer.walkBehavior == BotWalkBehavior.FIGHTING
    @Condition not isInLoS(eventPlayer.getEyePosition(), eventPlayer.targetPlayer.getEyePosition(), BarrierLos.PASS_THROUGH_BARRIERS)

    wait(1, Wait.ABORT_WHEN_FALSE)

    eventPlayer.stopForcingButton(Button.PRIMARY_FIRE)
    eventPlayer.stopThrottleInDirection()
    eventPlayer.stopFacing()
    eventPlayer.targetPlayer = null
    eventPlayer.walkBehavior = BotWalkBehavior.WALKING

