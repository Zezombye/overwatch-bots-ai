#!mainFile "main.opy"

#!define DEBUG_PATHFINDING true
#!define DEBUG_WALLHACKS true

#!define DEBUG_FASTRESPAWN true
#!define DEBUG_INVINCIBLE false
#!define DEBUG_BASTION_BUNKER true



rule "debug pathfinding":
    @Event eachPlayer
    @Condition DEBUG_PATHFINDING
    @Condition eventPlayer.isBot
    
    hudText(getAllPlayers(), 
        "{}".format(eventPlayer.name),
        "Targeting player: {}, mode: {}".format(eventPlayer.targetPlayer, "idling" if eventPlayer.walkBehavior == BotWalkBehavior.IDLING else "walking" if eventPlayer.walkBehavior == BotWalkBehavior.WALKING else "fighting"),
        #"Taking path: {}".format(eventPlayer.pathToTake),
        "Target node: {} ({}s left), dest node: {}".format(eventPlayer.targetNode, eventPlayer.timeRemainingToNode, eventPlayer.destNode),
        HudPosition.LEFT, eventPlayer.getSlot()+10, Color.WHITE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.ALWAYS
    )
    createEffect(getAllPlayers(), Effect.SPHERE, Color.GREEN, nodePositions[eventPlayer.destNode], NODE_RADIUS, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createInWorldText(getAllPlayers(), "{}'s dest node".format(eventPlayer.name), nodePositions[eventPlayer.destNode], 1, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.WHITE, SpecVisibility.ALWAYS)
    createEffect(getAllPlayers(), Effect.SPHERE, Color.BLUE, nodePositions[eventPlayer.targetNode], NODE_RADIUS, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createInWorldText(getAllPlayers(), "{}'s target node".format(eventPlayer.name), nodePositions[eventPlayer.targetNode], 1, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.WHITE, SpecVisibility.ALWAYS)

rule "wallhacks":
    @Event eachPlayer
    @Condition DEBUG_WALLHACKS
    @Condition eventPlayer.isBot
    createInWorldText(getAllPlayers(), heroIcon(eventPlayer.getCurrentHero()), eventPlayer, 2, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.RED, SpecVisibility.ALWAYS)

rule "fast respawn":
    @Event eachPlayer
    @Condition DEBUG_FASTRESPAWN
    eventPlayer.setRespawnTime(3)

rule "invincible":
    @Event eachPlayer
    @Condition DEBUG_INVINCIBLE
    @Condition eventPlayer.hasSpawned()
    wait(1)
    eventPlayer.setMaxHealth(Math.INFINITY)
    eventPlayer.startHoT(null, Math.INFINITY, Math.INFINITY)

rule "spawn bastion bunker":
    @Condition DEBUG_BASTION_BUNKER
    createDummy(Hero.BASTION, Team.1, -1, nodePositions[71], null)
    createDummy(Hero.REINHARDT, Team.1, -1, nodePositions[71], null)
    createDummy(Hero.ORISA, Team.1, -1, nodePositions[71], null)
    createDummy(Hero.SOLDIER, Team.1, -1, nodePositions[71], null)
    createDummy(Hero.BAPTISTE, Team.1, -1, nodePositions[71], null)
    createDummy(Hero.MERCY, Team.1, -1, nodePositions[71], null)
    createEffect(getAllPlayers(), Effect.LIGHT_SHAFT, Color.RED, worldVector(Vector.FORWARD, getPlayersOnHero(Hero.BASTION, Team.1)[0], Transform.ROTATION_AND_TRANSLATION), 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)

rule "bastion bunker aim":
    @Event eachPlayer
    @Team 1
    @Condition DEBUG_BASTION_BUNKER
    @Condition eventPlayer.isDummy()
    wait(1)
    if eventPlayer.getCurrentHero() == Hero.MERCY:
        eventPlayer.startFacing(directionTowards(eventPlayer.getEyePosition(), getPlayersOnHero(Hero.BASTION, Team.1).getPosition()), Math.INFINITY, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
    else:
        eventPlayer.startFacing(directionTowards(eventPlayer.getEyePosition(), sorted([p for p in getPlayers(Team.2) if isInLoS(eventPlayer.getEyePosition(), p.getEyePosition(), BarrierLos.PASS_THROUGH_BARRIERS)], lambda p: distance(p.getPosition(), eventPlayer.getPosition()))[0].getEyePosition()), Math.INFINITY, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
    if eventPlayer.getCurrentHero() != Hero.REINHARDT:
        eventPlayer.startForcingButton(Button.PRIMARY_FIRE)


rule "bastion":
    @Event eachPlayer
    @Team 1
    @Condition DEBUG_BASTION_BUNKER
    @Condition eventPlayer.isDummy()
    @Hero bastion
    wait(1)
    eventPlayer.forceButtonPress(Button.ABILITY_1)

rule "rein":
    @Event eachPlayer
    @Team 1
    @Condition DEBUG_BASTION_BUNKER
    @Condition eventPlayer.isDummy()
    @Hero reinhardt
    wait(1)
    eventPlayer.startForcingButton(Button.SECONDARY_FIRE)
    eventPlayer.startThrottleInDirection(directionTowards(eventPlayer.getPosition(), worldVector(Vector.FORWARD, getPlayersOnHero(Hero.BASTION, Team.1), Transform.ROTATION_AND_TRANSLATION)), 1, Relativity.TO_WORLD, Throttle.REPLACE_EXISTING, ThrottleReeval.DIRECTION_AND_MAGNITUDE)

rule "orisa":
    @Event eachPlayer
    @Team 1
    @Condition DEBUG_BASTION_BUNKER
    @Condition eventPlayer.isDummy()
    @Condition eventPlayer.getAbilityCooldown(Button.ABILITY_2) == 0
    @Hero orisa
    wait(1)
    eventPlayer.setProjectileGravity(2500)
    eventPlayer.setProjectileSpeed(60)
    eventPlayer.forceButtonPress(Button.ABILITY_2)

rule "soldier":
    @Event eachPlayer
    @Team 1
    @Condition DEBUG_BASTION_BUNKER
    @Condition eventPlayer.isDummy()
    @Hero soldier
    wait(1)
    eventPlayer.startThrottleInDirection(directionTowards(eventPlayer.getPosition(), worldVector(Vector.LEFT, getPlayersOnHero(Hero.BASTION, Team.1), Transform.ROTATION_AND_TRANSLATION)), 1, Relativity.TO_WORLD, Throttle.REPLACE_EXISTING, ThrottleReeval.DIRECTION_AND_MAGNITUDE)

rule "baptiste":
    @Event eachPlayer
    @Team 1
    @Condition DEBUG_BASTION_BUNKER
    @Condition eventPlayer.isDummy()
    @Hero baptiste
    wait(1)
    eventPlayer.startThrottleInDirection(directionTowards(eventPlayer.getPosition(), worldVector(Vector.RIGHT, getPlayersOnHero(Hero.BASTION, Team.1), Transform.ROTATION_AND_TRANSLATION)), 1, Relativity.TO_WORLD, Throttle.REPLACE_EXISTING, ThrottleReeval.DIRECTION_AND_MAGNITUDE)

rule "mercy":
    @Event eachPlayer
    @Team 1
    @Condition DEBUG_BASTION_BUNKER
    @Condition eventPlayer.isDummy()
    @Hero mercy
    wait(1)
    eventPlayer.startThrottleInDirection(directionTowards(eventPlayer.getPosition(), worldVector(Vector.BACKWARD, getPlayersOnHero(Hero.BASTION, Team.1), Transform.ROTATION_AND_TRANSLATION)), 1, Relativity.TO_WORLD, Throttle.REPLACE_EXISTING, ThrottleReeval.DIRECTION_AND_MAGNITUDE)