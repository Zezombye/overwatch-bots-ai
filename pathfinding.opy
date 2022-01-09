#!mainFile "main.opy"

#!define NB_NODES len(nodePositions)

globalvar uncompressedData = []
globalvar timer
globalvar currentNodeArray
globalvar currentCharIdx
globalvar runLengthEncodingIdx
globalvar message

playervar targetNode = -1 #-1 means there is no target node, so one must be found.
playervar destNode
playervar walkBehavior = BotWalkBehavior.IDLING
#If the bot does not reach the target node in time, the target node is reinitialized, as the bot was probably booped or similar.
playervar timeRemainingToNode
playervar pathToTake
playervar pathNodeIndex


/*
Currently there are 3 states for the AI.

In the "idle" state, the bot has no enemy to target, or is dead.
He is not doing anything.

In the "walking" state, the bot has found a suitable enemy and will walk towards the targeted enemy, following the node graph. 
At all times the bot is looking at the targeted player, and will fire firecharges at him if he happens to be in line of sight.

If the bot enters in range of the player, defined as being less than 7m from the player, less than 1.2m vertically from the player (assuming the bot is below the player, else he can simply jump down), and in line of sight, he enters the "fighting" state.
In this state, it is considered that the bot can directly reach the targeted enemy (no more pathfinding needed).
As such, the node graph is no longer used in this state, and the bot will simply walk directly towards the player.
This state lasts until the bot is no longer in range of the player (defined the same as above) for 5 seconds, after which he will revert to the walking state.
*/
enum BotWalkBehavior:
    IDLING,
    WALKING,
    FIGHTING,

# Targeting
playervar seenEnemies
playervar targetPlayer
playervar isNearTarget

enum Message:
    NO_PATHMAP,
    DECOMPRESSING,
    FINISHED_DECOMPRESSION,


globalvar alphabet
globalvar compressedData
globalvar nodePositions
#The first objective node is the node to go to from spawn (in case of control/2cp).
globalvar objectiveNodes
globalvar paths

#!define NODE_RADIUS 1
#!define BOT_SPEED 5.5

#Put each map in its own rule, else we hit the rule size limit.
/*def loadNepalSanctum():
    alphabet = ALPHABET_LIJIANG_GARDEN
    compressedData = DATA_LIJIANG_GARDEN
    nodePositions = POSITIONS_LIJIANG_GARDEN*/

def loadNepalShrine():
    alphabet = ALPHABET_NEPAL_SHRINE
    compressedData = DATA_NEPAL_SHRINE
    nodePositions = POSITIONS_NEPAL_SHRINE
    objectiveNodes = OBJECTIVE_NODES_NEPAL_SHRINE
    paths = PATHS_NEPAL_SHRINE

/*def loadNepalVillage():
    alphabet = ALPHABET_ECOPOINT_ANTARCTICA
    compressedData = DATA_ECOPOINT_ANTARCTICA
    nodePositions = POSITIONS_ECOPOINT_ANTARCTICA*/


rule "Load built-in pathmaps":
    #Load the pathmap based on the map
    loadNepalShrine()

rule "Decompress pathmap":
    #print("No pathmap for map {}".format(getCurrentMap()) if message == Message.NO_PATHMAP else "Node graph out of date. Rebuilding... {}s elapsed".format(timer) if message == Message.DECOMPRESSING else "Finished loading pathmap in {}s".format(timer))

    #Uncompress the pathmap
    message = Message.DECOMPRESSING
    disableInspector()
    chase(timer, 9999, rate=1, ChaseReeval.NONE)

    uncompressedData[NB_NODES-1] = 0
    currentNodeArray[NB_NODES-1] = 0

    currentCharIdx = 0
    for i in range(min(len(compressedData), 256)):
        for j in range(0, strLen(compressedData[i]), 2):

            #We iterate backwards to not recalculate the length at each iteration.
            for runLengthEncodingIdx in range(alphabet.strIndex(compressedData[i].charAt(j)), 0, -1):
                #Here we subtract 1 because we must take "-1" into account, so the alphabet starts at -1.
                currentNodeArray[currentCharIdx % NB_NODES] = alphabet.strIndex(compressedData[i].charAt(j+1))-1
                currentCharIdx++
                if currentCharIdx % NB_NODES == 0:
                    if currentCharIdx > NB_NODES * NB_NODES:
                        break
                    uncompressedData[floor((currentCharIdx-1)/NB_NODES)] = currentNodeArray
        
        wait()

    #Remove compressed data and calculation variables to make the server less laggy.
    alphabet = null
    compressedData = null
    currentNodeArray = null
    
    stopChasingVariable(timer)
    enableInspector()
    message = Message.FINISHED_DECOMPRESSION


rule "Init bot":
    @Event eachPlayer
    @Condition eventPlayer.isBot
    chase(eventPlayer.timeRemainingToNode, 0, rate=1, ChaseReeval.NONE)

rule "Bot has no target position":
    @Event eachPlayer
    @Condition eventPlayer.isBot
    @Condition eventPlayer.targetNode == -1
    eventPlayer.stopThrottleInDirection()
    eventPlayer.targetNode = -1
    eventPlayer.timeRemainingToNode = 0


rule "Set destination node":
    @Event eachPlayer
    @Condition eventPlayer.isBot
    @Condition eventPlayer.walkBehavior == BotWalkBehavior.WALKING
    eventPlayer.pathToTake = random.randint(0, len(paths))
    eventPlayer.pathNodeIndex = 0
    eventPlayer.destNode = eventPlayer.pathToTake[0]


rule "When walking, go to target node":
    @Event eachPlayer
    @Condition eventPlayer.isBot
    @Condition eventPlayer.walkBehavior == BotWalkBehavior.WALKING

    eventPlayer.stopForcingButton(Button.PRIMARY_FIRE)
    eventPlayer.stopThrottleInDirection()
    eventPlayer.stopFacing()
    eventPlayer.targetPlayer = null
    eventPlayer.startThrottleInDirection(directionTowards(eventPlayer.getPosition(), nodePositions[eventPlayer.targetNode]), 1, Relativity.TO_WORLD, Throttle.REPLACE_EXISTING, ThrottleReeval.DIRECTION_AND_MAGNITUDE)
    eventPlayer.startFacing(directionTowards(eventPlayer.getPosition(), nodePositions[eventPlayer.targetNode]), 150, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)

rule "All bots are in spawn - switch to walking mode":
    @Event eachPlayer
    @Condition eventPlayer.isBot
    @Condition eventPlayer.walkBehavior == BotWalkBehavior.IDLING
    @Condition all([player.isInSpawnRoom() for player in getPlayers(eventPlayer.getTeam())])
    do:
        eventPlayer.walkBehavior = BotWalkBehavior.WALKING
        #eventPlayer.startFacing(directionTowards(eventPlayer.getEyePosition(), eventPlayer.targetPlayer.getPosition()+vect(0,1.5,0)), 9999, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
        wait()
    while RULE_CONDITION

rule "Initialize target node":
    @Event eachPlayer
    @Condition eventPlayer.isBot
    @Condition eventPlayer.walkBehavior == BotWalkBehavior.WALKING
    @Condition eventPlayer.timeRemainingToNode == 0
    do:
        #Initialize the target node by getting the closest node to the bot which is in line of sight and not higher than 1.2m.
        #The bot will always walk directly towards the target node.
        eventPlayer.targetNode = nodePositions.index(sorted([pos for pos in nodePositions if pos.y - eventPlayer.getPosition().y < 1.2 and isInLoS(pos+vect(0,NODE_RADIUS,0), eventPlayer.getEyePosition(), BarrierLos.PASS_THROUGH_BARRIERS)], lambda pos: distance(eventPlayer.getPosition(), pos))[0])
        if eventPlayer.targetNode == -1:
            eventPlayer.walkBehavior = BotWalkBehavior.IDLING
            eventPlayer.stopThrottleInDirection()
            return
        #Put wiggle room by setting it to 2x the distance, in case the bot is slowed down by a boop, slight wall, or similar.
        eventPlayer.timeRemainingToNode = distance(nodePositions[eventPlayer.targetNode], eventPlayer.getPosition())*2/BOT_SPEED + 0.5
        wait()
    while RULE_CONDITION

/*rule "Enemy is in range - set mode to fighting":
    @Event eachPlayer
    @Condition eventPlayer.isBot
    @Condition eventPlayer.walkBehavior == BotWalkBehavior.WALKING
    @Condition abs(eventPlayer.getPosition().y - eventPlayer.targetPlayer.getPosition().y) < 1.2
    @Condition distance(eventPlayer, eventPlayer.targetPlayer) < 7
    @Condition isInLoS(eventPlayer.getEyePosition(), eventPlayer.targetPlayer.getEyePosition(), BarrierLos.PASS_THROUGH_BARRIERS)
    do:
        eventPlayer.walkBehavior = BotWalkBehavior.FIGHTING
        wait()
    while RULE_CONDITION

rule "Bot is fighting - set throttle towards enemy and start swinging":
    @Event eachPlayer
    @Condition eventPlayer.isBot
    @Condition eventPlayer.walkBehavior == BotWalkBehavior.FIGHTING
    eventPlayer.startThrottleInDirection(directionTowards(eventPlayer.getPosition(), eventPlayer.targetPlayer.getPosition()), 1, Relativity.TO_WORLD, Throttle.REPLACE_EXISTING, ThrottleReeval.DIRECTION_AND_MAGNITUDE)
    eventPlayer.startForcingButton(Button.PRIMARY_FIRE)

rule "Enemy is no longer in range - set mode back to idling":
    @Event eachPlayer
    @Condition eventPlayer.isBot
    @Condition eventPlayer.walkBehavior == BotWalkBehavior.FIGHTING
    @Condition abs(eventPlayer.getPosition().y - eventPlayer.targetPlayer.getPosition().y) >= 1.2 or distance(eventPlayer, eventPlayer.targetPlayer) >= 7 or not isInLoS(eventPlayer.getEyePosition(), eventPlayer.targetPlayer.getEyePosition(), BarrierLos.PASS_THROUGH_BARRIERS)
    do:
        wait(5, Wait.ABORT_WHEN_FALSE)
        eventPlayer.walkBehavior = BotWalkBehavior.IDLING
    while RULE_CONDITION*/

/*rule "Fire firecharges on enemy when in walking mode":
    @Event eachPlayer
    @Condition eventPlayer.isBot
    @Condition eventPlayer.walkBehavior == BotWalkBehavior.WALKING
    @Condition isInLoS(eventPlayer.getEyePosition(), eventPlayer.targetPlayer.getEyePosition(), BarrierLos.PASS_THROUGH_BARRIERS)
    do:
        eventPlayer.forceButtonPress(Button.ABILITY_2)
        wait(random.uniform(0.5, 5), Wait.ABORT_WHEN_FALSE)
    while RULE_CONDITION*/

/*rule "Enemy is dead - set mode back to walking and enemy to null":
    @Event eachPlayer
    @Condition eventPlayer.targetPlayer.isDead() or not eventPlayer.targetPlayer.hasSpawned() or eventPlayer.isDead() or not eventPlayer.hasSpawned()
    eventPlayer.targetPlayer = null
    eventPlayer.walkBehavior = BotWalkBehavior.IDLING*/


rule "Jump over cliffs":
    @Event eachPlayer
    @Condition eventPlayer.isBot
    @Condition eventPlayer.isNearTarget == false
    @Condition eventPlayer.walkBehavior == BotWalkBehavior.WALKING or eventPlayer.walkBehavior == BotWalkBehavior.FIGHTING
    @Condition updateEveryTick(isInLoS(eventPlayer.getPosition()+normalize(eventPlayer.getThrottle())*0.2+vect(0,0.5,0), eventPlayer.getPosition()+normalize(eventPlayer.getThrottle())*0.2-vect(0,0.5,0), BarrierLos.PASS_THROUGH_BARRIERS))
    do:
        eventPlayer.forceButtonPress(Button.JUMP)
        wait()
    while RULE_CONDITION


rule "Jump over obstacles":
    @Event eachPlayer
    @Condition eventPlayer.isBot
    @Condition eventPlayer.isNearTarget == false
    @Condition eventPlayer.walkBehavior == BotWalkBehavior.WALKING or eventPlayer.walkBehavior == BotWalkBehavior.FIGHTING
    @Condition eventPlayer.getHorizontalSpeed() < 3
    do:
        eventPlayer.forceButtonPress(Button.JUMP)
        wait()
    while RULE_CONDITION
    

rule "Target node was reached":
    @Event eachPlayer
    @Condition eventPlayer.isBot
    @Condition eventPlayer.walkBehavior == BotWalkBehavior.WALKING
    @Condition eventPlayer.targetNode >= 0
    @Condition eventPlayer.getPosition().y > nodePositions[eventPlayer.targetNode].y - NODE_RADIUS
    @Condition updateEveryTick(distance(eventPlayer.getPosition()*vect(1,0,1), nodePositions[eventPlayer.targetNode]*vect(1,0,1))) < NODE_RADIUS
    @Condition updateEveryTick(isInLoS(eventPlayer.getEyePosition(), nodePositions[eventPlayer.targetNode]+vect(0,1,0), BarrierLos.PASS_THROUGH_BARRIERS))
    do:
        #This is all the magic of the bakemap.
        eventPlayer.targetNode = uncompressedData[eventPlayer.targetNode][eventPlayer.destNode]
        if eventPlayer.targetNode == -1:
            eventPlayer.walkBehavior = BotWalkBehavior.IDLING
            eventPlayer.stopThrottleInDirection()
            return
        if eventPlayer.targetNode == eventPlayer.destNode:
            #eventPlayer.walkBehavior = BotWalkBehavior.FIGHTING

            #Update destination node
            if eventPlayer.pathNodeIndex > len(eventPlayer.pathToTake):
                #Path is already done, and the bot already reached the objective; take a random node to make the bot walk around the objective.
                #TODO: use isOnObjective() for that?
                eventPlayer.destNode = random.choice(objectiveNodes)
            else:
                eventPlayer.pathNodeIndex++
                if eventPlayer.pathNodeIndex > len(eventPlayer.pathToTake):
                    #Path is done, now go to objective
                    eventPlayer.destNode = objectiveNodes[0]
                else:
                    eventPlayer.destNode = eventPlayer.pathToTake[eventPlayer.pathNodeIndex]
        #Put wiggle room by setting it to 2x the distance, in case the bot is slowed down by a boop, slight wall, or similar.
        eventPlayer.timeRemainingToNode = distance(nodePositions[eventPlayer.targetNode], eventPlayer.getPosition())*2/BOT_SPEED + 0.5
        wait()
    while RULE_CONDITION
