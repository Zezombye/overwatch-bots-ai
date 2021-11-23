#!mainFile "main.opy"

#!define DEBUG_PATHFINDING true
#!define DEBUG_WALLHACKS true

#!define DEBUG_FASTRESPAWN true
#!define DEBUG_INVINCIBLE true



rule "debug pathfinding":
    @Event eachPlayer
    @Condition DEBUG_PATHFINDING
    @Condition eventPlayer.isDummy()
    
    hudText(getAllPlayers(), 
        "{}".format(eventPlayer.name),
        #"Targeting player: {}, mode: {}".format(eventPlayer.targetPlayer, "idling" if eventPlayer.walkBehavior == BotWalkBehavior.IDLING else "walking" if eventPlayer.walkBehavior == BotWalkBehavior.WALKING else "fighting"),
        "Taking path: {}".format(eventPlayer.pathToTake),
        "Target node: {} ({}s left), dest node: {}".format(eventPlayer.targetNode, eventPlayer.timeRemainingToNode, eventPlayer.destNode),
        HudPosition.LEFT, eventPlayer.getSlot(), Color.WHITE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.ALWAYS
    )
    createEffect(getAllPlayers(), Effect.SPHERE, Color.GREEN, nodePositions[eventPlayer.destNode], NODE_RADIUS, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createInWorldText(getAllPlayers(), "{}'s dest node".format(eventPlayer.name), nodePositions[eventPlayer.destNode], 1, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.WHITE, SpecVisibility.ALWAYS)
    createEffect(getAllPlayers(), Effect.SPHERE, Color.BLUE, nodePositions[eventPlayer.targetNode], NODE_RADIUS, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createInWorldText(getAllPlayers(), "{}'s target node".format(eventPlayer.name), nodePositions[eventPlayer.targetNode], 1, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.WHITE, SpecVisibility.ALWAYS)

rule "wallhacks":
    @Event eachPlayer
    @Condition DEBUG_WALLHACKS
    @Condition eventPlayer.isDummy()
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
    eventPlayer.setHealth(Math.INFINITY)
    eventPlayer.startHoT(null, Math.INFINITY, Math.INFINITY)