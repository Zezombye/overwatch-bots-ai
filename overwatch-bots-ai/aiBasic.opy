#!mainFile "main.opy"

rule "Bots AI: Use Teleport":
    @Event eachPlayer
    @Condition eventPlayer.BotActive == true
    @Condition eventPlayer.CanSeeEnemy == true
    
    eventPlayer.startForcingButton(Button.INTERACT)


rule "Bots AI: Interact":
    @Event eachPlayer
    @Condition (isGameInProgress() or getCurrentGamemode() == Gamemode.SKIRMISH) == true
    @Condition eventPlayer.BotActive == true
    
    eventPlayer.startForcingButton(Button.INTERACT)


rule "Bots AI: Melee":
    @Event eachPlayer
    @Condition StartBots == true
    @Condition ServerLoadIsHigh == false
    @Condition eventPlayer.BotActive == true
    @Condition eventPlayer.CanSeeEnemy == true
    @Condition distance(eventPlayer, eventPlayer.CurrentTarget[0]) <= 2
    
    eventPlayer.forceButtonPress(Button.MELEE)
    wait(3)


rule "Bots AI: Reload":
    @Event eachPlayer
    @Condition StartBots == true
    @Condition eventPlayer.BotActive == true
    @Condition eventPlayer.CanSeeEnemy == false
    @Condition Difficulty > 2 == true
    
    wait(random.uniform(1, 3), Wait.ABORT_WHEN_FALSE)
    eventPlayer.forceButtonPress(Button.RELOAD)


rule "Bots AI: Group in Spawn":
    @Event eachPlayer
    @Condition eventPlayer.isInSpawnRoom() == true
    @Condition isControlPointLocked() == false
    @Condition getDeadPlayers(eventPlayer.getTeam()) != []
    @Condition eventPlayer.BotActive == true
    @Condition Difficulty > 3 == true
    
    eventPlayer.setStatusEffect(null, Status.ROOTED, 1)
    wait(0.8, Wait.ABORT_WHEN_FALSE)
    if RULE_CONDITION:
        goto RULE_START


rule "Bots AI: Clear Root in Spawn":
    @Event eachPlayer
    @Condition getDeadPlayers(eventPlayer.getTeam()) == []
    @Condition eventPlayer.BotActive == true
    
    eventPlayer.clearStatusEffect(Status.ROOTED)


rule "Fix: Automatic Fire Heros":
    AutomaticFireList = []
    AutomaticFireList.append(Hero.BASTION)
    AutomaticFireList.append(Hero.ORISA)
    AutomaticFireList.append(Hero.SOLDIER)
    AutomaticFireList.append(Hero.TRACER)
    AutomaticFireList.append(Hero.HAMMOND)


rule "Fix: Automatic Fire if Enemy":
    @Event eachPlayer
    @Condition eventPlayer.Module_001_DummyBotEnemy == true
    @Condition eventPlayer.getCurrentHero() in AutomaticFireList == true
    
    Action_Module_006_UsePrimary_A()


rule "Fix: Spawnpoints":
    @Condition (isGameInProgress() or getCurrentGamemode() == Gamemode.SKIRMISH) == true
    
    if getCurrentMap() == Map.BUSAN and getCurrentGamemode() == Gamemode.CONTROL:
        weirdVect1 = vect(-43.755, 18.427, -125.365)
        weirdVect2 = vect(139.947, 18.435, -124.747)
    if getCurrentMap() == Map.ILIOS and getCurrentGamemode() == Gamemode.CONTROL:
        weirdVect1 = vect(320.725, -21.519, 47.055)
        weirdVect2 = vect(262.167, -21.516, -96.858)
    if getCurrentMap() == Map.LIJIANG_TOWER and getCurrentGamemode() == Gamemode.CONTROL:
        weirdVect1 = vect(84.147, 5.783, -29.686)
        weirdVect2 = vect(-82.037, 5.771, -28.487)
    if getCurrentMap() == Map.NEPAL and getCurrentGamemode() == Gamemode.CONTROL:
        weirdVect1 = vect(-158.753, -94.545, -88.471)
        weirdVect2 = vect(-156.696, -94.537, 88.947)
    if getCurrentMap() == Map.OASIS and getCurrentGamemode() == Gamemode.CONTROL:
        weirdVect1 = vect(66.438, 2.427, 322.563)
        weirdVect2 = vect(219.235, 2.426, 169.563)
    if getCurrentMap() == Map.ILIOS_LIGHTHOUSE and getCurrentGamemode() == Gamemode.ELIMINATION:
        weirdVect1 = vect(234.271, -22.966, -105.518)
        weirdVect2 = vect(307.357, -22.8, 76.109)
    if getCurrentMap() == Map.LIJIANG_NIGHT_MARKET and getCurrentGamemode() == Gamemode.ELIMINATION:
        weirdVect1 = vect(-117.335, 2.926, -26.203)
        weirdVect2 = vect(118.661, 2.927, -26.285)
    if getCurrentMap() == Map.LIJIANG_NIGHT_MARKET_LNY and getCurrentGamemode() == Gamemode.ELIMINATION:
        weirdVect1 = vect(-117.335, 2.926, -26.203)
        weirdVect2 = vect(118.661, 2.927, -26.285)
    if getCurrentMap() == Map.NEPAL_VILLAGE and getCurrentGamemode() == Gamemode.ELIMINATION:
        weirdVect1 = vect(-139.783, -97.573, 116.633)
        weirdVect2 = vect(-139.203, -97.576, -115.279)
    if getCurrentMap() == Map.OASIS_CITY_CENTER and getCurrentGamemode() == Gamemode.ELIMINATION:
        weirdVect1 = vect(66.438, 2.427, 322.563)
        weirdVect2 = vect(219.235, 2.426, 169.563)
    if getCurrentMap() == Map.ILIOS_LIGHTHOUSE and getCurrentGamemode() == Gamemode.CTF:
        weirdVect1 = vect(234.271, -22.966, -105.518)
        weirdVect2 = vect(307.357, -22.8, 76.109)
    if getCurrentMap() == Map.LIJIANG_NIGHT_MARKET and getCurrentGamemode() == Gamemode.CTF:
        weirdVect1 = vect(-117.335, 2.926, -26.203)
        weirdVect2 = vect(118.661, 2.927, -26.285)
    if getCurrentMap() == Map.LIJIANG_NIGHT_MARKET_LNY and getCurrentGamemode() == Gamemode.CTF:
        weirdVect1 = vect(-117.335, 2.926, -26.203)
        weirdVect2 = vect(118.661, 2.927, -26.285)
    if getCurrentMap() == Map.NEPAL_VILLAGE and getCurrentGamemode() == Gamemode.CTF:
        weirdVect1 = vect(-139.783, -97.573, 116.633)
        weirdVect2 = vect(-139.203, -97.576, -115.279)
    if getCurrentMap() == Map.OASIS_CITY_CENTER and getCurrentGamemode() == Gamemode.CTF:
        weirdVect1 = vect(66.438, 2.427, 322.563)
        weirdVect2 = vect(219.235, 2.426, 169.563)


rule "Fix: Spawnpoints Before Start":
    @Condition getCurrentGamemode() != Gamemode.SKIRMISH
    
    weirdVect1 = vect(10000, 10000, 10000)
    weirdVect2 = vect(10000, 10000, 10000)



rule "Fix: Between Rounds":
    @Condition isMatchBetweenRounds() == true
    
    StartBots = 0
    ([player for player in getAllPlayers() if player.BotActive]).setStatusEffect(null, Status.ROOTED, 30)
    getAllPlayers().stopThrottleInDirection()


rule "Fix: Blacklist - Healthpacks":
    @Event playerReceivedHealing
    @Condition eventWasHealthPack == true
    @Condition eventPlayer.BotActive == true
    
    HealthpackBlacklist.append(eventPlayer.ClosestHealthpackPosition[0])
    wait(10)
    del HealthpackBlacklist[0]


rule "Fix: Clear Black List":
    @Event eachPlayer
    @Condition eventPlayer.BotActive == true
    @Condition eventPlayer.WaypointBlacklist != []
    
    wait(10)
    del eventPlayer.WaypointBlacklist[0]
    if RULE_CONDITION:
        goto RULE_START


rule "Fix: Auto Blacklist":
    @Event eachPlayer
    @Condition eventPlayer.BotActive == true
    @Condition (isGameInProgress() or getCurrentGamemode() == Gamemode.SKIRMISH) == true
    @Condition StartBots == 1
    @Condition eventPlayer.StopAutomaticGoTo == false
    @Condition eventPlayer.T == false
    
    eventPlayer.BlacklistedWaypoint = eventPlayer.CurrentWaypoint[0]
    wait(5, Wait.ABORT_WHEN_FALSE)
    if eventPlayer.BlacklistedWaypoint == eventPlayer.CurrentWaypoint[0]:
        eventPlayer.WaypointBlacklist.append(eventPlayer.CurrentVisibleWaypoints[0])
    wait(1)
    if RULE_CONDITION:
        goto RULE_START
