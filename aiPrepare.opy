#!mainFile "main.opy"

rule "Prepare: Basic":
    GlobalTeamComp = [].concat(0).concat(0).concat(0).concat(0).concat(0).concat(0)
    DummyBots = []
    getAllPlayers().BotActive = false


rule "Prepare: Bot Can Heal?":
    @Event eachPlayer
    @Condition eventPlayer.BotActive == true
    #@Condition (eventPlayer.getCurrentHero() == Hero.ANA or eventPlayer.getCurrentHero() == Hero.BAPTISTE or eventPlayer.getCurrentHero() == Hero.MERCY) == true
    @Condition (eventPlayer.getCurrentHero() == Hero.ANA or eventPlayer.getCurrentHero() == Hero.BAPTISTE) == true
    
    eventPlayer.CanHeal = true


rule "Prepare: Target List":
    @Condition isGameInProgress() == true
    
    TargetArray = sorted(getAllPlayers(), lambda player: player.HeroPriorityRating)
    wait(0.25)
    goto RULE_START


rule "Prepare: Picked Hero is Tank":
    @Event eachPlayer
    @Condition eventPlayer.isDummy() == false
    @Condition eventPlayer.getCurrentHero() in getTankHeroes() == true
    
    if eventPlayer.getTeam() == Team.2:
        goto lbl_0
    GlobalTeamComp[0] += 1
    lbl_0:
    if eventPlayer.getTeam() == Team.1:
        goto lbl_1
    GlobalTeamComp[1] += 1
    lbl_1:


rule "Prepare: Picked Hero is Attack":
    @Event eachPlayer
    @Condition eventPlayer.isDummy() == false
    @Condition eventPlayer.getCurrentHero() in getDamageHeroes() == true
    
    if eventPlayer.getTeam() == Team.2:
        goto lbl_0
    GlobalTeamComp[2] += 1
    lbl_0:
    if eventPlayer.getTeam() == Team.1:
        goto lbl_1
    GlobalTeamComp[3] += 1
    lbl_1:


rule "Prepare: Picked Hero is Support":
    @Event eachPlayer
    @Condition eventPlayer.isDummy() == false
    @Condition eventPlayer.getCurrentHero() in getSupportHeroes() == true
    
    if eventPlayer.getTeam() == Team.2:
        goto lbl_0
    GlobalTeamComp[4] += 1
    lbl_0:
    if eventPlayer.getTeam() == Team.1:
        goto lbl_1
    GlobalTeamComp[5] += 1
    lbl_1:


rule "Prepare: Bots dont play same hero as player T1":
    @Event eachPlayer
    @Team 1
    @Condition eventPlayer.isDummy() == false
    @Condition eventPlayer.hasSpawned() == true
    @Condition isGameInProgress() == false
    
    AllowedHeroesT1 = AllowedHeroesT1.exclude(eventPlayer.getCurrentHero())


rule "Prepare: Bots dont play same hero as player T2":
    @Event eachPlayer
    @Team 2
    @Condition eventPlayer.isDummy() == false
    @Condition eventPlayer.hasSpawned() == true
    @Condition isGameInProgress() == false
    
    AllowedHeroesT1 = AllowedHeroesT2.exclude(eventPlayer.getCurrentHero())


rule "Prepare: Random Facing Direction":
    @Event eachPlayer
    @Condition (isGameInProgress() or getCurrentGamemode() == Gamemode.SKIRMISH) == true
    @Condition eventPlayer.BotActive == true
    @Condition eventPlayer.isAlive() == true
    
    eventPlayer.RandomFacingDirection = vect(random.uniform(-300, 300), random.uniform(-15, 15), random.uniform(-300, 300))
    wait(random.uniform(0.1, 1))
    if RULE_CONDITION:
        goto RULE_START


rule "Prepare: Stop Shoot":
    @Event eachPlayer
    @Condition eventPlayer.BotActive == true
    @Condition eventPlayer.StopShoot == true
    
    eventPlayer.stopForcingButton(Button.PRIMARY_FIRE)
    eventPlayer.stopForcingButton(Button.SECONDARY_FIRE)


rule "Prepare: PlayerClosestToObjectiveCenter":
    @Event eachPlayer
    @Hero zarya
    @Condition (isGameInProgress() or getCurrentGamemode() == Gamemode.SKIRMISH) == true
    @Condition StartBots == true
    @Condition eventPlayer.getUltCharge() >= 90
    @Condition eventPlayer.BotActive == true
    @Condition eventPlayer.CanSeeEnemy == true
    
    eventPlayer.PlayerClosestToObjectiveCenter = sorted([i for i in [player for player in getPlayersOnObjective(getOppositeTeam(eventPlayer.getTeam())) if isInLoS(eventPlayer, player, BarrierLos.PASS_THROUGH_BARRIERS) == true] if distance(i, getObjectivePosition(getCurrentObjective())) <= 3], lambda i: distance(i, getObjectivePosition(getCurrentObjective())))
    wait(random.uniform(0.2, 0.6))
    if RULE_CONDITION:
        goto RULE_START


rule "Prepare: Debug":
    @Event eachPlayer
    @Condition eventPlayer.BotActive == true
    @Condition (isGameInProgress() or getCurrentGamemode() == Gamemode.SKIRMISH) == true
    @Condition eventPlayer.isInSpawnRoom() == true
    
    eventPlayer.setStatusEffect(null, Status.ROOTED, 2)
    if eventPlayer.getCurrentHero() != Hero.WIDOWMAKER:
        goto lbl_0
    eventPlayer.setStatusEffect(null, Status.ROOTED, 3)
    lbl_0:
    if eventPlayer.getCurrentHero() != Hero.LUCIO:
        goto lbl_1
    eventPlayer.LucioAuraMode = 1
    lbl_1:


rule "Prepare: Server L.oad A":
    @Condition getServerLoad() > 230
    @Condition (isGameInProgress() or getCurrentGamemode() == Gamemode.SKIRMISH) == true
    
    ServerLoadIsHigh = true


rule "Prepare: Server L.oad B":
    @Condition getServerLoad() <= 230
    @Condition (isGameInProgress() or getCurrentGamemode() == Gamemode.SKIRMISH) == true
    
    ServerLoadIsHigh = false


rule "Prepare: List Available Bots":
    AllowedHeroesT1 = getAllHeroes()
    AllowedHeroesT2 = getAllHeroes()


rule "Prepare: Start Bots":
    @Event eachPlayer
    @Condition (isGameInProgress() or getCurrentGamemode() == Gamemode.SKIRMISH) == true
    @Condition eventPlayer.BotActive == true
    @Condition eventPlayer.isInSpawnRoom() == true
    
    wait(0.25)
    StartBots = true
    eventPlayer.CurrentWaypoint = 0


rule "Prepare: Stop Shoot":
    @Event eachPlayer
    @Condition eventPlayer.BotActive == true
    @Condition eventPlayer.CanSeeEnemy == false
    @Condition eventPlayer.getCurrentHero() != Hero.MERCY
    @Condition eventPlayer.getCurrentHero() != Hero.MOIRA
    
    eventPlayer.ChaseEnemy = false
    eventPlayer.stopForcingButton(Button.PRIMARY_FIRE)
    eventPlayer.stopForcingButton(Button.JUMP)
    eventPlayer.stopForcingButton(Button.CROUCH)
    if eventPlayer.getCurrentHero() == Hero.WIDOWMAKER and eventPlayer.isStanding() == true:
        goto lbl_0
    eventPlayer.stopForcingButton(Button.SECONDARY_FIRE)
    lbl_0:


rule "Prepare: Reset Spawn Room Player Variable":
    @Event eachPlayer
    @Condition eventPlayer.isInSpawnRoom() == true
    
    eventPlayer.IndexNumber = 0
    eventPlayer.RandomizedWaypointArray = random.shuffle(Waypoints)
    eventPlayer.BrigitteBotRepairPackAmmo = 3
    eventPlayer.BastionTurretMode = false
    eventPlayer.DealtDamage = false
    eventPlayer.TookDamage = false
    eventPlayer.FocusDamagedAlly = false
    eventPlayer.GotElimination = false
    eventPlayer.StopAutomaticGoTo = false
    eventPlayer.U = false
    eventPlayer.T = false
    eventPlayer.ClosestHealthpackPosition = []
    eventPlayer.CurrentHealthpack = []
    eventPlayer.TeleportLocation = []
    eventPlayer.stopForcingButton(Button.SECONDARY_FIRE)
    eventPlayer.VisibleTurretSpots = []
    eventPlayer.PickedUpHealthpack = false
    eventPlayer.LucioAuraMode = 1
    eventPlayer.stopForcingButton(Button.JUMP)
    eventPlayer.stopForcingButton(Button.CROUCH)
    eventPlayer.stopForcingButton(Button.SECONDARY_FIRE)
    if eventPlayer.getCurrentHero() != Hero.ZARYA:
        goto lbl_0
    eventPlayer.CanHeal = true
    lbl_0:
    wait(0.25)
    eventPlayer.Bot_Waiting_Time = random.uniform(0.2, 0.6)
    eventPlayer.Mercy_Rez = true
    eventPlayer.Communicate = true
