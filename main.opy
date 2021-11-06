settings {
    "main": {
        "description": "Custom Legendary Bots V11 - Control Mode/Skirmish"
    },
    "lobby": {
        "allowPlayersInQueue": true,
        "mapRotation": "afterGame",
        "enableMatchVoiceChat": true,
        "spectatorSlots": 12,
        "returnToLobby": "never",
        "teamBalancing": "afterGame"
    },
    "gamemodes": {
        "control": {
            "enableCompetitiveRules": true,
            "scoreToWin": 1,
            "scoringSpeed%": 101
        },
        "elimination": {
            "enabled": false,
            "scoreToWin": 9
        },
        "skirmish": {
            "enabledMaps": []
        },
        "general": {
            "gamemodeStartTrigger": "immediately",
            "enableKillCam": false,
            "respawnTime%": 50
        }
    },
    "heroes": {
        "allTeams": {
            "baptiste": {
                "enableInfiniteAmmo": true
            },
            "mercy": {
                "weaponsEnabled": "staff"
            },
            "symmetra": {
                "enableAbility1": false
            },
            "torbjorn": {
                "enableAbility1": false
            }
        }
    }
}

#Global variables

globalvar StartBots 0
globalvar HackedHealthpack 2
globalvar TargetArray 3
globalvar AutomaticFireList 4
globalvar HealthpackLocations 5
globalvar HealthpackBlacklist 6
globalvar DummyBots 7
globalvar JumpPointsGlobal 8
globalvar Waypoints 9
globalvar GlobalTeamComp 10
globalvar weirdVect1 13
globalvar weirdVect2 14
globalvar ServerLoadIsHigh 18
globalvar AllowedHeroesT1 19
globalvar AllowedHeroesT2 20
globalvar Difficulty 21
globalvar BotsTeam1 22
globalvar BotsTeam2 23
globalvar ReplacerBots 24
globalvar AFK_protection 25
globalvar AFK_timer 26
globalvar BotSlot0team1 27
globalvar BotSlot0team2 28
globalvar BotSlot1team1 29
globalvar BotSlot1team2 30
globalvar BotSlot2team1 31
globalvar BotSlot2team2 32
globalvar BotSlot3team1 33
globalvar BotSlot3team2 34
globalvar BotSlot4team1 35
globalvar BotSlot4team2 36
globalvar BotSlot5team1 37
globalvar BotSlot5team2 38
globalvar Teams 40
globalvar I 41
globalvar AllHeros 43


#Player variables

playervar CanSeeEnemy 0
playervar CanSeeAlly 1
playervar CanSeeDamagedAlly 2
playervar TouchedTheObjective 3
playervar DealtDamage 4
playervar TookDamage 5
playervar FocusDamagedAlly 6
playervar HasCC 7
playervar GotElimination 8
playervar StopFacing 9
playervar ChaseEnemy 10
playervar HeroPriorityRating 12
playervar BastionTurretMode 14
playervar CurrentWaypoint 15
playervar StopAutomaticGoTo 16
playervar BrigitteBotRepairPackAmmo 17
playervar CurrentTarget 18
playervar StopShoot 22
playervar MoiraOrbReady 23
playervar CurrentHealthpack 24
playervar Stealth 25
playervar VisibleEnemies 26
playervar CurrentHealTarget 27
playervar ClosestHealthpackPosition 28
playervar TeleportLocation 29
playervar BotActive 30
playervar CanHeal 31
playervar CurrentVisibleWaypoints 32
playervar WaypointBlacklist 33
playervar CurrentGoToTarget 34
playervar JumpPoint 35
playervar RandomFacingDirection 36
playervar Communicate 37
playervar PickedUpHealthpack 38
playervar VisibleTurretSpots 39
playervar LucioAuraMode 42
playervar RandomizedWaypointArray 43
playervar IndexNumber 44
playervar TurnRate 45
playervar ZaryaUlt 46
playervar XX 47
playervar PlayerClosestToObjectiveCenter 48
playervar HackTargets 49
playervar Module_001_DummyBotEnemy 50
playervar Module_002_DummyBot 51
playervar Bot_Waiting_Time 52
playervar Module_003_LowRange5m 53
playervar Module_004_MidRange10m 54
playervar Module_005_LongRange15m 55
playervar Module_006_HighRange20m 56
playervar Module_007_DummyBot_SeeDamagedA 57
playervar Module_008_VeryLowHealth30 58
playervar Module_009_HalfHealth50 59
playervar Module_010_HighHealth75 60
playervar Module_011_OverHealth75 61
playervar CanSeeDeadAlly 62
playervar CurrentAllyTarget 63
playervar Module_012_DummyBotAlly 64
playervar CurrentDeadAlly 65
playervar Mercy_Rez 66
playervar BlacklistedWaypoint 67


#Subroutine names

subroutine Action_Module_001_UseAbility1 0
subroutine Action_Module_002_UseAbility2 1
subroutine Action_Module_003_UseUltimate 2
subroutine Action_Module_004_UsePrimary_B 3
subroutine Action_Module_005_UseSecondary_B 4
subroutine Action_Module_006_UsePrimary_A 5
subroutine Action_Module_007_UseSecondary_A 6
subroutine Action_Module_008_UseSecondary_S 7
subroutine Action_Module_009_Distance_Info 8
subroutine Action_Module_010_Selfuse_Start 9
subroutine Action_Module_010_Selfuse_End 10
subroutine Action_Module_011_StopAction 11
subroutine Action_Module_011_StartAction 12
subroutine Action_Module_012_Health 13
subroutine Action_Module_013_Ability1_S 14
subroutine Action_Module_014_Ability2_S 15
subroutine Action_Module_015_Ultimate_S 16
subroutine Action_Module_016_Chase_Ult 17
subroutine Action_Module_017_Sec_S 18
subroutine Action_Module_018_Hold_POS 19


/*
rule "===== WORKSHO.P SETTING.S =====":
*/

rule "Setting: Difficulty":
    Difficulty = createWorkshopSetting(int[1:5], "AI Difficulty", "AI Difficulty", 3, 0)


rule "Setting: Bot Number":
    Teams = createWorkshopSetting(int[0:2], "AI TEAM", "0 = Default Teams - 1 = Random Teams + Custom Bot Number - 2 = Custom Heroes", 0, 0)
    BotsTeam1 = createWorkshopSetting(int[0:12], "AI Number", "Number of Bots Team 1", 6, 0)
    BotsTeam2 = createWorkshopSetting(int[0:12], "AI Number", "Number of Bots Team 2", 6, 0)


rule "Setting: General":
    ReplacerBots = createWorkshopSetting(bool, "AI Settings", "Replace left player with Bots", false, 0)
    AFK_protection = createWorkshopSetting(bool, "AI Settings", "AI Controls AFK Player", false, 0)
    AFK_timer = createWorkshopSetting(float[10:60], "AI Settings", "AFK Time needed to start Bot", 30, 0)


rule "Setting: Custom heroes":
    BotSlot0team1 = createWorkshopSetting(int[0:33], "AI Custom Hero", "Bot Hero Slot 0 Team 1", 0, 0)
    BotSlot1team1 = createWorkshopSetting(int[0:33], "AI Custom Hero", "Bot Hero Slot 1 Team 1", 0, 0)
    BotSlot2team1 = createWorkshopSetting(int[0:33], "AI Custom Hero", "Bot Hero Slot 2 Team 1", 0, 0)
    BotSlot3team1 = createWorkshopSetting(int[0:33], "AI Custom Hero", "Bot Hero Slot 3 Team 1", 0, 0)
    BotSlot4team1 = createWorkshopSetting(int[0:33], "AI Custom Hero", "Bot Hero Slot 4 Team 1", 0, 0)
    BotSlot5team1 = createWorkshopSetting(int[0:33], "AI Custom Hero", "Bot Hero Slot 5 Team 1", 0, 0)
    BotSlot0team2 = createWorkshopSetting(int[0:33], "AI Custom Hero", "Bot Hero Slot 0 Team 2", 0, 0)
    BotSlot1team2 = createWorkshopSetting(int[0:33], "AI Custom Hero", "Bot Hero Slot 1 Team 2", 0, 0)
    BotSlot2team2 = createWorkshopSetting(int[0:33], "AI Custom Hero", "Bot Hero Slot 2 Team 2", 0, 0)
    BotSlot3team2 = createWorkshopSetting(int[0:33], "AI Custom Hero", "Bot Hero Slot 3 Team 2", 0, 0)
    BotSlot4team2 = createWorkshopSetting(int[0:33], "AI Custom Hero", "Bot Hero Slot 4 Team 2", 0, 0)
    BotSlot5team2 = createWorkshopSetting(int[0:33], "AI Custom Hero", "Bot Hero Slot 5 Team 2", 0, 0)


rule "Setting: Difficulty Settings for the Bots [Automatic]":
    @Event eachPlayer
    @Condition eventPlayer.isDummy() == true
    @Condition eventPlayer.isInSpawnRoom() == true
    
    if Difficulty == 1:
        eventPlayer.TurnRate = random.uniform(100, 150)
        eventPlayer.setDamageDealt(65)
        eventPlayer.Bot_Waiting_Time = random.uniform(3, 5)
    if Difficulty == 2:
        eventPlayer.TurnRate = random.uniform(125, 200)
        eventPlayer.setDamageDealt(80)
        eventPlayer.Bot_Waiting_Time = random.uniform(2, 4)
    if Difficulty == 3:
        eventPlayer.TurnRate = random.uniform(200, 300)
        eventPlayer.setDamageDealt(100)
        eventPlayer.Bot_Waiting_Time = random.uniform(1.5, 2.225)
    if Difficulty == 4:
        eventPlayer.TurnRate = random.uniform(300, 500)
        eventPlayer.setDamageDealt(125)
        eventPlayer.Bot_Waiting_Time = random.uniform(0.5, 1)
    if Difficulty == 5:
        eventPlayer.TurnRate = 10000
        eventPlayer.setDamageDealt(150)
        eventPlayer.Bot_Waiting_Time = random.uniform(0.05, 0.1)


rule "Setting: Debug Array for Custom Hero Setting [0 = No hero]":
    AllHeros.append(getAllHeroes())


/*
rule "===== AI TEAMS =====":
*/

rule "Team: Spawn Team 1 [Enable Team Option 0 for Default Team, that use 2-2-2 and deny duplicate pics]":
    @Condition Teams == 0
    @Condition (isAssemblingHeroes() or getCurrentGamemode() == Gamemode.SKIRMISH) == true
    
    wait(35)
    if GlobalTeamComp[0] >= 2:
        goto lbl_0
    createDummy([i for i in getTankHeroes() if i in AllowedHeroesT1 == true], Team.1, -1, weirdVect1, vect(0, 0, 0))
    AllowedHeroesT1.remove(getLastCreatedEntity().getCurrentHero())
    GlobalTeamComp[0] += 1
    lbl_0:
    if GlobalTeamComp[0] >= 2:
        goto lbl_1
    createDummy([i for i in getTankHeroes() if i in AllowedHeroesT1 == true], Team.1, -1, weirdVect1, vect(0, 0, 0))
    AllowedHeroesT1.remove(getLastCreatedEntity().getCurrentHero())
    GlobalTeamComp[0] += 1
    lbl_1:
    if GlobalTeamComp[2] >= 2:
        goto lbl_2
    createDummy([i for i in getDamageHeroes() if i in AllowedHeroesT1 == true], Team.1, -1, weirdVect1, vect(0, 0, 0))
    AllowedHeroesT1.remove(getLastCreatedEntity().getCurrentHero())
    GlobalTeamComp[2] += 1
    lbl_2:
    if GlobalTeamComp[2] >= 2:
        goto lbl_3
    createDummy([i for i in getDamageHeroes() if i in AllowedHeroesT1 == true], Team.1, -1, weirdVect1, vect(0, 0, 0))
    AllowedHeroesT1.remove(getLastCreatedEntity().getCurrentHero())
    GlobalTeamComp[2] += 1
    lbl_3:
    if GlobalTeamComp[4] >= 2:
        goto lbl_4
    createDummy([i for i in getSupportHeroes() if i in AllowedHeroesT1 == true], Team.1, -1, weirdVect1, vect(0, 0, 0))
    AllowedHeroesT1.remove(getLastCreatedEntity().getCurrentHero())
    GlobalTeamComp[4] += 1
    lbl_4:
    if GlobalTeamComp[4] >= 2:
        goto lbl_5
    createDummy([i for i in getSupportHeroes() if i in AllowedHeroesT1 == true], Team.1, -1, weirdVect1, vect(0, 0, 0))
    GlobalTeamComp[4] += 1
    AllowedHeroesT1.remove(getLastCreatedEntity().getCurrentHero())
    lbl_5:


rule "Team: Spawn Team 2 [Enable Team Option 0 for Default Team, that use 2-2-2 and deny duplicate pics]":
    @Condition Teams == 0
    @Condition (isAssemblingHeroes() or getCurrentGamemode() == Gamemode.SKIRMISH) == true
    
    wait(37)
    if GlobalTeamComp[1] >= 2:
        goto lbl_0
    createDummy([i for i in getTankHeroes() if i in AllowedHeroesT2 == true], Team.2, -1, weirdVect2, vect(0, 0, 0))
    AllowedHeroesT2.remove(getLastCreatedEntity().getCurrentHero())
    GlobalTeamComp[1] += 1
    lbl_0:
    if GlobalTeamComp[1] >= 2:
        goto lbl_1
    createDummy([i for i in getTankHeroes() if i in AllowedHeroesT2 == true], Team.2, -1, weirdVect2, vect(0, 0, 0))
    AllowedHeroesT2.remove(getLastCreatedEntity().getCurrentHero())
    GlobalTeamComp[1] += 1
    lbl_1:
    if GlobalTeamComp[3] >= 2:
        goto lbl_2
    createDummy([i for i in getDamageHeroes() if i in AllowedHeroesT2 == true], Team.2, -1, weirdVect2, vect(0, 0, 0))
    AllowedHeroesT2.remove(getLastCreatedEntity().getCurrentHero())
    GlobalTeamComp[3] += 1
    lbl_2:
    if GlobalTeamComp[3] >= 2:
        goto lbl_3
    createDummy([i for i in getDamageHeroes() if i in AllowedHeroesT2 == true], Team.2, -1, weirdVect2, vect(0, 0, 0))
    AllowedHeroesT2.remove(getLastCreatedEntity().getCurrentHero())
    GlobalTeamComp[3] += 1
    lbl_3:
    if GlobalTeamComp[5] >= 2:
        goto lbl_4
    createDummy([i for i in getSupportHeroes() if i in AllowedHeroesT2 == true], Team.2, -1, weirdVect2, vect(0, 0, 0))
    AllowedHeroesT2.remove(getLastCreatedEntity().getCurrentHero())
    GlobalTeamComp[5] += 1
    lbl_4:
    if GlobalTeamComp[5] >= 2:
        goto lbl_5
    createDummy([i for i in getSupportHeroes() if i in AllowedHeroesT2 == true], Team.2, -1, weirdVect2, vect(0, 0, 0))
    GlobalTeamComp[5] += 1
    AllowedHeroesT2.remove(getLastCreatedEntity().getCurrentHero())
    lbl_5:


rule "Team: Spawn Random Team [Enable Team Option 1 and choose Number for Team 1 Bots]":
    @Condition Teams == 1
    @Condition (isAssemblingHeroes() or getCurrentGamemode() == Gamemode.SKIRMISH) == true
    
    wait(35)
    for I in range(BotsTeam1):
        createDummy(random.choice(getAllHeroes()), Team.1, -1, vect(10000, 10000, 10000), vect(0, 0, 0))


rule "Team: Spawn Random Team [Enable Team Option 1 and choose Number for Team 2 Bots]":
    @Condition Teams == 1
    @Condition (isAssemblingHeroes() or getCurrentGamemode() == Gamemode.SKIRMISH) == true
    
    wait(35)
    for I in range(BotsTeam2):
        createDummy(random.choice(getAllHeroes()), Team.2, -1, vect(10000, 10000, 10000), vect(0, 0, 0))


rule "Team: Spawn Custom Teams [Enable Team Option 2 and choose Custom Bots]":
    @Condition (isAssemblingHeroes() or getCurrentGamemode() == Gamemode.SKIRMISH) == true
    @Condition Teams == 2
    
    wait(35)
    if BotSlot0team1 != 0:
        createDummy(AllHeros[BotSlot0team1], Team.1, 0, vect(10000, 10000, 10000), vect(0, 0, 0))
    if BotSlot1team1 != 0:
        createDummy(AllHeros[BotSlot1team1], Team.1, 1, vect(10000, 10000, 10000), vect(0, 0, 0))
    if BotSlot2team1 != 0:
        createDummy(AllHeros[BotSlot2team1], Team.1, 2, vect(10000, 10000, 10000), vect(0, 0, 0))
    if BotSlot3team1 != 0:
        createDummy(AllHeros[BotSlot3team1], Team.1, 3, vect(10000, 10000, 10000), vect(0, 0, 0))
    if BotSlot4team1 != 0:
        createDummy(AllHeros[BotSlot4team1], Team.1, 4, vect(10000, 10000, 10000), vect(0, 0, 0))
    if BotSlot5team1 != 0:
        createDummy(AllHeros[BotSlot5team1], Team.1, 5, vect(10000, 10000, 10000), vect(0, 0, 0))
    if BotSlot0team2 != 0:
        createDummy(AllHeros[BotSlot0team2], Team.2, 0, vect(10000, 10000, 10000), vect(0, 0, 0))
    if BotSlot1team2 != 0:
        createDummy(AllHeros[BotSlot1team2], Team.2, 1, vect(10000, 10000, 10000), vect(0, 0, 0))
    if BotSlot2team2 != 0:
        createDummy(AllHeros[BotSlot2team2], Team.2, 2, vect(10000, 10000, 10000), vect(0, 0, 0))
    if BotSlot3team2 != 0:
        createDummy(AllHeros[BotSlot3team2], Team.2, 3, vect(10000, 10000, 10000), vect(0, 0, 0))
    if BotSlot4team2 != 0:
        createDummy(AllHeros[BotSlot4team2], Team.2, 4, vect(10000, 10000, 10000), vect(0, 0, 0))
    if BotSlot5team2 != 0:
        createDummy(AllHeros[BotSlot5team2], Team.2, 5, vect(10000, 10000, 10000), vect(0, 0, 0))


rule "Team: Replace Left Player Team 1 [Enable Replacer Bots]":
    @Event playerLeft
    @Team 1
    @Condition ReplacerBots == true
    
    createDummy(random.choice(AllowedHeroesT1), Team.1, -1, weirdVect1, vect(0, 0, 0))
    wait(random.uniform(0.3, 1))
    kill(getLastCreatedEntity(), null)


rule "Team: Replace Left Player Team 2 [Enable Replacer Bots]":
    @Event playerLeft
    @Team 2
    @Condition ReplacerBots == true
    
    createDummy(random.choice(AllowedHeroesT2), Team.2, -1, weirdVect2, vect(0, 0, 0))
    wait(random.uniform(0.3, 1))
    kill(getLastCreatedEntity(), null)


/*
rule "===== AI PREPARE ====":
*/

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
    eventPlayer.XX = false
    if eventPlayer.getCurrentHero() != Hero.ZARYA:
        goto lbl_0
    eventPlayer.CanHeal = true
    lbl_0:
    wait(0.25)
    eventPlayer.Bot_Waiting_Time = random.uniform(0.2, 0.6)
    eventPlayer.Mercy_Rez = true
    eventPlayer.Communicate = true


/*
rule "===== CONDITION =====":
*/

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


/*
rule "===== ACTION =====":
*/

rule "Action: Face Enemy":
    @Event eachPlayer
    @Condition eventPlayer.BotActive == true
    @Condition eventPlayer.CanSeeEnemy == true
    @Condition eventPlayer.StopFacing == false
    @Condition eventPlayer.L == false
    @Condition eventPlayer.CanSeeDamagedAlly == false
    @Condition eventPlayer.CanHeal == true
    @Condition eventPlayer.getCurrentHero() != Hero.MERCY
    
    eventPlayer.startFacing(directionTowards(eventPlayer.getEyePosition(), eventPlayer.CurrentTarget.last().getEyePosition()), eventPlayer.TurnRate, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)


rule "Action: Face Enemy":
    @Event eachPlayer
    @Condition eventPlayer.BotActive == true
    @Condition eventPlayer.CanSeeEnemy == true
    @Condition eventPlayer.StopFacing == false
    @Condition eventPlayer.L == false
    @Condition eventPlayer.CanHeal == false
    @Condition eventPlayer.getCurrentHero() != Hero.MERCY
    
    eventPlayer.startFacing(directionTowards(eventPlayer.getEyePosition(), eventPlayer.CurrentTarget.last().getEyePosition()), eventPlayer.TurnRate, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)


rule "Action: Face Damaged Ally":
    @Event eachPlayer
    @Condition eventPlayer.BotActive == true
    @Condition eventPlayer.CanSeeDamagedAlly == true
    @Condition eventPlayer.StopFacing == false
    @Condition eventPlayer.L == false
    @Condition eventPlayer.getCurrentHero() != Hero.BRIGITTE
    @Condition eventPlayer.CanHeal == true
    
    eventPlayer.startFacing(directionTowards(eventPlayer.getEyePosition(), eventPlayer.CurrentHealTarget[0].getEyePosition()), eventPlayer.TurnRate, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)


rule "Action: Face Current Waypoint (Path)":
    @Event eachPlayer
    @Condition eventPlayer.BotActive == true
    @Condition eventPlayer.CanSeeEnemy == false
    @Condition eventPlayer.StopFacing == false
    @Condition eventPlayer.L == false
    @Condition (isGameInProgress() or getCurrentGamemode() == Gamemode.SKIRMISH) == true
    @Condition getPlayersOnHero(Hero.WIDOWMAKER, eventPlayer.getTeam())[0].isUsingUltimate() == false
    @Condition eventPlayer.CanHeal == false
    @Condition eventPlayer.isOnObjective() == false
    @Condition eventPlayer.getCurrentHero() != Hero.MERCY
    
    eventPlayer.startFacing(directionTowards(eventPlayer.getEyePosition(), eventPlayer.CurrentVisibleWaypoints[0]), 200, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
    #eventPlayer.startFacing(directionTowards(eventPlayer.getEyePosition(), eventPlayer.RandomFacingDirection[0]), random.uniform(300, 600), Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)


rule "Action: Face Current Waypoint (Path)":
    @Event eachPlayer
    @Condition eventPlayer.BotActive == true
    @Condition eventPlayer.CanSeeEnemy == false
    @Condition eventPlayer.StopFacing == false
    @Condition eventPlayer.L == false
    @Condition (isGameInProgress() or getCurrentGamemode() == Gamemode.SKIRMISH) == true
    @Condition eventPlayer.CanSeeDamagedAlly == false
    @Condition getPlayersOnHero(Hero.WIDOWMAKER, eventPlayer.getTeam())[0].isUsingUltimate() == false
    @Condition eventPlayer.CanHeal == true
    @Condition eventPlayer.isOnObjective() == false
    @Condition eventPlayer.getCurrentHero() != Hero.MERCY
    
    eventPlayer.startFacing(directionTowards(eventPlayer.getEyePosition(), eventPlayer.CurrentVisibleWaypoints[0]), eventPlayer.TurnRate, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)


rule "Action: Face Current Waypoint (Objective)":
    @Event eachPlayer
    @Condition eventPlayer.BotActive == true
    @Condition eventPlayer.CanSeeEnemy == false
    @Condition eventPlayer.StopFacing == false
    @Condition eventPlayer.L == false
    @Condition (isGameInProgress() or getCurrentGamemode() == Gamemode.SKIRMISH) == true
    @Condition getPlayersOnHero(Hero.WIDOWMAKER, eventPlayer.getTeam())[0].isUsingUltimate() == false
    @Condition eventPlayer.CanHeal == false
    @Condition eventPlayer.isOnObjective() == true
    @Condition eventPlayer.getCurrentHero() != Hero.MERCY
    
    eventPlayer.startFacing(directionTowards(eventPlayer.getEyePosition(), eventPlayer.RandomFacingDirection[0]), eventPlayer.TurnRate, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)


rule "Action: Face Current Waypoint (Objective)":
    @Event eachPlayer
    @Condition eventPlayer.BotActive == true
    @Condition eventPlayer.CanSeeEnemy == false
    @Condition eventPlayer.StopFacing == false
    @Condition eventPlayer.L == false
    @Condition (isGameInProgress() or getCurrentGamemode() == Gamemode.SKIRMISH) == true
    @Condition eventPlayer.CanSeeDamagedAlly == false
    @Condition getPlayersOnHero(Hero.WIDOWMAKER, eventPlayer.getTeam())[0].isUsingUltimate() == false
    @Condition eventPlayer.CanHeal == true
    @Condition eventPlayer.isOnObjective() == true
    @Condition eventPlayer.getCurrentHero() != Hero.MERCY
    
    eventPlayer.startFacing(directionTowards(eventPlayer.getEyePosition(), eventPlayer.RandomFacingDirection[0]), eventPlayer.TurnRate, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)


rule "Action: Stop Facing":
    @Event eachPlayer
    @Condition eventPlayer.BotActive == true
    @Condition eventPlayer.StopFacing == true
    
    eventPlayer.stopFacing()


rule "Action: Chase Enemy":
    @Event eachPlayer
    @Condition eventPlayer.BotActive == true
    @Condition eventPlayer.ChaseEnemy == true
    @Condition eventPlayer.CanSeeEnemy == true
    
    eventPlayer.startThrottleInDirection(directionTowards(eventPlayer, eventPlayer.CurrentVisibleWaypoints[0]), 1, Relativity.TO_WORLD, Throttle.REPLACE_EXISTING, ThrottleReeval.DIRECTION_AND_MAGNITUDE)


rule "Action: Jump":
    @Event playerTookDamage
    @Condition eventPlayer.BotActive == true
    @Condition eventPlayer.getCurrentHero() != Hero.BAPTISTE
    @Condition Difficulty > 2 == true
    
    if eventPlayer.getCurrentHero() == Hero.WIDOWMAKER:
        goto lbl_0
    eventPlayer.forceButtonPress(Button.JUMP)
    lbl_0:


/*
rule "===== AI ACTIVE =====":
*/

rule "Bot Active start":
    @Event eachPlayer
    @Condition eventPlayer.isDummy() == false
    @Condition eventPlayer.BotActive == false
    @Condition eventPlayer.isStanding() == true
    @Condition (isGameInProgress() or getCurrentGamemode() == Gamemode.SKIRMISH) == true
    @Condition AFK_protection == true
    
    wait(AFK_timer, Wait.ABORT_WHEN_FALSE)
    eventPlayer.BotActive = true
    hudHeader(eventPlayer, "AI ACTIVE (Hold Crouch 3sec. to End)", HudPosition.TOP, 0, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)


rule "Bot Active start":
    @Event eachPlayer
    @Condition eventPlayer.isDummy() == true
    
    eventPlayer.BotActive = true


rule "Bot Active end":
    @Event eachPlayer
    @Condition eventPlayer.isDummy() == false
    @Condition eventPlayer.isHoldingButton(Button.CROUCH) == true
    @Condition eventPlayer.BotActive == true
    
    wait(3, Wait.ABORT_WHEN_FALSE)
    eventPlayer.BotActive = false
    eventPlayer.stopThrottleInDirection()
    eventPlayer.stopFacing()
    eventPlayer.stopForcingButton(Button.PRIMARY_FIRE)
    eventPlayer.stopForcingButton(Button.SECONDARY_FIRE)
    destroyAllHudTexts()


rule "Navigation: Healthpack- Variable":
    @Event eachPlayer
    @Condition eventPlayer.BotActive == true
    @Condition (isGameInProgress() or getCurrentGamemode() == Gamemode.SKIRMISH) == true
    
    eventPlayer.ClosestHealthpackPosition = sorted([player for player in HealthpackLocations if player in HackedHealthpack == false], lambda i: distance(eventPlayer, i))
    wait(random.uniform(0.2, 0.4))
    goto RULE_START


/*
rule "===== BASIC =====":
*/

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
    @Condition getDeadPlayers(eventPlayer.getTeam()) != [] == true
    @Condition eventPlayer.BotActive == true
    @Condition Difficulty > 3 == true
    
    eventPlayer.setStatusEffect(null, Status.ROOTED, 1)
    wait(0.8, Wait.ABORT_WHEN_FALSE)
    if RULE_CONDITION:
        goto RULE_START


rule "Bots AI: Clear Root in Spawn":
    @Event eachPlayer
    @Condition getDeadPlayers(eventPlayer.getTeam()) == [] == true
    @Condition eventPlayer.BotActive == true
    
    eventPlayer.clearStatusEffect(Status.ROOTED)


/*
rule "===== TARGET PRIORITY =====":
*/

rule "Target: Priority based on Hero Class - In Spawn":
    @Event eachPlayer
    @Condition eventPlayer.isAlive() == true
    @Condition (isGameInProgress() or getCurrentGamemode() == Gamemode.SKIRMISH) == true
    @Condition eventPlayer.isInSpawnRoom() == true
    
    if eventPlayer.getCurrentHero() in getTankHeroes() == true:
        eventPlayer.HeroPriorityRating = 0
    if eventPlayer.getCurrentHero() in getDamageHeroes() == true:
        eventPlayer.HeroPriorityRating = 1
    if eventPlayer.getCurrentHero() in getSupportHeroes() == true:
        eventPlayer.HeroPriorityRating = 2


rule "Target: Priority based on Hero Class - Not In Spawn":
    @Event eachPlayer
    @Condition eventPlayer.isAlive() == true
    @Condition (isGameInProgress() or getCurrentGamemode() == Gamemode.SKIRMISH) == true
    @Condition eventPlayer.isInSpawnRoom() == false
    
    if eventPlayer.getCurrentHero() in getTankHeroes() == true:
        eventPlayer.HeroPriorityRating = 0
    if eventPlayer.getCurrentHero() in getDamageHeroes() == true:
        eventPlayer.HeroPriorityRating = 1
    if eventPlayer.getCurrentHero() in getSupportHeroes() == true:
        eventPlayer.HeroPriorityRating = 2


rule "Target: Change Priority":
    @Event eachPlayer
    @Condition eventPlayer.isAlive() == true
    @Condition (isGameInProgress() or getCurrentGamemode() == Gamemode.SKIRMISH) == true
    @Condition eventPlayer.isInSpawnRoom() == false
    
    if eventPlayer.isUsingUltimate() == true:
        eventPlayer.HeroPriorityRating += 1
        wait(7, Wait.ABORT_WHEN_FALSE)
        eventPlayer.HeroPriorityRating -= 1
    if eventPlayer.getNormalizedHealth() <= 0.6:
        eventPlayer.HeroPriorityRating += 1
    if eventPlayer.getNormalizedHealth() <= 0.3:
        eventPlayer.HeroPriorityRating += 1
    if eventPlayer.isOnFire() == true:
        eventPlayer.HeroPriorityRating += 1
    wait(1)
    if RULE_CONDITION:
        goto RULE_START


rule "Target: Stealth? 1":
    @Event eachPlayer
    @Hero sombra
    @Condition eventPlayer.isUsingAbility1() == true
    @Condition distance(eventPlayer, getClosestPlayer(eventPlayer, getOppositeTeam(eventPlayer.getTeam()))) > 1
    @Condition getPlayersOnHero(Hero.WIDOWMAKER, getOppositeTeam(eventPlayer.getTeam())).isUsingUltimate() == false
    
    eventPlayer.Stealth = true


rule "Target: Stealth? 2":
    @Event eachPlayer
    @Condition eventPlayer.isUsingAbility1() == false
    
    eventPlayer.Stealth = false


rule "Target: Stealth? 3":
    @Event eachPlayer
    @Condition distance(eventPlayer, getClosestPlayer(eventPlayer, getOppositeTeam(eventPlayer.getTeam()))) <= 1
    
    eventPlayer.Stealth = false


rule "Target: Stealth? 4":
    @Event eachPlayer
    @Hero sombra
    @Condition getPlayersOnHero(Hero.WIDOWMAKER, getOppositeTeam(eventPlayer.getTeam())).isUsingUltimate() == true
    
    eventPlayer.Stealth = false


/*
rule "===== RESET =====":
*/

rule "Reset: OnObjective":
    @Event eachPlayer
    @Condition eventPlayer.isOnObjective() == true
    @Condition (isGameInProgress() or getCurrentGamemode() == Gamemode.SKIRMISH) == true
    @Condition eventPlayer.BotActive == true
    
    eventPlayer.WaypointBlacklist = []


rule "Reset: Dead":
    @Event eachPlayer
    @Condition eventPlayer.isDead() == true
    @Condition (isGameInProgress() or getCurrentGamemode() == Gamemode.SKIRMISH) == true
    @Condition eventPlayer.BotActive == true
    
    eventPlayer.WaypointBlacklist = []


rule "Reset: Stuck":
    @Event eachPlayer
    @Condition eventPlayer.BotActive == true
    @Condition eventPlayer.CurrentVisibleWaypoints == []
    
    eventPlayer.WaypointBlacklist = []


/*
rule "===== HACK (SOMBRA)=====":
*/

rule "Hack: See Healthpack":
    @Event eachPlayer
    @Hero sombra
    @Condition eventPlayer.BotActive == true
    @Condition getNumberOfPlayersOnObjective(eventPlayer.getTeam()) > 0
    @Condition getNumberOfPlayersOnObjective(getOppositeTeam(eventPlayer.getTeam())) == 0
    @Condition (isGameInProgress() or getCurrentGamemode() == Gamemode.SKIRMISH) == true
    @Condition StartBots == true
    
    eventPlayer.HackTargets = sorted([player for player in HealthpackLocations if player in HackedHealthpack == false], lambda i: distance(eventPlayer, i))
    eventPlayer.CurrentGoToTarget = eventPlayer.HackTargets[0]
    wait(random.uniform(0.3, 1.5))
    if RULE_CONDITION:
        goto RULE_START
    eventPlayer.CurrentGoToTarget = getObjectivePosition(getCurrentObjective())


rule "Hack: Add Hacked Point to the Blacklist":
    @Event eachPlayer
    @Hero sombra
    @Condition eventPlayer.isFiringSecondaryFire() == true
    @Condition eventPlayer.BotActive == true
    @Condition eventPlayer.CanSeeEnemy == false
    @Condition ServerLoadIsHigh == false
    @Condition eventPlayer.CurrentHealthpack != []
    @Condition distance(eventPlayer, eventPlayer.CurrentHealthpack[0]) <= 7.777
    
    wait(0.5, Wait.ABORT_WHEN_FALSE)
    if eventPlayer.getTeam() == Team.1:
        goto lbl_0
    HackedHealthpack.append(eventPlayer.ClosestHealthpackPosition[0])
    lbl_0:


rule "Hack: Remove Hacked Healthpack from Blacklist":
    @Condition HackedHealthpack != []
    
    wait(30)
    del HackedHealthpack[0]


/*
rule "===== MODULE =====":
*/

rule "Module: Dummy Bot can See Enemy - FALSE":
    @Event eachPlayer
    @Condition (eventPlayer.BotActive == true and eventPlayer.CanSeeEnemy == true and StartBots == true and ServerLoadIsHigh == false) == false
    
    eventPlayer.Module_001_DummyBotEnemy = false


rule "Module: Dummy Bot can See Damaged Ally - TRUE":
    @Event eachPlayer
    @Condition (eventPlayer.BotActive == true and eventPlayer.CanSeeDamagedAlly == true and StartBots == true and ServerLoadIsHigh == false) == true
    
    eventPlayer.Module_007_DummyBot_SeeDamagedA = true


rule "Module: Dummy Bot can See Damaged Ally - FALSE":
    @Event eachPlayer
    @Condition (eventPlayer.BotActive == true and eventPlayer.CanSeeDamagedAlly == true and StartBots == true and ServerLoadIsHigh == false) == false
    
    eventPlayer.Module_007_DummyBot_SeeDamagedA = false


rule "Module: Dummy Bot - TRUE":
    @Event eachPlayer
    @Condition (eventPlayer.BotActive == true and isGameInProgress() == true and StartBots == true and ServerLoadIsHigh == false) == true
    
    eventPlayer.Module_002_DummyBot = true


rule "Module: Dummy Bot  - FALSE":
    @Event eachPlayer
    @Condition (eventPlayer.BotActive == true and isGameInProgress() == true and StartBots == true and ServerLoadIsHigh == false) == false
    
    eventPlayer.Module_002_DummyBot = false


def Action_Module_001_UseAbility1():
    @Name "Action Module: Use Ability 1"
    
    eventPlayer.forceButtonPress(Button.ABILITY_1)


def Action_Module_002_UseAbility2():
    @Name "Action Module: Use Ability 2"
    
    eventPlayer.forceButtonPress(Button.ABILITY_2)


def Action_Module_003_UseUltimate():
    @Name "Action Module: Use Ultimate"
    
    eventPlayer.forceButtonPress(Button.ULTIMATE)


def Action_Module_004_UsePrimary_B():
    @Name "Action Module: Primary Fire Burst"
    
    eventPlayer.forceButtonPress(Button.PRIMARY_FIRE)
    wait(eventPlayer.Bot_Waiting_Time)


def Action_Module_005_UseSecondary_B():
    @Name "Action Module: Primary Fire Burst"
    
    eventPlayer.forceButtonPress(Button.SECONDARY_FIRE)
    wait(eventPlayer.Bot_Waiting_Time)


def Action_Module_006_UsePrimary_A():
    @Name "Action Module: Primary Fire Automatic"
    
    eventPlayer.startForcingButton(Button.PRIMARY_FIRE)


def Action_Module_007_UseSecondary_A():
    @Name "Action Module: Secondary Fire Automatic"
    
    if eventPlayer.isFiringSecondaryFire() == true:
        goto lbl_0
    eventPlayer.startForcingButton(Button.SECONDARY_FIRE)
    lbl_0:


def Action_Module_009_Distance_Info():
    @Name "Action Module: Distance Calculator"
    
    eventPlayer.Module_003_LowRange5m = false
    eventPlayer.Module_004_MidRange10m = false
    eventPlayer.Module_005_LongRange15m = false
    eventPlayer.Module_006_HighRange20m = false
    if distance(eventPlayer, eventPlayer.CurrentTarget) <= 5:
        eventPlayer.Module_003_LowRange5m = true
    if distance(eventPlayer, eventPlayer.CurrentTarget) <= 10:
        eventPlayer.Module_004_MidRange10m = true
    if distance(eventPlayer, eventPlayer.CurrentTarget) <= 15:
        eventPlayer.Module_005_LongRange15m = true
    if distance(eventPlayer, eventPlayer.CurrentTarget) > 20:
        eventPlayer.Module_006_HighRange20m = true


def Action_Module_010_Selfuse_Start():
    @Name "Action Module: SelfUse_Start"
    
    Action_Module_011_StopAction()
    eventPlayer.startFacing(directionTowards(eventPlayer.getEyePosition(), eventPlayer.getPosition()), 500, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)


def Action_Module_010_Selfuse_End():
    @Name "Action Module: SelfUse_End"
    
    wait(0.25)
    Action_Module_011_StartAction()


def Action_Module_011_StartAction():
    @Name "Action Module: Start Action"
    
    eventPlayer.StopShoot = false
    eventPlayer.StopFacing = false
    eventPlayer.CurrentGoToTarget = getObjectivePosition(getCurrentObjective())
    wait(0.25)


def Action_Module_011_StopAction():
    @Name "Action Module: Stop Action"
    
    eventPlayer.StopShoot = true
    eventPlayer.StopFacing = true
    wait(0.25)


def Action_Module_012_Health():
    @Name "Action Module: Health Calculator"
    
    eventPlayer.Module_008_VeryLowHealth30 = false
    eventPlayer.Module_009_HalfHealth50 = false
    eventPlayer.Module_010_HighHealth75 = false
    eventPlayer.Module_011_OverHealth75 = false
    if eventPlayer.getNormalizedHealth() <= 0.3:
        eventPlayer.Module_008_VeryLowHealth30 = true
    if eventPlayer.getNormalizedHealth() <= 0.5:
        eventPlayer.Module_009_HalfHealth50 = true
    if eventPlayer.getNormalizedHealth() <= 0.75:
        eventPlayer.Module_010_HighHealth75 = true
    if eventPlayer.getNormalizedHealth() > 0.75:
        eventPlayer.Module_011_OverHealth75 = true


def Action_Module_008_UseSecondary_S():
    @Name "Action Module: Wait for finish Secondary Fire"
    
    if eventPlayer.isFiringSecondaryFire() == true:
        wait(0.25)
        if eventPlayer.isFiringSecondaryFire() == true:
            goto RULE_START
    else:
        eventPlayer.stopForcingButton(Button.SECONDARY_FIRE)


def Action_Module_013_Ability1_S():
    @Name "Action Module: Wait for finish Ability 1"
    
    if eventPlayer.isUsingAbility1() == true:
        wait(0.25)
        if eventPlayer.isUsingAbility1() == true:
            goto RULE_START
    else:


def Action_Module_014_Ability2_S():
    @Name "Action Module: Wait for finish Ability 2"
    
    if eventPlayer.isUsingAbility2() == true:
        wait(0.25)
        if eventPlayer.isUsingAbility2() == true:
            goto RULE_START
    else:


def Action_Module_015_Ultimate_S():
    @Name "Action Module: Wait for finish Ultimate"
    
    if eventPlayer.isUsingUltimate() == true:
        wait(0.25)
        if eventPlayer.isUsingUltimate() == true:
            goto RULE_START
    else:


def Action_Module_016_Chase_Ult():
    @Name "Action Module: Chase Enemy during ult"
    
    if isInLoS(eventPlayer, eventPlayer.CurrentTarget[0], BarrierLos.PASS_THROUGH_BARRIERS) == true and eventPlayer.CurrentTarget != []:
        eventPlayer.StopAutomaticGoTo = false
        eventPlayer.CurrentGoToTarget = getClosestPlayer(eventPlayer, getOppositeTeam(eventPlayer.getTeam()))
        eventPlayer.CurrentVisibleWaypoints = sorted([i for i in [player for player in Waypoints if isInLoS(eventPlayer, player, BarrierLos.PASS_THROUGH_BARRIERS) == true] if i in eventPlayer.WaypointBlacklist == false], lambda i: distance(i, eventPlayer.CurrentGoToTarget[0]))
        eventPlayer.startThrottleInDirection(directionTowards(eventPlayer, eventPlayer.CurrentVisibleWaypoints[0]), 1, Relativity.TO_WORLD, Throttle.REPLACE_EXISTING, ThrottleReeval.DIRECTION_AND_MAGNITUDE)
    else:
        eventPlayer.StopAutomaticGoTo = true
        eventPlayer.startThrottleInDirection(directionTowards(eventPlayer, eventPlayer.CurrentTarget[0]), 1, Relativity.TO_WORLD, Throttle.REPLACE_EXISTING, ThrottleReeval.DIRECTION_AND_MAGNITUDE)
    wait(eventPlayer.Bot_Waiting_Time)
    if eventPlayer.isUsingUltimate() == true:
        goto RULE_START


def Action_Module_017_Sec_S():
    @Name "Action Module: Wait for finish Sec"
    
    if eventPlayer.isFiringSecondaryFire() == true:
        wait(0.25)
        if eventPlayer.isFiringSecondaryFire() == true:
            goto RULE_START
    else:


rule "Module: Dummy Bot can See Ally - TRUE":
    @Event eachPlayer
    @Condition (eventPlayer.BotActive == true and eventPlayer.CanSeeAlly == true and StartBots == true and ServerLoadIsHigh == false) == true
    
    eventPlayer.Module_012_DummyBotAlly = true


rule "Module: Dummy Bot can See Ally - FALSE":
    @Event eachPlayer
    @Condition (eventPlayer.BotActive == true and eventPlayer.CanSeeAlly == true and StartBots == true and ServerLoadIsHigh == false) == false
    
    eventPlayer.Module_012_DummyBotAlly = false


rule "Module: Dummy Bot can See Enemy - TRUE":
    @Event eachPlayer
    @Condition (eventPlayer.BotActive == true and eventPlayer.CanSeeEnemy == true and StartBots == true and ServerLoadIsHigh == false) == true
    
    eventPlayer.Module_001_DummyBotEnemy = true


def Action_Module_018_Hold_POS():
    @Name "Module: 18 Hold Pos"
    
    eventPlayer.forceButtonPress(Button.CROUCH)
    eventPlayer.startForcingThrottle(random.uniform(0, 1), random.randint(0, 1), random.randint(0, 1), random.randint(0, 1), random.randint(0, 1), random.randint(0, 1))
    wait(random.uniform(0.1, 0.5))
    eventPlayer.startForcingThrottle(random.uniform(0, 1), random.randint(0, 1), random.randint(0, 1), random.randint(0, 1), random.randint(0, 1), random.randint(0, 1))
    wait(random.uniform(0.1, 0.5))
    eventPlayer.startForcingThrottle(random.uniform(0, 1), random.randint(0, 1), random.randint(0, 1), random.randint(0, 1), random.randint(0, 1), random.randint(0, 1))
    wait(random.uniform(0.1, 0.5))
    eventPlayer.startForcingThrottle(random.uniform(0, 1), random.randint(0, 1), random.randint(0, 1), random.randint(0, 1), random.randint(0, 1), random.randint(0, 1))
    wait(random.uniform(0.1, 0.5))
    eventPlayer.startForcingThrottle(random.uniform(0, 1), random.randint(0, 1), random.randint(0, 1), random.randint(0, 1), random.randint(0, 1), random.randint(0, 1))
    wait(random.uniform(0.1, 0.5))
    eventPlayer.stopForcingThrottle()


/*
rule "===== SMART OBJECT=====":
*/

rule "Navigation: Jump - Variable":
    @Event eachPlayer
    @Condition eventPlayer.BotActive == true
    @Condition (isGameInProgress() or getCurrentGamemode() == Gamemode.SKIRMISH) == true
    
    eventPlayer.JumpPoint = sorted([player for player in JumpPointsGlobal if isInLoS(eventPlayer, player, BarrierLos.PASS_THROUGH_BARRIERS) == true], lambda i: distance(eventPlayer, i))
    wait(random.uniform(0.2, 0.4))
    goto RULE_START


rule "Navigation: Jump - SmartObject":
    @Event eachPlayer
    @Condition (isGameInProgress() or getCurrentGamemode() == Gamemode.SKIRMISH) == true
    @Condition eventPlayer.BotActive == true
    @Condition StartBots == true
    @Condition distance(eventPlayer.getEyePosition(), eventPlayer.JumpPoint[0]) <= 2.5
    @Condition eventPlayer.JumpPoint != []
    
    eventPlayer.forceButtonPress(Button.JUMP)
    wait(random.uniform(0.2, 0.4))
    if RULE_CONDITION:
        goto RULE_START


/*
rule "===== NAV FIX =====":
*/

rule "BUSAN JUMP A":
    @Event eachPlayer
    @Condition distance(eventPlayer, vect(23.162, 9.425, -91.69)) <= 1.25
    @Condition getCurrentMap() == Map.BUSAN
    @Condition getCurrentObjective() == 0
    
    eventPlayer.setJumpVerticalSpeed(175)
    eventPlayer.forceButtonPress(Button.JUMP)
    wait(0.25)
    eventPlayer.setJumpVerticalSpeed(100)
    wait(2.5)
    if RULE_CONDITION:
        goto RULE_START


rule "BUSAN JUMP B":
    @Event eachPlayer
    @Condition distance(eventPlayer, vect(80.722, 9.425, -91.69)) <= 1.25
    @Condition getCurrentMap() == Map.BUSAN
    @Condition getCurrentObjective() == 0
    
    eventPlayer.setJumpVerticalSpeed(175)
    eventPlayer.forceButtonPress(Button.JUMP)
    wait(0.25)
    eventPlayer.setJumpVerticalSpeed(100)
    wait(2.5)
    if RULE_CONDITION:
        goto RULE_START


rule "LIJIANG 2 - FIX A":
    @Event eachPlayer
    @Condition distance(eventPlayer, vect(18.75, 95.425, 164.456)) <= 2.5
    @Condition getCurrentObjective() == 1
    @Condition (getCurrentMap() == Map.LIJIANG_TOWER or getCurrentMap() == Map.LIJIANG_TOWER_LNY) == true
    
    eventPlayer.StopAutomaticGoTo = true
    eventPlayer.stopThrottleInDirection()
    wait(0.25)
    eventPlayer.startThrottleInDirection(directionTowards(eventPlayer, vect(22.202, 95.425, 170.924)), 1, Relativity.TO_WORLD, Throttle.REPLACE_EXISTING, ThrottleReeval.DIRECTION_AND_MAGNITUDE)
    wait(2)
    eventPlayer.startThrottleInDirection(directionTowards(eventPlayer, vect(10.882, 95.425, 177.882)), 1, Relativity.TO_WORLD, Throttle.REPLACE_EXISTING, ThrottleReeval.DIRECTION_AND_MAGNITUDE)
    wait(3)
    eventPlayer.startThrottleInDirection(directionTowards(eventPlayer, vect(0.621, 95.425, 178.975)), 1, Relativity.TO_WORLD, Throttle.REPLACE_EXISTING, ThrottleReeval.DIRECTION_AND_MAGNITUDE)
    wait(2)
    eventPlayer.stopThrottleInDirection()
    eventPlayer.StopAutomaticGoTo = false
    wait(0.25)
    eventPlayer.startThrottleInDirection(directionTowards(eventPlayer, eventPlayer.CurrentGoToTarget[0]), 1, Relativity.TO_WORLD, Throttle.REPLACE_EXISTING, ThrottleReeval.DIRECTION_AND_MAGNITUDE)
    wait(2)
    if RULE_CONDITION:
        goto RULE_START


rule "LIJIANG 2 - FIX B":
    @Event eachPlayer
    @Condition distance(eventPlayer, vect(11.325, 95.425, 169.777)) <= 2.5
    @Condition getCurrentObjective() == 1
    @Condition (getCurrentMap() == Map.LIJIANG_TOWER or getCurrentMap() == Map.LIJIANG_TOWER_LNY) == true
    
    eventPlayer.StopAutomaticGoTo = true
    eventPlayer.stopThrottleInDirection()
    wait(0.25)
    eventPlayer.startThrottleInDirection(directionTowards(eventPlayer, vect(13.214, 95.425, 177.375)), 1, Relativity.TO_WORLD, Throttle.REPLACE_EXISTING, ThrottleReeval.DIRECTION_AND_MAGNITUDE)
    wait(2)
    eventPlayer.startThrottleInDirection(directionTowards(eventPlayer, vect(1.609, 95.425, 178.412)), 1, Relativity.TO_WORLD, Throttle.REPLACE_EXISTING, ThrottleReeval.DIRECTION_AND_MAGNITUDE)
    wait(2)
    eventPlayer.stopThrottleInDirection()
    eventPlayer.StopAutomaticGoTo = false
    wait(0.25)
    eventPlayer.startThrottleInDirection(directionTowards(eventPlayer, eventPlayer.CurrentGoToTarget[0]), 1, Relativity.TO_WORLD, Throttle.REPLACE_EXISTING, ThrottleReeval.DIRECTION_AND_MAGNITUDE)
    wait(2)
    if RULE_CONDITION:
        goto RULE_START


rule "LIJIANG 2 - FIX C":
    @Event eachPlayer
    @Condition distance(eventPlayer, vect(18.75, 95.425, 164.456)) <= 2.5
    @Condition getCurrentObjective() == 1
    @Condition (getCurrentMap() == Map.LIJIANG_TOWER or getCurrentMap() == Map.LIJIANG_TOWER_LNY) == true
    
    eventPlayer.StopAutomaticGoTo = true
    eventPlayer.stopThrottleInDirection()
    wait(0.25)
    eventPlayer.startThrottleInDirection(directionTowards(eventPlayer, vect(-18.532, 95.425, 164.344)), 1, Relativity.TO_WORLD, Throttle.REPLACE_EXISTING, ThrottleReeval.DIRECTION_AND_MAGNITUDE)
    wait(2)
    eventPlayer.startThrottleInDirection(directionTowards(eventPlayer, vect(-20.347, 95.425, 172.632)), 1, Relativity.TO_WORLD, Throttle.REPLACE_EXISTING, ThrottleReeval.DIRECTION_AND_MAGNITUDE)
    wait(3)
    eventPlayer.startThrottleInDirection(directionTowards(eventPlayer, vect(-7.572, 95.425, 178.509)), 1, Relativity.TO_WORLD, Throttle.REPLACE_EXISTING, ThrottleReeval.DIRECTION_AND_MAGNITUDE)
    wait(2)
    eventPlayer.stopThrottleInDirection()
    eventPlayer.StopAutomaticGoTo = false
    wait(0.25)
    eventPlayer.startThrottleInDirection(directionTowards(eventPlayer, eventPlayer.CurrentGoToTarget[0]), 1, Relativity.TO_WORLD, Throttle.REPLACE_EXISTING, ThrottleReeval.DIRECTION_AND_MAGNITUDE)
    wait(2)
    if RULE_CONDITION:
        goto RULE_START


rule "LIJIANG 2 - FIX D":
    @Event eachPlayer
    @Condition distance(eventPlayer, vect(-11.806, 95.425, 170.064)) <= 2.5
    @Condition getCurrentObjective() == 1
    @Condition (getCurrentMap() == Map.LIJIANG_TOWER or getCurrentMap() == Map.LIJIANG_TOWER_LNY) == true
    
    eventPlayer.StopAutomaticGoTo = true
    eventPlayer.stopThrottleInDirection()
    wait(0.25)
    eventPlayer.startThrottleInDirection(directionTowards(eventPlayer, vect(-12.602, 95.425, 177.652)), 1, Relativity.TO_WORLD, Throttle.REPLACE_EXISTING, ThrottleReeval.DIRECTION_AND_MAGNITUDE)
    wait(2)
    eventPlayer.startThrottleInDirection(directionTowards(eventPlayer, vect(-2.476, 95.425, 178.111)), 1, Relativity.TO_WORLD, Throttle.REPLACE_EXISTING, ThrottleReeval.DIRECTION_AND_MAGNITUDE)
    wait(2)
    eventPlayer.stopThrottleInDirection()
    eventPlayer.StopAutomaticGoTo = false
    wait(0.25)
    eventPlayer.startThrottleInDirection(directionTowards(eventPlayer, eventPlayer.CurrentGoToTarget[0]), 1, Relativity.TO_WORLD, Throttle.REPLACE_EXISTING, ThrottleReeval.DIRECTION_AND_MAGNITUDE)
    wait(2)
    if RULE_CONDITION:
        goto RULE_START


/*
rule "===== BOT FIX =====":
*/

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


rule "Fix: Illios 2 Well":
    @Event eachPlayer
    @Condition getCurrentMap() == Map.ILIOS
    @Condition getCurrentObjective() == 1
    @Condition getCurrentGamemode() == Gamemode.CONTROL
    @Condition distance(eventPlayer, getObjectivePosition(getCurrentObjective())) < 5.6
    @Condition eventPlayer.BotActive == true
    @Condition distance(eventPlayer, vect(-213.991, 1.07, -22.054)) > 2.5
    @Condition distance(eventPlayer, vect(-202.974, 1.011, -10.78)) > 2.5
    
    eventPlayer.startThrottleInDirection(directionTowards(eventPlayer, (sorted([player for player in Waypoints if isInLoS(eventPlayer, player, BarrierLos.PASS_THROUGH_BARRIERS) == true], lambda i: distance(eventPlayer, i)))[0]), 1, Relativity.TO_WORLD, Throttle.REPLACE_EXISTING, ThrottleReeval.DIRECTION_AND_MAGNITUDE)
    #wait(random.uniform(0.1, 0.5))
    #if RULE_CONDITION:
    #        goto RULE_START


rule "Fix: Oasis 3: Hole":
    @Event eachPlayer
    @Condition getCurrentMap() == Map.OASIS
    @Condition getCurrentObjective() == 2
    @Condition getCurrentGamemode() == Gamemode.CONTROL
    @Condition distance(eventPlayer, getObjectivePosition(getCurrentObjective())) < 3
    @Condition eventPlayer.BotActive == true
    
    eventPlayer.startThrottleInDirection(directionTowards(eventPlayer, (sorted([player for player in Waypoints if isInLoS(eventPlayer, player, BarrierLos.PASS_THROUGH_BARRIERS) == true], lambda i: distance(eventPlayer, i)))[0]), 1, Relativity.TO_WORLD, Throttle.REPLACE_EXISTING, ThrottleReeval.DIRECTION_AND_MAGNITUDE)
    wait(1.5)


rule "Fix: Brigitte":
    @Event eachPlayer
    @Hero brigitte
    @Condition eventPlayer.Module_001_DummyBotEnemy == true
    @Condition distance(eventPlayer, eventPlayer.CurrentTarget[0]) < 5
    
    eventPlayer.forceButtonPress(Button.PRIMARY_FIRE)
    wait(0.25)
    if RULE_CONDITION:
        goto RULE_START


rule "Fix: Reinhardt":
    @Event eachPlayer
    @Hero reinhardt
    @Condition eventPlayer.Module_001_DummyBotEnemy == true
    @Condition distance(eventPlayer, eventPlayer.CurrentTarget[0]) < 5
    
    eventPlayer.forceButtonPress(Button.PRIMARY_FIRE)
    wait(0.25)
    if RULE_CONDITION:
        goto RULE_START


rule "Fix: Orisa":
    @Event eachPlayer
    @Hero orisa
    @Condition eventPlayer.BotActive == true
    @Condition eventPlayer.CanSeeEnemy == false
    @Condition eventPlayer.isFiringPrimaryFire() == true
    
    eventPlayer.stopForcingButton(Button.PRIMARY_FIRE)
    wait(0.25)
    if RULE_CONDITION:
        goto RULE_START


rule "Fix: Widowmaker Grapple":
    @Event playerTookDamage
    @Hero widowmaker
    @Condition eventPlayer.CanSeeEnemy == true
    @Condition eventPlayer.BotActive == true
    @Condition (isGameInProgress() or getCurrentGamemode() == Gamemode.SKIRMISH) == true
    
    eventPlayer.startFacing(directionTowards(eventPlayer, vect(random.uniform(1, 100), -1, random.uniform(1, 100))), 10000, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
    wait(0.25)
    eventPlayer.forceButtonPress(Button.ABILITY_1)
    eventPlayer.startFacing(directionTowards(eventPlayer.getEyePosition(), eventPlayer.CurrentTarget.last().getEyePosition()), random.randint(200, 800), Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)


rule "Fix: Between Rounds":
    @Condition isMatchBetweenRounds() == true
    
    StartBots = 0
    ([player for player in getAllPlayers() if player.BotActive == true]).setStatusEffect(null, Status.ROOTED, 30)
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
    @Condition eventPlayer.WaypointBlacklist != [] == true
    
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


/*
rule "===== HERO AI =====":
*/

rule "Hero AI: Ana Bot - Default Enemy":
    @Event eachPlayer
    @Hero ana
    @Condition eventPlayer.Module_001_DummyBotEnemy == true
    @Condition eventPlayer.Module_007_DummyBot_SeeDamagedA == false
    
    Action_Module_012_Health()
    if eventPlayer.DealtDamage == true:
        Action_Module_001_UseAbility1()
    if eventPlayer.Module_009_HalfHealth50 == true:
        Action_Module_010_Selfuse_Start()
        Action_Module_002_UseAbility2()
        Action_Module_010_Selfuse_End()
    else:
        Action_Module_002_UseAbility2()
    if eventPlayer.CanSeeEnemy == true:
        Action_Module_006_UsePrimary_A()
    wait(eventPlayer.Bot_Waiting_Time)
    if RULE_CONDITION:
        goto RULE_START


rule "Hero AI: Ana Bot - Default Ally":
    @Event playerTookDamage
    @Hero ana
    @Condition eventPlayer.Module_007_DummyBot_SeeDamagedA == true
    
    Action_Module_012_Health()
    Action_Module_006_UsePrimary_A()
    if eventPlayer.Module_009_HalfHealth50 == true:
        Action_Module_010_Selfuse_Start()
        Action_Module_002_UseAbility2()
        Action_Module_010_Selfuse_End()
    else:
        Action_Module_002_UseAbility2()
    if eventPlayer.CurrentHealTarget[0].getNormalizedHealth() == (eventPlayer.CurrentHealTarget[0].TookDamage == true) and true:
        Action_Module_003_UseUltimate()
    Action_Module_006_UsePrimary_A()
    wait(eventPlayer.Bot_Waiting_Time)
    if RULE_CONDITION:
        goto RULE_START


rule "Hero AI: Ashe Bot - Default":
    @Event eachPlayer
    @Hero ashe
    @Condition eventPlayer.Module_001_DummyBotEnemy == true
    
    Action_Module_003_UseUltimate()
    Action_Module_009_Distance_Info()
    if eventPlayer.Module_004_MidRange10m == true:
        Action_Module_002_UseAbility2()
    if eventPlayer.Module_003_LowRange5m == true:
        Action_Module_001_UseAbility1()
    elif eventPlayer.TookDamage == true:
        Action_Module_010_Selfuse_Start()
        Action_Module_001_UseAbility1()
        Action_Module_010_Selfuse_End()
        wait(15)
    wait(eventPlayer.Bot_Waiting_Time)
    if RULE_CONDITION:
        goto RULE_START


rule "Hero AI: Ashe Bot - Shoot Logic":
    @Event eachPlayer
    @Hero ashe
    @Condition eventPlayer.Module_001_DummyBotEnemy == true
    
    Action_Module_009_Distance_Info()
    if eventPlayer.Module_003_LowRange5m == true:
        eventPlayer.stopForcingButton(Button.SECONDARY_FIRE)
        Action_Module_004_UsePrimary_B()
    else:
        Action_Module_007_UseSecondary_A()
        wait(eventPlayer.Bot_Waiting_Time)
        Action_Module_004_UsePrimary_B()
    wait(eventPlayer.Bot_Waiting_Time)
    if RULE_CONDITION:
        goto RULE_START


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


rule "Bastion use Turret":
    @Event eachPlayer
    @Hero bastion
    @Condition eventPlayer.isInAlternateForm() == true
    
    eventPlayer.BastionTurretMode = true


rule "Bastion don't use Turret":
    @Event eachPlayer
    @Hero bastion
    @Condition eventPlayer.isInAlternateForm() == false
    
    eventPlayer.BastionTurretMode = false


rule "Hero AI: Bastion Bot - Default Enemy":
    @Event eachPlayer
    @Hero bastion
    @Condition eventPlayer.Module_001_DummyBotEnemy == true
    
    eventPlayer.stopForcingButton(Button.ABILITY_2)
    if eventPlayer.getUltCharge() == 100:
        goto lbl_0
    if eventPlayer.BastionTurretMode == false and eventPlayer.isReloading() == true:
        Action_Module_001_UseAbility1()
        wait(0.5)
        if eventPlayer.BastionTurretMode == true:
            return
        else:
            goto RULE_START
    lbl_0:
    Action_Module_003_UseUltimate()
    wait(eventPlayer.Bot_Waiting_Time)
    if RULE_CONDITION:
        goto RULE_START


rule "Hero AI: Bastion Bot - Default No Enemy":
    @Event eachPlayer
    @Hero bastion
    @Condition eventPlayer.CanSeeEnemy == false
    @Condition eventPlayer.BotActive == true
    
    Action_Module_012_Health()
    if eventPlayer.Module_011_OverHealth75 == false:
        eventPlayer.startForcingButton(Button.ABILITY_2)
        wait(eventPlayer.Bot_Waiting_Time, Wait.ABORT_WHEN_FALSE)
        if RULE_CONDITION:
            goto RULE_START
    else:
        eventPlayer.stopForcingButton(Button.ABILITY_2)
    wait(3, Wait.ABORT_WHEN_FALSE)
    if eventPlayer.BastionTurretMode == true:
        Action_Module_001_UseAbility1()
    wait(eventPlayer.Bot_Waiting_Time)
    if RULE_CONDITION:
        goto RULE_START


rule "Hero AI: Brigitte Bot - Heal Allies":
    @Event eachPlayer
    @Hero brigitte
    @Condition eventPlayer.getAbilityCharge(Button.ABILITY_2) != 0
    @Condition eventPlayer.Module_007_DummyBot_SeeDamagedA == true
    
    eventPlayer.CanHeal = true
    Action_Module_002_UseAbility2()
    if eventPlayer.CurrentHealTarget[0].TookDamage == true and distance(eventPlayer, eventPlayer.CurrentHealTarget[0]) < 8 and eventPlayer.CurrentHealTarget[0].getNormalizedHealth() < 0.6:
        eventPlayer.forceButtonPress(Button.ULTIMATE)
    wait(eventPlayer.Bot_Waiting_Time)
    if RULE_CONDITION:
        goto RULE_START


rule "Hero AI: Brigitte Bot - Cant Heal":
    @Event eachPlayer
    @Hero brigitte
    @Condition eventPlayer.BotActive == true
    @Condition eventPlayer.getAbilityCharge(Button.ABILITY_2) == 0
    
    eventPlayer.CanHeal = false


rule "Hero AI: Brigitte Bot - Default":
    @Event eachPlayer
    @Hero brigitte
    @Condition eventPlayer.Module_001_DummyBotEnemy == true
    
    Action_Module_009_Distance_Info()
    Action_Module_012_Health()
    if eventPlayer.Module_003_LowRange5m == true and eventPlayer.getNormalizedHealth() >= 0.5:
        Action_Module_001_UseAbility1()
        wait(0.3)
        eventPlayer.stopForcingButton(Button.SECONDARY_FIRE)
        Action_Module_004_UsePrimary_B()
    else:
        Action_Module_007_UseSecondary_A()
    wait(eventPlayer.Bot_Waiting_Time)
    if RULE_CONDITION:
        goto RULE_START


rule "Hero AI: D.Va Bot - Default":
    @Event eachPlayer
    @Hero dva
    @Condition eventPlayer.Module_001_DummyBotEnemy == true
    
    Action_Module_012_Health()
    Action_Module_001_UseAbility1()
    if eventPlayer.Module_009_HalfHealth50 == true:
        Action_Module_003_UseUltimate()
        wait(0.25)
        if eventPlayer.getNormalizedHealth() <= 200:
            eventPlayer.stopForcingButton(Button.PRIMARY_FIRE)
            Action_Module_007_UseSecondary_A()
    else:
        Action_Module_006_UsePrimary_A()
    if eventPlayer.getMaxHealth() <= 200 and eventPlayer.Module_009_HalfHealth50 == true and eventPlayer.isFiringSecondaryFire() == false:
        Action_Module_006_UsePrimary_A()
    if eventPlayer.isFiringSecondaryFire() == false and eventPlayer.isUsingAbility1() == false:
        Action_Module_002_UseAbility2()
    wait(eventPlayer.Bot_Waiting_Time)
    if RULE_CONDITION:
        goto RULE_START


rule "Hero AI: Doomfist Bot - Default":
    @Event eachPlayer
    @Hero doomfist
    @Condition eventPlayer.Module_001_DummyBotEnemy == true
    
    if eventPlayer.getUltCharge() == 100 and eventPlayer.DealtDamage == true:
        Action_Module_003_UseUltimate()
    if distance(eventPlayer, eventPlayer.CurrentTarget[0]) <= 1 and eventPlayer.isUsingUltimate() == true:
        Action_Module_004_UsePrimary_B()
    if eventPlayer.isUsingUltimate() == false:
        Action_Module_011_StartAction()
        Action_Module_009_Distance_Info()
        if eventPlayer.Module_006_HighRange20m == true:
            Action_Module_007_UseSecondary_A()
            Action_Module_008_UseSecondary_S()
            Action_Module_001_UseAbility1()
            Action_Module_013_Ability1_S()
        if eventPlayer.Module_003_LowRange5m == true:
            Action_Module_002_UseAbility2()
            Action_Module_014_Ability2_S()
            Action_Module_005_UseSecondary_B()
            Action_Module_008_UseSecondary_S()
            Action_Module_001_UseAbility1()
            Action_Module_013_Ability1_S()
        if eventPlayer.Module_004_MidRange10m == true:
            Action_Module_001_UseAbility1()
            Action_Module_013_Ability1_S()
        if eventPlayer.Module_005_LongRange15m == true:
            Action_Module_007_UseSecondary_A()
            Action_Module_008_UseSecondary_S()
            Action_Module_002_UseAbility2()
            Action_Module_014_Ability2_S()
            Action_Module_001_UseAbility1()
            Action_Module_013_Ability1_S()
        if eventPlayer.isUsingAbility1() == false and eventPlayer.isUsingAbility2() == false and eventPlayer.isFiringSecondaryFire() == false:
            Action_Module_004_UsePrimary_B()
    else:
        Action_Module_016_Chase_Ult()
    wait(eventPlayer.Bot_Waiting_Time)
    if RULE_CONDITION:
        goto RULE_START


rule "Hero AI: Genji Bot - Default":
    @Event eachPlayer
    @Hero genji
    @Condition eventPlayer.Module_001_DummyBotEnemy == true
    
    Action_Module_009_Distance_Info()
    Action_Module_012_Health()
    if eventPlayer.Module_004_MidRange10m == true and eventPlayer.Module_011_OverHealth75 == true and eventPlayer.DealtDamage == true:
        eventPlayer.forceButtonPress(Button.ULTIMATE)
    if eventPlayer.isInAir() == true:
        eventPlayer.forceButtonPress(Button.JUMP)
        wait(0.25)
        eventPlayer.startForcingButton(Button.JUMP)
    else:
        eventPlayer.stopForcingButton(Button.JUMP)
    if eventPlayer.isUsingUltimate() == true:
        Action_Module_016_Chase_Ult()
    if eventPlayer.Module_010_HighHealth75 == true and eventPlayer.TookDamage == true:
        Action_Module_002_UseAbility2()
        Action_Module_014_Ability2_S()
    if distance(eventPlayer, eventPlayer.CurrentTarget[0]) <= 15 and eventPlayer.CurrentTarget[0].getHealth() <= 50:
        Action_Module_001_UseAbility1()
    wait(eventPlayer.Bot_Waiting_Time)
    if RULE_CONDITION:
        goto RULE_START


rule "Hero AI: Genji Bot - Shoot Logic":
    @Event eachPlayer
    @Hero genji
    @Condition eventPlayer.CanSeeEnemy == true
    @Condition eventPlayer.BotActive == true
    
    if distance(eventPlayer, eventPlayer.CurrentTarget[0]) <= 6:
        if eventPlayer.isUsingUltimate() == true:
            Action_Module_004_UsePrimary_B()
        else:
            Action_Module_005_UseSecondary_B()
    else:
        Action_Module_004_UsePrimary_B()
    wait(eventPlayer.Bot_Waiting_Time)
    if RULE_CONDITION:
        goto RULE_START


rule "Hero AI: Hanzo Bot - Default":
    @Event eachPlayer
    @Hero hanzo
    @Condition eventPlayer.Module_001_DummyBotEnemy == true
    
    Action_Module_002_UseAbility2()
    if eventPlayer.isInAir() == true:
        eventPlayer.forceButtonPress(Button.JUMP)
        wait(0.25)
        eventPlayer.startForcingButton(Button.JUMP)
    else:
        eventPlayer.stopForcingButton(Button.JUMP)
    if eventPlayer.isUsingAbility1() == false and eventPlayer.isUsingAbility2() == false:
        Action_Module_001_UseAbility1()
    wait(eventPlayer.Bot_Waiting_Time)
    if RULE_CONDITION:
        goto RULE_START


rule "Hero AI: Hanzo Bot - Shoot Logic":
    @Event eachPlayer
    @Hero hanzo
    @Condition eventPlayer.Module_001_DummyBotEnemy == true
    
    if eventPlayer.isUsingAbility2() == true:
        Action_Module_004_UsePrimary_B()
    else:
        Action_Module_006_UsePrimary_A()
        wait(1.2)
        eventPlayer.stopForcingButton(Button.PRIMARY_FIRE)
    wait(eventPlayer.Bot_Waiting_Time)
    if RULE_CONDITION:
        goto RULE_START


rule "Hero AI: Hanzo Bot - Use Ult / No Zarya in team":
    @Event eachPlayer
    @Hero hanzo
    @Condition eventPlayer.BotActive == true
    @Condition StartBots == true
    @Condition eventPlayer.StopFacing == false
    @Condition getNumberOfPlayersOnObjective(Team.ALL) >= 3
    @Condition eventPlayer.getUltCharge() == 100
    @Condition getPlayersOnHero(Hero.ZARYA, eventPlayer.getTeam()) == []
    
    eventPlayer.StopFacing = true
    wait(0.25)
    eventPlayer.startFacing(directionTowards(eventPlayer.getEyePosition(), getObjectivePosition(getCurrentObjective())), 10000, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
    wait(0.25)
    eventPlayer.forceButtonPress(Button.ULTIMATE)
    wait(1.5)
    eventPlayer.StopFacing = false


rule "Hero AI: Hanzo Bot - Ult Combo":
    @Event eachPlayer
    @Hero hanzo
    @Condition eventPlayer.BotActive == true
    @Condition ([player for player in getPlayersOnHero(Hero.ZARYA, eventPlayer.getTeam()) if eventPlayer.isDummy() == true]).isUsingUltimate() == true
    @Condition eventPlayer.getUltCharge() == 100
    @Condition eventPlayer.StopFacing == false
    @Condition eventPlayer.hasStatusEffect(Status.HACKED) == false
    
    eventPlayer.StopFacing = true
    wait(0.25)
    eventPlayer.startFacing(directionTowards(eventPlayer.getEyePosition(), getObjectivePosition(getCurrentObjective())), 10000, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
    wait(0.25)
    eventPlayer.forceButtonPress(Button.ULTIMATE)
    wait(1.5)
    eventPlayer.StopFacing = false


rule "Hero AI: Hanzo Bot - Ult Combo 2":
    @Event eachPlayer
    @Hero hanzo
    @Condition eventPlayer.BotActive == true
    @Condition getPlayersOnHero(Hero.ZARYA, eventPlayer.getTeam()).isUsingUltimate() == true
    @Condition eventPlayer.getUltCharge() == 100
    @Condition eventPlayer.StopFacing == false
    @Condition eventPlayer.hasStatusEffect(Status.HACKED) == false
    @Condition [player for player in getPlayers(eventPlayer.getTeam()) if player.ZaryaUlt != true] == [] == true
    
    eventPlayer.StopFacing = true
    wait(0.25)
    eventPlayer.startFacing(directionTowards(eventPlayer.getEyePosition(), ((sorted([player for player in getPlayers(eventPlayer.getTeam()) if player.ZaryaUlt == true], lambda i: distance(eventPlayer, i)))[0]).CurrentTarget), 10000, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
    wait(0.25)
    eventPlayer.forceButtonPress(Button.ULTIMATE)
    wait(1.5)
    eventPlayer.StopFacing = false


rule "Hero AI: Junkrat Bot - Default":
    @Event eachPlayer
    @Hero junkrat
    @Condition eventPlayer.Module_001_DummyBotEnemy == true
    
    Action_Module_012_Health()
    if eventPlayer.isOnObjective() == true:
        Action_Module_002_UseAbility2()
    if eventPlayer.TookDamage and eventPlayer.Module_009_HalfHealth50 == true:
        Action_Module_010_Selfuse_Start()
        Action_Module_001_UseAbility1()
        wait(0.25)
        Action_Module_005_UseSecondary_B()
        Action_Module_010_Selfuse_End()
        wait(8)
    if eventPlayer.getUltCharge() == 100:
        eventPlayer.forceButtonPress(Button.ULTIMATE)
        wait(1)
        wait(0.083 * distance(eventPlayer, eventPlayer.CurrentTarget[0]))
        eventPlayer.forceButtonPress(Button.PRIMARY_FIRE)
    if eventPlayer.DealtDamage == true:
        Action_Module_005_UseSecondary_B()
        wait(0.25)
        Action_Module_001_UseAbility1()
    if eventPlayer.isUsingUltimate() == false:
        Action_Module_004_UsePrimary_B()
    wait(eventPlayer.Bot_Waiting_Time)
    if RULE_CONDITION:
        goto RULE_START


rule "Hero AI: Lucio Bot - Default":
    @Event eachPlayer
    @Hero lucio
    @Condition eventPlayer.Module_002_DummyBot == true
    
    if eventPlayer.getNormalizedHealth() < 0.5:
        Action_Module_003_UseUltimate()
    if eventPlayer.isInAir() == true:
        eventPlayer.forceButtonPress(Button.JUMP)
        wait(0.25)
        eventPlayer.startForcingButton(Button.JUMP)
    else:
        eventPlayer.stopForcingButton(Button.JUMP)
    if eventPlayer.CanSeeDamagedAlly == true and distance(eventPlayer, eventPlayer.CurrentHealTarget) <= 15:
        Action_Module_001_UseAbility1()
        if eventPlayer.isUsingAbility1() == false:
            goto lbl_0
        eventPlayer.LucioAuraMode = 2
        lbl_0:
    elif eventPlayer.LucioAuraMode == 2:
        Action_Module_001_UseAbility1()
        if eventPlayer.isUsingAbility1() == false:
            goto lbl_1
        eventPlayer.LucioAuraMode = 1
        lbl_1:
    if eventPlayer.isOnObjective() == false and eventPlayer.isInSpawnRoom() == false and eventPlayer.isMoving() == true and eventPlayer.LucioAuraMode == 1:
        Action_Module_002_UseAbility2()
    if eventPlayer.CanSeeDamagedAlly == true:
        if eventPlayer.CurrentHealTarget[0].getNormalizedHealth() <= 0.6:
            Action_Module_002_UseAbility2()
    if eventPlayer.CanSeeEnemy == true:
        Action_Module_006_UsePrimary_A()
    wait(eventPlayer.Bot_Waiting_Time)
    if RULE_CONDITION:
        goto RULE_START


rule "Hero AI: Mccree Bot - Default":
    @Event eachPlayer
    @Hero mccree
    @Condition eventPlayer.Module_001_DummyBotEnemy == true
    
    Action_Module_012_Health()
    Action_Module_009_Distance_Info()
    if eventPlayer.getUltCharge() == 100 and distance(eventPlayer, eventPlayer.CurrentTarget[0]) >= 12:
        eventPlayer.forceButtonPress(Button.ULTIMATE)
    if eventPlayer.Module_003_LowRange5m == true:
        Action_Module_002_UseAbility2()
        if eventPlayer.isUsingAbility2() == true:
            Action_Module_005_UseSecondary_B()
            if eventPlayer.isFiringSecondaryFire() == true:
                Action_Module_017_Sec_S()
                Action_Module_001_UseAbility1()
    if eventPlayer.Module_009_HalfHealth50 == true and eventPlayer.TookDamage == true:
        Action_Module_001_UseAbility1()
        Action_Module_013_Ability1_S()
    if eventPlayer.isUsingUltimate() == true:
        wait(random.uniform(3, 4.5))
        eventPlayer.forceButtonPress(Button.PRIMARY_FIRE)
    Action_Module_004_UsePrimary_B()
    wait(eventPlayer.Bot_Waiting_Time)
    if RULE_CONDITION:
        goto RULE_START


rule "Hero AI: Mei Bot - Default":
    @Event eachPlayer
    @Hero mei
    @Condition eventPlayer.Module_001_DummyBotEnemy == true
    
    Action_Module_012_Health()
    if eventPlayer.Module_009_HalfHealth50 == true:
        eventPlayer.forceButtonPress(Button.ABILITY_1)
        if eventPlayer.isUsingAbility1() == false:
            Action_Module_010_Selfuse_Start()
            Action_Module_002_UseAbility2()
            wait(0.25)
            Action_Module_004_UsePrimary_B()
            Action_Module_010_Selfuse_End()
        Action_Module_013_Ability1_S()
    if eventPlayer.getUltCharge() == 100 and eventPlayer.Module_004_MidRange10m == true:
        eventPlayer.forceButtonPress(Button.ULTIMATE)
    wait(eventPlayer.Bot_Waiting_Time)
    if RULE_CONDITION:
        goto RULE_START


rule "Hero AI: Mercy Bot - Default":
    @Event eachPlayer
    @Hero mercy
    @Condition eventPlayer.Module_002_DummyBot == true
    
    if eventPlayer.isFiringPrimaryFire() == false and eventPlayer.isFiringSecondaryFire() == false:
        eventPlayer.startForcingButton(Button.ABILITY_1)
    else:
        eventPlayer.stopForcingButton(Button.ABILITY_1)
    if eventPlayer.CanSeeEnemy and eventPlayer.CanSeeDamagedAlly == true:
        eventPlayer.forceButtonPress(Button.ULTIMATE)
    if eventPlayer.isUsingUltimate() == true:
        eventPlayer.startForcingButton(Button.JUMP)
    else:
        if eventPlayer.isInAir() == true and eventPlayer.getNormalizedHealth() > 0.6:
            eventPlayer.startForcingButton(Button.JUMP)
        else:
            eventPlayer.stopForcingButton(Button.JUMP)
    if eventPlayer.CanSeeDamagedAlly == false and eventPlayer.CanSeeAlly == false:
        Action_Module_011_StartAction()
        eventPlayer.StopAutomaticGoTo = false
        if eventPlayer.isOnObjective() == true:
            eventPlayer.startFacing(directionTowards(eventPlayer.getEyePosition(), eventPlayer.CurrentVisibleWaypoints[0]), 200, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
        else:
            eventPlayer.startFacing(directionTowards(eventPlayer.getEyePosition(), eventPlayer.RandomFacingDirection[0]), random.uniform(300, 600), Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
    wait(eventPlayer.Bot_Waiting_Time)
    if RULE_CONDITION:
        goto RULE_START


rule "Hero AI: Mercy Bot - Damaged Ally":
    @Event eachPlayer
    @Hero mercy
    @Condition eventPlayer.Module_007_DummyBot_SeeDamagedA == true
    @Condition eventPlayer.CanSeeDeadAlly == false
    @Condition (eventPlayer.CanSeeDeadAlly == false and eventPlayer.Mercy_Rez == true or eventPlayer.Mercy_Rez == false) == true
    
    eventPlayer.startFacing(directionTowards(eventPlayer.getEyePosition(), eventPlayer.CurrentHealTarget[0].getEyePosition()), 200, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
    eventPlayer.StopAutomaticGoTo = true
    Action_Module_011_StopAction()
    if distance(eventPlayer, eventPlayer.CurrentHealTarget[0]) > 1.5:
        eventPlayer.startThrottleInDirection(directionTowards(eventPlayer, eventPlayer.CurrentHealTarget[0]), 1, Relativity.TO_WORLD, Throttle.REPLACE_EXISTING, ThrottleReeval.DIRECTION_AND_MAGNITUDE)
    else:
        eventPlayer.stopThrottleInDirection()
    if distance(eventPlayer, eventPlayer.CurrentHealTarget[0]) > 7:
        eventPlayer.stopForcingButton(Button.PRIMARY_FIRE)
    else:
        eventPlayer.stopForcingButton(Button.SECONDARY_FIRE)
        Action_Module_006_UsePrimary_A()
    wait(eventPlayer.Bot_Waiting_Time)
    if RULE_CONDITION:
        goto RULE_START


rule "Hero AI: Mercy Bot - Ally":
    @Event eachPlayer
    @Hero mercy
    @Condition eventPlayer.Module_007_DummyBot_SeeDamagedA == false
    @Condition eventPlayer.Module_012_DummyBotAlly == true
    @Condition (eventPlayer.CanSeeDeadAlly == false and eventPlayer.Mercy_Rez == true or eventPlayer.Mercy_Rez == false) == true
    
    eventPlayer.startFacing(directionTowards(eventPlayer.getEyePosition(), eventPlayer.CurrentAllyTarget[0].getEyePosition()), 200, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
    eventPlayer.StopAutomaticGoTo = true
    Action_Module_011_StopAction()
    if distance(eventPlayer, eventPlayer.CurrentAllyTarget[0]) > 1.5:
        eventPlayer.startThrottleInDirection(directionTowards(eventPlayer, eventPlayer.CurrentAllyTarget[0]), 1, Relativity.TO_WORLD, Throttle.REPLACE_EXISTING, ThrottleReeval.DIRECTION_AND_MAGNITUDE)
    else:
        eventPlayer.stopThrottleInDirection()
    if distance(eventPlayer, eventPlayer.CurrentAllyTarget[0]) > 7:
        eventPlayer.stopForcingButton(Button.SECONDARY_FIRE)
    else:
        eventPlayer.stopForcingButton(Button.PRIMARY_FIRE)
        Action_Module_007_UseSecondary_A()
    wait(eventPlayer.Bot_Waiting_Time)
    if RULE_CONDITION:
        goto RULE_START


rule "Hero AI: Mercy Bot - Revive":
    @Event eachPlayer
    @Hero mercy
    @Condition eventPlayer.Module_002_DummyBot == true
    @Condition eventPlayer.CanSeeDeadAlly == true
    @Condition eventPlayer.isAlive() == true
    @Condition eventPlayer.Mercy_Rez == true
    
    Action_Module_011_StartAction()
    eventPlayer.StopAutomaticGoTo = true
    eventPlayer.startFacing(directionTowards(eventPlayer.getEyePosition(), eventPlayer.CurrentDeadAlly[0].getEyePosition()), 200, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
    if distance(eventPlayer, eventPlayer.CurrentDeadAlly[0]) > 1:
        eventPlayer.startThrottleInDirection(directionTowards(eventPlayer, eventPlayer.CurrentDeadAlly[0]), 1, Relativity.TO_WORLD, Throttle.REPLACE_EXISTING, ThrottleReeval.DIRECTION_AND_MAGNITUDE)
    else:
        eventPlayer.stopThrottleInDirection()
        eventPlayer.startForcingButton(Button.ABILITY_2)
        Action_Module_014_Ability2_S()
    eventPlayer.Mercy_Rez = false
    wait(25)
    eventPlayer.Mercy_Rez = true
    wait(eventPlayer.Bot_Waiting_Time)
    if RULE_CONDITION:
        goto RULE_START


rule "Hero AI: Mei Bot - Shoot Logic":
    @Event eachPlayer
    @Hero mei
    @Condition eventPlayer.Module_001_DummyBotEnemy == true
    
    if distance(eventPlayer, eventPlayer.CurrentTarget[0]) < 6:
        if eventPlayer.CurrentTarget[0].hasStatusEffect(Status.FROZEN) == true:
            eventPlayer.forceButtonPress(Button.SECONDARY_FIRE)
        else:
            Action_Module_006_UsePrimary_A()
    else:
        eventPlayer.stopForcingButton(Button.PRIMARY_FIRE)
        eventPlayer.forceButtonPress(Button.SECONDARY_FIRE)
    wait(eventPlayer.Bot_Waiting_Time)
    if RULE_CONDITION:
        goto RULE_START


rule "Hero AI: Moira Bot - Default":
    @Event eachPlayer
    @Hero moira
    @Condition eventPlayer.Module_002_DummyBot == true
    
    if eventPlayer.isUsingUltimate() == true:
        eventPlayer.CanHeal = true
    if eventPlayer.TookDamage == true:
        Action_Module_001_UseAbility1()
    wait(eventPlayer.Bot_Waiting_Time)
    if RULE_CONDITION:
        goto RULE_START


rule "Hero AI: Moira Bot - Enemy":
    @Event eachPlayer
    @Hero moira
    @Condition eventPlayer.Module_001_DummyBotEnemy == true
    
    if eventPlayer.isUsingUltimate() == false:
        eventPlayer.CanHeal = false
    if eventPlayer.getUltCharge() == 100:
        Action_Module_003_UseUltimate()
    Action_Module_009_Distance_Info()
    if eventPlayer.Module_004_MidRange10m == true:
        eventPlayer.stopForcingButton(Button.PRIMARY_FIRE)
        Action_Module_007_UseSecondary_A()
    else:
        eventPlayer.stopForcingButton(Button.SECONDARY_FIRE)
    if eventPlayer.MoiraOrbReady == true:
        Action_Module_002_UseAbility2()
        wait(0.25)
        eventPlayer.forceButtonPress(Button.SECONDARY_FIRE)
    wait(eventPlayer.Bot_Waiting_Time)
    if RULE_CONDITION:
        goto RULE_START


rule "Hero AI: Moira Bot - Ally":
    @Event eachPlayer
    @Hero moira
    @Condition eventPlayer.Module_007_DummyBot_SeeDamagedA == true
    @Condition eventPlayer.CanSeeEnemy == false
    
    eventPlayer.CanHeal = true
    Action_Module_009_Distance_Info()
    if eventPlayer.Module_004_MidRange10m == true:
        eventPlayer.stopForcingButton(Button.SECONDARY_FIRE)
        eventPlayer.startForcingButton(Button.PRIMARY_FIRE)
    else:
        eventPlayer.stopForcingButton(Button.PRIMARY_FIRE)
    if eventPlayer.MoiraOrbReady == true:
        Action_Module_002_UseAbility2()
        wait(0.25)
        eventPlayer.forceButtonPress(Button.PRIMARY_FIRE)
    wait(eventPlayer.Bot_Waiting_Time)
    if RULE_CONDITION:
        goto RULE_START


rule "Hero AI: Moira Bot - Orb CD":
    @Event eachPlayer
    @Hero moira
    @Condition eventPlayer.MoiraOrbReady == false
    
    wait(15)
    eventPlayer.MoiraOrbReady = true
    if RULE_CONDITION:
        goto RULE_START


rule "Hero AI: Orisa Bot - Deafult":
    @Event eachPlayer
    @Hero orisa
    @Condition eventPlayer.Module_001_DummyBotEnemy == true
    
    if eventPlayer.TookDamage == true:
        Action_Module_002_UseAbility2()
    if eventPlayer.isUsingAbility2() == true:
        eventPlayer.stopForcingButton(Button.PRIMARY_FIRE)
        wait(0.083 * distance(eventPlayer, eventPlayer.CurrentTarget[0]))
        eventPlayer.forceButtonPress(Button.PRIMARY_FIRE)
    else:
        Action_Module_001_UseAbility1()
        Action_Module_005_UseSecondary_B()
        if eventPlayer.DealtDamage == true:
            Action_Module_003_UseUltimate()
        eventPlayer.startForcingButton(Button.PRIMARY_FIRE)
    wait(eventPlayer.Bot_Waiting_Time)
    if RULE_CONDITION:
        goto RULE_START


rule "Hero AI: Pharah Bot - Deafult":
    @Event eachPlayer
    @Hero pharah
    @Condition eventPlayer.Module_001_DummyBotEnemy == true
    
    Action_Module_001_UseAbility1()
    wait(1.3, Wait.ABORT_WHEN_FALSE)
    Action_Module_002_UseAbility2()
    if eventPlayer.isInAir() == false:
        goto lbl_0
    eventPlayer.forceButtonPress(Button.ULTIMATE)
    lbl_0:
    Action_Module_004_UsePrimary_B()
    wait(eventPlayer.Bot_Waiting_Time)
    if RULE_CONDITION:
        goto RULE_START


rule "Hero AI: Pharah Bot - Fly":
    @Event eachPlayer
    @Hero pharah
    @Condition eventPlayer.getNormalizedHealth() > 0.4
    @Condition eventPlayer.isInAir() == true
    @Condition eventPlayer.Module_001_DummyBotEnemy == true
    
    eventPlayer.startForcingButton(Button.JUMP)


rule "Hero AI: Pharah Bot - Stop Fly on Low Health":
    @Event eachPlayer
    @Hero pharah
    @Condition StartBots == true
    @Condition eventPlayer.BotActive == true
    @Condition eventPlayer.getNormalizedHealth() <= 0.4
    @Condition eventPlayer.isHoldingButton(Button.JUMP) == true
    
    eventPlayer.stopForcingButton(Button.JUMP)


rule "Hero AI: Pharah Bot - Stop Fly if on Ground":
    @Event eachPlayer
    @Hero pharah
    @Condition StartBots == true
    @Condition eventPlayer.BotActive == true
    @Condition eventPlayer.isHoldingButton(Button.JUMP) == true
    @Condition eventPlayer.isInAir() == false
    
    eventPlayer.stopForcingButton(Button.JUMP)


rule "Hero AI: Reaper Bot - Default":
    @Event eachPlayer
    @Hero reaper
    @Condition eventPlayer.Module_001_DummyBotEnemy == true
    
    Action_Module_009_Distance_Info()
    Action_Module_012_Health()
    if eventPlayer.Module_003_LowRange5m == true:
        Action_Module_003_UseUltimate()
    if eventPlayer.isUsingAbility1() == false and eventPlayer.isUsingAbility2() == false:
        eventPlayer.forceButtonPress(Button.PRIMARY_FIRE)
    if eventPlayer.TookDamage == eventPlayer.Module_009_HalfHealth50 and true:
        Action_Module_001_UseAbility1()
    if eventPlayer.Module_006_HighRange20m == true:
        Action_Module_002_UseAbility2()
        if eventPlayer.isUsingAbility2() == true:
            eventPlayer.forceButtonPress(Button.PRIMARY_FIRE)
    wait(eventPlayer.Bot_Waiting_Time)
    if RULE_CONDITION:
        goto RULE_START


rule "Hero AI: Reinhardt Bot - Default":
    @Event eachPlayer
    @Hero reinhardt
    @Condition eventPlayer.Module_001_DummyBotEnemy == true
    
    Action_Module_002_UseAbility2()
    Action_Module_009_Distance_Info()
    Action_Module_012_Health()
    if eventPlayer.Module_004_MidRange10m == true:
        Action_Module_003_UseUltimate()
    if eventPlayer.Module_003_LowRange5m == true and eventPlayer.getNormalizedHealth() >= 0.5:
        Action_Module_001_UseAbility1()
        wait(0.3)
        eventPlayer.stopForcingButton(Button.SECONDARY_FIRE)
        Action_Module_004_UsePrimary_B()
    else:
        Action_Module_007_UseSecondary_A()
    Action_Module_004_UsePrimary_B()
    wait(eventPlayer.Bot_Waiting_Time)
    if RULE_CONDITION:
        goto RULE_START


rule "Hero AI: Roadhog Bot - Shoot Logic":
    @Event eachPlayer
    @Hero roadhog
    @Condition eventPlayer.Module_001_DummyBotEnemy == true
    
    if distance(eventPlayer, eventPlayer.CurrentTarget[0]) < 6:
        Action_Module_004_UsePrimary_B()
    else:
        Action_Module_005_UseSecondary_B()
    wait(eventPlayer.Bot_Waiting_Time)
    if RULE_CONDITION:
        goto RULE_START


rule "Hero AI: Roadhog Bot - Default":
    @Event eachPlayer
    @Hero roadhog
    @Condition eventPlayer.Module_001_DummyBotEnemy == true
    
    Action_Module_012_Health()
    Action_Module_009_Distance_Info()
    if eventPlayer.Module_009_HalfHealth50 == true:
        Action_Module_002_UseAbility2()
    if eventPlayer.Module_005_LongRange15m == true:
        Action_Module_001_UseAbility1()
    if eventPlayer.Module_003_LowRange5m == true:
        Action_Module_003_UseUltimate()
    wait(eventPlayer.Bot_Waiting_Time)
    if RULE_CONDITION:
        goto RULE_START


rule "Hero AI: Sigma Bot - Default":
    @Event eachPlayer
    @Hero sigma
    @Condition eventPlayer.Module_001_DummyBotEnemy == true
    
    if eventPlayer.isFiringSecondaryFire() == false:
        Action_Module_005_UseSecondary_B()
        wait(eventPlayer.Bot_Waiting_Time)
        if eventPlayer.isFiringSecondaryFire() == true:
            eventPlayer.setStatusEffect(null, Status.ROOTED, 5)
    Action_Module_012_Health()
    if eventPlayer.TookDamage == true and eventPlayer.Module_009_HalfHealth50 == true:
        eventPlayer.startForcingButton(Button.ABILITY_1)
        if eventPlayer.isUsingAbility1() == true:
            wait(random.uniform(3, 5))
            eventPlayer.stopForcingButton(Button.ABILITY_1)
    if eventPlayer.getUltCharge() == 100:
        Action_Module_003_UseUltimate()
    if eventPlayer.isUsingUltimate() == true:
        eventPlayer.stopForcingButton(Button.PRIMARY_FIRE)
        eventPlayer.startForcingButton(Button.JUMP)
        wait(2)
        eventPlayer.forceButtonPress(Button.PRIMARY_FIRE)
    else:
        eventPlayer.forceButtonPress(Button.ABILITY_2)
        eventPlayer.forceButtonPress(Button.PRIMARY_FIRE)
    wait(eventPlayer.Bot_Waiting_Time)
    if RULE_CONDITION:
        goto RULE_START


rule "Hero AI: Soldier: 76 Bot - Default":
    @Event eachPlayer
    @Hero soldier
    @Condition eventPlayer.Module_002_DummyBot == true
    
    if eventPlayer.CanSeeEnemy == true:
        Action_Module_005_UseSecondary_B()
        eventPlayer.forceButtonPress(Button.ULTIMATE)
    if eventPlayer.TookDamage == true:
        Action_Module_002_UseAbility2()
    if eventPlayer.isUsingAbility2() == true:
        Action_Module_018_Hold_POS()
        #eventPlayer.setStatusEffect(null, Status.ROOTED, 2)
    if eventPlayer.isOnObjective() == false and eventPlayer.isMoving() == true:
        if eventPlayer.isUsingAbility1() == true:
            goto lbl_0
        eventPlayer.startForcingButton(Button.ABILITY_1)
        lbl_0:
    else:
        eventPlayer.stopForcingButton(Button.ABILITY_1)
    wait(eventPlayer.Bot_Waiting_Time)
    if RULE_CONDITION:
        goto RULE_START


rule "Hero AI: Sombra Bot - Hack Healthpack":
    @Event eachPlayer
    @Hero sombra
    @Condition eventPlayer.CurrentHealthpack != []
    @Condition distance(eventPlayer, eventPlayer.CurrentHealthpack[0]) <= 7.777
    @Condition eventPlayer.Module_001_DummyBotEnemy == true
    
    eventPlayer.setStatusEffect(null, Status.ROOTED, 3.5)
    eventPlayer.StopFacing = true
    wait(0.5)
    eventPlayer.startFacing(directionTowards(eventPlayer.getEyePosition(), eventPlayer.CurrentHealthpack[0]), 1000, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
    eventPlayer.startForcingButton(Button.SECONDARY_FIRE)
    wait(3.5)
    eventPlayer.stopForcingButton(Button.SECONDARY_FIRE)
    eventPlayer.StopFacing = false
    wait(6)


rule "Hero AI: Sombra Bot - See Healthpack":
    @Event eachPlayer
    @Condition eventPlayer.BotActive == true
    
    eventPlayer.CurrentHealthpack = sorted([player for player in HealthpackLocations if isInLoS(eventPlayer, player, BarrierLos.PASS_THROUGH_BARRIERS) == true], lambda i: distance(eventPlayer, i))
    wait(random.uniform(0.1, 0.3))
    goto RULE_START


rule "Hero AI: Sombra Bot - Stealth":
    @Event eachPlayer
    @Hero sombra
    @Condition eventPlayer.Stealth == false
    @Condition eventPlayer.Module_001_DummyBotEnemy == true
    
    eventPlayer.forceButtonPress(Button.ABILITY_1)


rule "Hero AI: Sombra Bot - Teleport 1":
    @Event eachPlayer
    @Hero sombra
    @Condition eventPlayer.Stealth == false
    @Condition eventPlayer.isUsingAbility2() == false
    @Condition eventPlayer.Module_001_DummyBotEnemy == true
    
    eventPlayer.forceButtonPress(Button.ABILITY_2)


rule "Hero AI: Sombra Bot - Teleport 2":
    @Event eachPlayer
    @Hero sombra
    @Condition eventPlayer.isUsingAbility2() == true
    @Condition eventPlayer.getNormalizedHealth() <= 0.6
    @Condition eventPlayer.Module_001_DummyBotEnemy == true
    
    eventPlayer.forceButtonPress(Button.ABILITY_2)


rule "Hero AI: Sombra Bot - Hack Enemies":
    @Event eachPlayer
    @Hero sombra
    @Condition eventPlayer.Stealth == true
    @Condition eventPlayer.Module_001_DummyBotEnemy == true
    
    eventPlayer.startForcingButton(Button.SECONDARY_FIRE)
    wait(2)
    eventPlayer.stopForcingButton(Button.SECONDARY_FIRE)
    wait(15)


rule "Hero AI: Sombra Bot - Ultimate":
    @Event eachPlayer
    @Hero sombra
    @Condition eventPlayer.getUltCharge() == 100
    @Condition distance(eventPlayer, eventPlayer.CurrentTarget) <= 7.777
    @Condition eventPlayer.Module_001_DummyBotEnemy == true
    
    eventPlayer.forceButtonPress(Button.ULTIMATE)


rule "Hero AI: Sombra Bot - Shoot (with stealth)":
    @Event eachPlayer
    @Hero sombra
    @Condition eventPlayer.Stealth == true
    @Condition distance(eventPlayer, eventPlayer.CurrentTarget) <= 7
    @Condition eventPlayer.Module_001_DummyBotEnemy == true
    
    eventPlayer.startForcingButton(Button.PRIMARY_FIRE)


rule "Hero AI: Sombra Bot - Shoot (without stealth)":
    @Event eachPlayer
    @Hero sombra
    @Condition eventPlayer.Stealth == false
    @Condition eventPlayer.Module_001_DummyBotEnemy == true
    
    eventPlayer.startForcingButton(Button.PRIMARY_FIRE)


rule "Hero AI: Symmetra Bot - Default":
    @Event eachPlayer
    @Hero symmetra
    @Condition eventPlayer.Module_001_DummyBotEnemy == true
    
    Action_Module_002_UseAbility2()
    if eventPlayer.isUsingAbility2() == true:
        eventPlayer.forceButtonPress(Button.PRIMARY_FIRE)
    if eventPlayer.TookDamage == true:
        eventPlayer.forceButtonPress(Button.ULTIMATE)
    if eventPlayer.isUsingUltimate() == true:
        eventPlayer.forceButtonPress(Button.PRIMARY_FIRE)
    wait(eventPlayer.Bot_Waiting_Time)
    if RULE_CONDITION:
        goto RULE_START


rule "Hero AI: Symmetra Bot - Shoot":
    @Event eachPlayer
    @Hero symmetra
    @Condition eventPlayer.Module_001_DummyBotEnemy == true
    
    if distance(eventPlayer, eventPlayer.CurrentTarget[0]) < 6:
        Action_Module_006_UsePrimary_A()
    else:
        eventPlayer.stopForcingButton(Button.PRIMARY_FIRE)
        Action_Module_007_UseSecondary_A()
        wait(2.5)
        eventPlayer.stopForcingButton(Button.SECONDARY_FIRE)
    wait(eventPlayer.Bot_Waiting_Time)
    if RULE_CONDITION:
        goto RULE_START


rule "Hero AI: Torbjörn Bot - Default":
    @Event eachPlayer
    @Hero torbjorn
    @Condition eventPlayer.Module_001_DummyBotEnemy == true
    
    Action_Module_001_UseAbility1()
    if eventPlayer.TookDamage == true:
        Action_Module_002_UseAbility2()
    if eventPlayer.DealtDamage == true:
        Action_Module_003_UseUltimate()
    wait(eventPlayer.Bot_Waiting_Time)
    if RULE_CONDITION:
        goto RULE_START


rule "Hero AI: Torbjörn Bot - Destroy Turret (Count for Human too)":
    @Event eachPlayer
    @Hero torbjorn
    @Condition eventPlayer.isUsingAbility1() == true
    
    wait(random.randint(4, 8))
    eventPlayer.forceButtonPress(Button.CROUCH)


rule "Hero AI: Torbjörn Bot - Shoot Logic":
    @Event eachPlayer
    @Hero torbjorn
    @Condition eventPlayer.Module_001_DummyBotEnemy == true
    
    if distance(eventPlayer, eventPlayer.CurrentTarget[0]) < 6:
        Action_Module_005_UseSecondary_B()
    else:
        Action_Module_004_UsePrimary_B()
    wait(eventPlayer.Bot_Waiting_Time)
    if RULE_CONDITION:
        goto RULE_START


rule "Hero AI: Tracer Bot - Default":
    @Event eachPlayer
    @Hero tracer
    @Condition eventPlayer.Module_001_DummyBotEnemy == true
    
    Action_Module_009_Distance_Info()
    Action_Module_012_Health()
    if eventPlayer.TookDamage == true:
        Action_Module_001_UseAbility1()
    if eventPlayer.DealtDamage == true:
        Action_Module_001_UseAbility1()
    if eventPlayer.Module_009_HalfHealth50 == true:
        Action_Module_002_UseAbility2()
    if eventPlayer.Module_003_LowRange5m == true:
        Action_Module_003_UseUltimate()
    wait(eventPlayer.Bot_Waiting_Time)
    if RULE_CONDITION:
        goto RULE_START


rule "Hero AI: Widowmaker Bot  - Sniper Shoot":
    @Event eachPlayer
    @Hero widowmaker
    @Condition eventPlayer.isFiringSecondaryFire() == true
    @Condition eventPlayer.Module_001_DummyBotEnemy == true
    
    wait(1.4)
    eventPlayer.forceButtonPress(Button.PRIMARY_FIRE)
    if RULE_CONDITION:
        goto RULE_START


rule "Hero AI: Widowmaker Bot  - Snipermode Without Sniperspot":
    @Event eachPlayer
    @Hero widowmaker
    @Condition distance(eventPlayer, eventPlayer.CurrentTarget[0]) > 5
    @Condition eventPlayer.isStanding() == false
    @Condition eventPlayer.Module_001_DummyBotEnemy == true
    
    eventPlayer.startForcingButton(Button.SECONDARY_FIRE)


rule "Hero AI: Widowmaker Bot  - Shoot Without Sniperspot":
    @Event eachPlayer
    @Hero widowmaker
    @Condition distance(eventPlayer, eventPlayer.CurrentTarget[0]) <= 5
    @Condition eventPlayer.isStanding() == false
    @Condition eventPlayer.Module_001_DummyBotEnemy == true
    
    eventPlayer.stopForcingButton(Button.SECONDARY_FIRE)
    eventPlayer.startForcingButton(Button.PRIMARY_FIRE)


rule "Hero AI: Widowmaker Bot  - Poison Mine + Ult":
    @Event eachPlayer
    @Hero widowmaker
    @Condition eventPlayer.Module_002_DummyBot == true
    
    if eventPlayer.CanSeeEnemy == false:
        goto lbl_0
    if distance(eventPlayer, eventPlayer.CurrentTarget[0]) > 10:
        goto lbl_1
    eventPlayer.forceButtonPress(Button.ABILITY_2)
    lbl_0:
    lbl_1:
    if eventPlayer.CanSeeEnemy == true:
        goto lbl_2
    if eventPlayer.getUltCharge() != 100:
        goto lbl_3
    eventPlayer.forceButtonPress(Button.ULTIMATE)
    lbl_2:
    lbl_3:
    wait(random.uniform(0.1, 0.5))
    if RULE_CONDITION:
        goto RULE_START


rule "Hero AI: Widowmaker Bot - Ultimate":
    @Event eachPlayer
    @Condition eventPlayer.BotActive == true
    @Condition getPlayersOnHero(Hero.WIDOWMAKER, eventPlayer.getTeam())[0].isUsingUltimate() == true
    @Condition eventPlayer.CanSeeEnemy == false
    
    wait(random.uniform(0.5, 1.5))
    eventPlayer.startFacing(directionTowards(eventPlayer.getEyePosition(), getClosestPlayer(eventPlayer, getOppositeTeam(eventPlayer.getTeam())).getEyePosition()), 500, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
    if RULE_CONDITION:
        goto RULE_START


rule "Hero AI: Winston Bot - Default":
    @Event eachPlayer
    @Hero winston
    @Condition eventPlayer.Module_001_DummyBotEnemy == true
    
    if eventPlayer.TookDamage == false:
        goto lbl_0
    if eventPlayer.getNormalizedHealth() > 0.4:
        goto lbl_1
    eventPlayer.forceButtonPress(Button.ULTIMATE)
    lbl_0:
    lbl_1:
    if eventPlayer.TookDamage == false:
        goto lbl_2
    eventPlayer.forceButtonPress(Button.ABILITY_1)
    if eventPlayer.isOnGround() == false:
        goto lbl_3
    lbl_2:
    eventPlayer.forceButtonPress(Button.ABILITY_2)
    lbl_3:
    Action_Module_006_UsePrimary_A()
    wait(eventPlayer.Bot_Waiting_Time)
    if RULE_CONDITION:
        goto RULE_START


rule "Hero AI: Wrecking Ball - Default":
    @Event eachPlayer
    @Hero hammond
    @Condition eventPlayer.Module_002_DummyBot == true
    
    if eventPlayer.isInAir() == true:
        eventPlayer.forceButtonPress(Button.CROUCH)
    Action_Module_009_Distance_Info()
    if eventPlayer.CanSeeEnemy == true and eventPlayer.TookDamage == true:
        Action_Module_002_UseAbility2()
    if eventPlayer.CanSeeEnemy == true and eventPlayer.Module_003_LowRange5m == true and eventPlayer.isOnObjective() == true:
        Action_Module_003_UseUltimate()
    if eventPlayer.isOnObjective() == false and distance(eventPlayer, eventPlayer.CurrentVisibleWaypoints[0]) <= 10:
        eventPlayer.startForcingButton(Button.SECONDARY_FIRE)
        wait(2.25)
        eventPlayer.stopForcingButton(Button.SECONDARY_FIRE)
    if eventPlayer.CanSeeEnemy == true:
    wait(eventPlayer.Bot_Waiting_Time)
    if RULE_CONDITION:
        goto RULE_START


rule "Hero AI: Wrecking Ball - Default":
    @Event eachPlayer
    @Hero hammond
    @Condition eventPlayer.Module_002_DummyBot == true
    @Condition eventPlayer.isOnObjective() == true
    @Condition eventPlayer.CanSeeEnemy == false
    
    eventPlayer.forceButtonPress(Button.ABILITY_1)


rule "Hero AI: Wrecking Ball - Default":
    @Event eachPlayer
    @Hero hammond
    @Condition eventPlayer.Module_002_DummyBot == true
    @Condition eventPlayer.isInSpawnRoom() == false
    @Condition isControlPointLocked() == false
    
    eventPlayer.forceButtonPress(Button.ABILITY_1)


rule "Hero AI: Zarya Bot - Deault":
    @Event eachPlayer
    @Hero zarya
    @Condition eventPlayer.StopShoot == false
    @Condition eventPlayer.Module_001_DummyBotEnemy == true
    
    if distance(eventPlayer.getEyePosition(), getClosestPlayer(eventPlayer, getOppositeTeam(eventPlayer.getTeam())).getEyePosition()) > 8:
        goto lbl_0
    eventPlayer.startForcingButton(Button.PRIMARY_FIRE)
    lbl_0:
    if distance(eventPlayer.getEyePosition(), getClosestPlayer(eventPlayer, getOppositeTeam(eventPlayer.getTeam())).getEyePosition()) <= 8:
        goto lbl_1
    eventPlayer.stopForcingButton(Button.PRIMARY_FIRE)
    eventPlayer.forceButtonPress(Button.SECONDARY_FIRE)
    lbl_1:
    if eventPlayer.TookDamage == false:
        goto lbl_2
    eventPlayer.forceButtonPress(Button.ABILITY_1)
    lbl_2:
    wait(eventPlayer.Bot_Waiting_Time)
    if RULE_CONDITION:
        goto RULE_START


rule "Hero AI: Zarya Bot - Ally Shield":
    @Event eachPlayer
    @Hero zarya
    @Condition eventPlayer.BotActive == true
    @Condition eventPlayer.isAlive() == true
    @Condition eventPlayer.CanSeeDamagedAlly == true
    @Condition eventPlayer.CanSeeEnemy == true
    @Condition eventPlayer.CurrentHealTarget[0].TookDamage == true == true
    
    eventPlayer.StopShoot = true
    wait(0.25, Wait.ABORT_WHEN_FALSE)
    eventPlayer.forceButtonPress(Button.ABILITY_2)
    if eventPlayer.isUsingAbility2() == false:
        goto RULE_START
    eventPlayer.CanHeal = false
    eventPlayer.StopShoot = false
    wait(8)
    eventPlayer.CanHeal = true


rule "Hero AI: Zarya Bot - Ult if CC":
    @Event eachPlayer
    @Hero zarya
    @Condition eventPlayer.BotActive == true
    @Condition StartBots == true
    @Condition eventPlayer.getUltCharge() == 100
    @Condition eventPlayer.L == false == true
    @Condition eventPlayer.CurrentTarget.HasCC == true
    
    eventPlayer.forceButtonPress(Button.ULTIMATE)
    eventPlayer.ZaryaUlt = true


rule "Hero AI: Zarya Bot - Ult":
    @Event eachPlayer
    @Hero zarya
    @Condition eventPlayer.BotActive == true
    @Condition StartBots == true
    @Condition eventPlayer.getUltCharge() == 100
    @Condition eventPlayer.L == false == true
    @Condition getNumberOfPlayersOnObjective(getOppositeTeam(eventPlayer.getTeam())) > 2
    @Condition eventPlayer.PlayerClosestToObjectiveCenter != []
    @Condition isInLoS(eventPlayer, eventPlayer.PlayerClosestToObjectiveCenter[0], BarrierLos.PASS_THROUGH_BARRIERS) == true
    
    eventPlayer.StopFacing = true
    wait(0.25)
    eventPlayer.startFacing(directionTowards(eventPlayer.getEyePosition(), getObjectivePosition(getCurrentObjective())), 10000, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
    wait(0.25)
    eventPlayer.forceButtonPress(Button.ULTIMATE)
    wait(1.5)
    eventPlayer.StopFacing = false


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


rule "Hero AI: Echo Bot":
    @Event eachPlayer
    @Hero echo
    @Condition eventPlayer.Module_001_DummyBotEnemy == true
    
    Action_Module_006_UsePrimary_A()
    if eventPlayer.DealtDamage == true:
        Action_Module_003_UseUltimate()
        Action_Module_002_UseAbility2()
        Action_Module_005_UseSecondary_B()
    if eventPlayer.TookDamage == true:
        Action_Module_001_UseAbility1()
    if eventPlayer.isUsingAbility1() == true:
        eventPlayer.startForcingButton(Button.JUMP)
    else:
        eventPlayer.stopForcingButton(Button.JUMP)
    wait(eventPlayer.Bot_Waiting_Time)
    if RULE_CONDITION:
        goto RULE_START


/*
rule "===== COMMUNICATE =====":
*/

rule "Communication: Ult State 50%":
    @Event eachPlayer
    @Condition eventPlayer.BotActive == true
    @Condition eventPlayer.getUltCharge() > 49.999
    
    eventPlayer.communicate(Comms.ULTIMATE_STATUS)


rule "Communication: Ult State 100%":
    @Event eachPlayer
    @Condition eventPlayer.BotActive == true
    @Condition eventPlayer.getUltCharge() == 100
    
    eventPlayer.communicate(Comms.ULTIMATE_STATUS)


rule "Communication: Hi":
    @Event eachPlayer
    @Condition eventPlayer.BotActive == true
    @Condition isGameInProgress() == false
    
    wait(random.uniform(3, 10), Wait.ABORT_WHEN_FALSE)
    eventPlayer.startFacing(directionTowards(eventPlayer.getEyePosition(), getClosestPlayer(eventPlayer, eventPlayer.getTeam()).getEyePosition()), 1000, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
    eventPlayer.communicate(Comms.HELLO)
    if RULE_CONDITION:
        goto RULE_START


rule "Communication: Thank you":
    @Event playerReceivedHealing
    @Condition eventPlayer.getNormalizedHealth() <= 0.5
    @Condition eventPlayer.BotActive == true
    
    eventPlayer.communicate(Comms.THANKS)
    wait(15.25)


/*
rule "===== CORE NAVIGATION LOGIC =====":
*/

rule "Current Waypoint - Automatic":
    @Event eachPlayer
    @Condition eventPlayer.BotActive == true
    @Condition StartBots == 1
    @Condition eventPlayer.StopAutomaticGoTo == false
    @Condition eventPlayer.T == false
    @Condition (eventPlayer.getCurrentHero() == Hero.GENJI and eventPlayer.isUsingUltimate() == true) == false
    
    if eventPlayer.getNormalizedHealth() < 0.6 and eventPlayer.CanSeeEnemy == false:
        eventPlayer.ClosestHealthpackPosition = sorted(HealthpackLocations, lambda player: distance(eventPlayer, player))
        eventPlayer.CurrentVisibleWaypoints = sorted([i for i in [player for player in Waypoints if isInLoS(eventPlayer, player, BarrierLos.PASS_THROUGH_BARRIERS) == true] if i in eventPlayer.WaypointBlacklist == false], lambda i: distance(i, eventPlayer.ClosestHealthpackPosition[0]))
    else:
        if eventPlayer.getCurrentHero() == Hero.GENJI and eventPlayer.isUsingUltimate() == true or eventPlayer.getCurrentHero() == Hero.DOOMFIST and eventPlayer.isUsingUltimate() == true:
            if eventPlayer.CanSeeEnemy == false:
                eventPlayer.CurrentVisibleWaypoints = sorted([i for i in [player for player in Waypoints if isInLoS(eventPlayer, player, BarrierLos.PASS_THROUGH_BARRIERS) == true] if i in eventPlayer.WaypointBlacklist == false], lambda i: distance(i, getClosestPlayer(eventPlayer, getOppositeTeam(eventPlayer.getTeam())).getPosition()))
            else:
                eventPlayer.startThrottleInDirection(directionTowards(eventPlayer, eventPlayer.CurrentTarget[0]), 1, Relativity.TO_WORLD, Throttle.REPLACE_EXISTING, ThrottleReeval.DIRECTION_AND_MAGNITUDE)
        else:
            if teamScore(getOppositeTeam(eventPlayer.getTeam())) < 70:
                eventPlayer.CurrentVisibleWaypoints = sorted([i for i in [player for player in Waypoints if isInLoS(eventPlayer, player, BarrierLos.PASS_THROUGH_BARRIERS) == true] if i in eventPlayer.WaypointBlacklist == false], lambda i: distance(i, eventPlayer.CurrentGoToTarget))
            else:
                if eventPlayer.isOnObjective() == true and eventPlayer.CurrentGoToTarget == getObjectivePosition(getCurrentObjective()):
                    eventPlayer.CurrentVisibleWaypoints = sorted([i for i in [player for player in Waypoints if isInLoS(eventPlayer, player, BarrierLos.PASS_THROUGH_BARRIERS) == true] if i in eventPlayer.WaypointBlacklist == false], lambda i: distance(i, eventPlayer))
                    eventPlayer.CurrentVisibleWaypoints = random.shuffle(eventPlayer.CurrentVisibleWaypoints)
                else:
                    eventPlayer.CurrentVisibleWaypoints = sorted([i for i in [player for player in Waypoints if isInLoS(eventPlayer, player, BarrierLos.PASS_THROUGH_BARRIERS) == true] if i in eventPlayer.WaypointBlacklist == false], lambda i: distance(i, eventPlayer.CurrentGoToTarget[0]))
            eventPlayer.startThrottleInDirection(directionTowards(eventPlayer, eventPlayer.CurrentVisibleWaypoints[0]), 1, Relativity.TO_WORLD, Throttle.REPLACE_EXISTING, ThrottleReeval.DIRECTION_AND_MAGNITUDE)
    wait(random.randint(1, 2))
    if RULE_CONDITION:
        goto RULE_START


rule "Current Waypoint - After Reached Waypoint":
    @Event eachPlayer
    @Condition eventPlayer.BotActive == true
    @Condition eventPlayer.CurrentVisibleWaypoints != [] == true
    @Condition distance(eventPlayer.getEyePosition(), eventPlayer.CurrentVisibleWaypoints[0]) <= 1
    @Condition (isGameInProgress() or getCurrentGamemode() == Gamemode.SKIRMISH) == true
    @Condition StartBots == 1
    @Condition eventPlayer.StopAutomaticGoTo == false
    @Condition eventPlayer.T == false
    
    eventPlayer.WaypointBlacklist.append(eventPlayer.CurrentVisibleWaypoints[0])
    if eventPlayer.getNormalizedHealth() < 0.6 and eventPlayer.CanSeeEnemy == false:
        eventPlayer.ClosestHealthpackPosition = sorted(HealthpackLocations, lambda player: distance(eventPlayer, player))
        eventPlayer.CurrentVisibleWaypoints = sorted([i for i in [player for player in Waypoints if isInLoS(eventPlayer, player, BarrierLos.PASS_THROUGH_BARRIERS) == true] if i in eventPlayer.WaypointBlacklist == false], lambda i: distance(i, eventPlayer.ClosestHealthpackPosition[0]))
    else:
        if eventPlayer.getCurrentHero() == Hero.GENJI and eventPlayer.isUsingUltimate() == true or eventPlayer.getCurrentHero() == Hero.DOOMFIST and eventPlayer.isUsingUltimate() == true:
            if eventPlayer.CanSeeEnemy == false:
                eventPlayer.CurrentVisibleWaypoints = sorted([i for i in [player for player in Waypoints if isInLoS(eventPlayer, player, BarrierLos.PASS_THROUGH_BARRIERS) == true] if i in eventPlayer.WaypointBlacklist == false], lambda i: distance(i, getClosestPlayer(eventPlayer, getOppositeTeam(eventPlayer.getTeam())).getPosition()))
            else:
                eventPlayer.startThrottleInDirection(directionTowards(eventPlayer, eventPlayer.CurrentTarget[0]), 1, Relativity.TO_WORLD, Throttle.REPLACE_EXISTING, ThrottleReeval.DIRECTION_AND_MAGNITUDE)
        else:
            if teamScore(getOppositeTeam(eventPlayer.getTeam())) < 70:
                eventPlayer.CurrentVisibleWaypoints = sorted([i for i in [player for player in Waypoints if isInLoS(eventPlayer, player, BarrierLos.PASS_THROUGH_BARRIERS) == true] if i in eventPlayer.WaypointBlacklist == false], lambda i: distance(i, eventPlayer.CurrentGoToTarget))
            else:
                if eventPlayer.isOnObjective() == true and eventPlayer.CurrentGoToTarget == getObjectivePosition(getCurrentObjective()):
                    eventPlayer.CurrentVisibleWaypoints = sorted([i for i in [player for player in Waypoints if isInLoS(eventPlayer, player, BarrierLos.PASS_THROUGH_BARRIERS) == true] if i in eventPlayer.WaypointBlacklist == false], lambda i: distance(i, eventPlayer))
                    eventPlayer.CurrentVisibleWaypoints = random.shuffle(eventPlayer.CurrentVisibleWaypoints)
                else:
                    eventPlayer.CurrentVisibleWaypoints = sorted([i for i in [player for player in Waypoints if isInLoS(eventPlayer, player, BarrierLos.PASS_THROUGH_BARRIERS) == true] if i in eventPlayer.WaypointBlacklist == false], lambda i: distance(i, eventPlayer.CurrentGoToTarget[0]))
            eventPlayer.startThrottleInDirection(directionTowards(eventPlayer, eventPlayer.CurrentVisibleWaypoints[0]), 1, Relativity.TO_WORLD, Throttle.REPLACE_EXISTING, ThrottleReeval.DIRECTION_AND_MAGNITUDE)


/*
rule "===== BOT CORE AI =====":
*/

rule "Behavior: No Active CP (Control)":
    @Event eachPlayer
    @Condition (isGameInProgress() or getCurrentGamemode() == Gamemode.SKIRMISH) == true
    @Condition eventPlayer.isInSpawnRoom() == true
    @Condition getCurrentGamemode() == Gamemode.CONTROL
    
    eventPlayer.CurrentGoToTarget = random.choice(getLivingPlayers(getOppositeTeam(eventPlayer.getTeam())))
    wait(random.uniform(1, 10))
    if RULE_CONDITION:
        goto RULE_START


rule "Behavior: Capture Neutral Objective (Control)":
    @Event eachPlayer
    @Condition (isGameInProgress() or getCurrentGamemode() == Gamemode.SKIRMISH) == true
    @Condition isControlPointLocked() == false
    @Condition getCurrentGamemode() == Gamemode.CONTROL
    @Condition getControlScorePercentage(Team.1) == 0
    @Condition getControlScorePercentage(Team.2) == 0
    
    eventPlayer.CurrentGoToTarget = getObjectivePosition(getCurrentObjective())


rule "Behavior: Tanks":
    @Event eachPlayer
    @Condition (isGameInProgress() or getCurrentGamemode() == Gamemode.SKIRMISH) == true
    @Condition isControlPointLocked() == false
    @Condition getCurrentGamemode() == Gamemode.CONTROL
    @Condition eventPlayer.isInSpawnRoom() == false
    @Condition eventPlayer.getCurrentHero() in getTankHeroes() == true
    @Condition getControlScoringTeam() == eventPlayer.getTeam()
    @Condition getControlScorePercentage(getOppositeTeam(eventPlayer.getTeam())) < 70
    
    eventPlayer.CurrentGoToTarget = random.choice([player for player in getPlayers(getOppositeTeam(eventPlayer.getTeam())) if distance(getObjectivePosition(getCurrentObjective()), player) <= 45])
    wait(random.uniform(1, 10))
    if RULE_CONDITION:
        goto RULE_START


rule "Behavior: Support Tanks":
    @Event eachPlayer
    @Condition (isGameInProgress() or getCurrentGamemode() == Gamemode.SKIRMISH) == true
    @Condition isControlPointLocked() == false
    @Condition getCurrentGamemode() == Gamemode.CONTROL
    @Condition eventPlayer.isInSpawnRoom() == false
    @Condition eventPlayer.getCurrentHero() in getSupportHeroes() == true
    @Condition getControlScorePercentage(getOppositeTeam(eventPlayer.getTeam())) < 70
    
    eventPlayer.CurrentGoToTarget = sorted(getLivingPlayers(eventPlayer.getTeam()), lambda player: eventPlayer.getMaxHealth()).last()


rule "Behavior: Damage Hero":
    @Event eachPlayer
    @Condition (isGameInProgress() or getCurrentGamemode() == Gamemode.SKIRMISH) == true
    @Condition isControlPointLocked() == false
    @Condition getCurrentGamemode() == Gamemode.CONTROL
    @Condition eventPlayer.isInSpawnRoom() == false
    @Condition eventPlayer.getCurrentHero() in getDamageHeroes() == true
    @Condition getControlScoringTeam() == eventPlayer.getTeam()
    @Condition getControlScorePercentage(getOppositeTeam(eventPlayer.getTeam())) < 70
    
    eventPlayer.CurrentGoToTarget = random.choice([player for player in getPlayers(getOppositeTeam(eventPlayer.getTeam())) if distance(getObjectivePosition(getCurrentObjective()), player) <= 45])
    wait(random.uniform(1, 10))
    if RULE_CONDITION:
        goto RULE_START


rule "Behavior: Capture Objective (enemy controls it)":
    @Event eachPlayer
    @Condition (isGameInProgress() or getCurrentGamemode() == Gamemode.SKIRMISH) == true
    @Condition isControlPointLocked() == false
    @Condition getCurrentGamemode() == Gamemode.CONTROL
    @Condition getControlScoringTeam() == getOppositeTeam(eventPlayer.getTeam())
    @Condition eventPlayer.isInSpawnRoom() == false
    
    eventPlayer.CurrentGoToTarget = getObjectivePosition(getCurrentObjective())


rule "Skirmish AI":
    @Event eachPlayer
    @Condition getCurrentGamemode() == Gamemode.SKIRMISH
    
    eventPlayer.CurrentGoToTarget = random.choice([player for player in getPlayers(getOppositeTeam(eventPlayer.getTeam())) if distance(getClosestPlayer(eventPlayer, getOppositeTeam(eventPlayer.getTeam())), player) <= 45])
    wait(random.uniform(1, 10))
    if RULE_CONDITION:
        goto RULE_START


rule "Behavior: Healthpack":
    @Event eachPlayer
    @Condition (isGameInProgress() or getCurrentGamemode() == Gamemode.SKIRMISH) == true
    @Condition eventPlayer.isAlive() == true
    @Condition eventPlayer.getNormalizedHealth() < 0.6
    @Condition distance(eventPlayer, eventPlayer.ClosestHealthpackPosition[0]) <= 5
    @Condition eventPlayer.isInSpawnRoom() == false
    @Condition eventPlayer.BotActive == true
    @Condition isInLoS(eventPlayer, eventPlayer.ClosestHealthpackPosition[0], BarrierLos.PASS_THROUGH_BARRIERS) == true
    
    if distance(eventPlayer, eventPlayer.ClosestHealthpackPosition[0]) > 1:
        eventPlayer.StopAutomaticGoTo = true
        wait(0.1)
        eventPlayer.startThrottleInDirection(directionTowards(eventPlayer, eventPlayer.ClosestHealthpackPosition[0]), 1, Relativity.TO_WORLD, Throttle.REPLACE_EXISTING, ThrottleReeval.DIRECTION_AND_MAGNITUDE)
    else:
        eventPlayer.stopThrottleInDirection()
    wait(0.25)
    if RULE_CONDITION:
        goto RULE_START
    eventPlayer.StopAutomaticGoTo = false
    eventPlayer.startThrottleInDirection(directionTowards(eventPlayer, eventPlayer.CurrentWaypoint[0]), 1, Relativity.TO_WORLD, Throttle.REPLACE_EXISTING, ThrottleReeval.DIRECTION_AND_MAGNITUDE)


rule "Navigation: Oasis - Jumps":
    @Event eachPlayer
    @Condition getCurrentMap() == Map.OASIS
    @Condition isGameInProgress() == false
    
    if getCurrentObjective() == 0:
        JumpPointsGlobal = []
        JumpPointsGlobal.append(vect(123.808, 2.559, 292.726))
        JumpPointsGlobal.append(vect(188.189, 4.359, 228.089))
        JumpPointsGlobal.append(vect(170.559, 4.268, 222.939))
        JumpPointsGlobal.append(vect(167.944, 4.07, 219.634))
        JumpPointsGlobal.append(vect(156.701, 3.524, 211.804))
        JumpPointsGlobal.append(vect(152.183, 3.468, 210.315))
        JumpPointsGlobal.append(vect(124.412, 3.619, 225.195))
        JumpPointsGlobal.append(vect(121.27, 3.635, 228.386))
        JumpPointsGlobal.append(vect(153.632, 12.873, 257.41))
        JumpPointsGlobal.append(vect(157.724, 12.873, 253.873))
        JumpPointsGlobal.append(vect(150.635, 12.873, 260.901))
        JumpPointsGlobal.append(vect(118.719, 3.952, 275.334))
        JumpPointsGlobal.append(vect(115.857, 4.024, 272.264))
        JumpPointsGlobal.append(vect(107.934, 3.651, 261.288))
        JumpPointsGlobal.append(vect(105.203, 3.054, 256.338))
        JumpPointsGlobal.append(vect(186.166, 4.496, 230.041))
        JumpPointsGlobal.append(vect(125.594, 4.329, 290.612))
        JumpPointsGlobal.append(vect(125.594, 4.329, 290.612))
        JumpPointsGlobal.append(vect(118.9, 3.148, 290.029))
    if getCurrentObjective() == 1:
        JumpPointsGlobal = []
        JumpPointsGlobal.append(vect(112.732, 8.136, -236.545))
        JumpPointsGlobal.append(vect(130.551, 8.136, -219.095))
        JumpPointsGlobal.append(vect(113.535, 7.201, -235.767))
        JumpPointsGlobal.append(vect(129.562, 7.201, -219.798))
    if getCurrentObjective() == 2:
        JumpPointsGlobal = []
        JumpPointsGlobal.append(vect(83.239, 130.495, -44.073))
        JumpPointsGlobal.append(vect(81.171, 129.698, -9.898))
        JumpPointsGlobal.append(vect(86.641, 131.702, 12.769))
        JumpPointsGlobal.append(vect(86.745, 129.702, 9.483))
        JumpPointsGlobal.append(vect(81.244, 129.698, 10.156))
        JumpPointsGlobal.append(vect(86.655, 131.699, -12.752))
        JumpPointsGlobal.append(vect(86.808, 129.698, -9.973))


/*
rule "===== NAVIGATION: BUSAN =====":
*/

rule "Navigation: Busan - Waypoints":
    @Condition getCurrentMap() == Map.BUSAN
    @Condition isGameInProgress() == true
    
    if getCurrentObjective() == 0:
        Waypoints = []
        Waypoints.append(vect(-22.589, 17.502, -121.816))
        Waypoints.append(vect(-0.05, 17.296, -108.813))
        Waypoints.append(vect(20.139, 14.351, -108.923))
        Waypoints.append(vect(-22.016, 18.352, -120.922))
        Waypoints.append(vect(8.932, 15.897, -109.371))
        Waypoints.append(vect(19.822, 11.351, -95.15))
        Waypoints.append(vect(20.684, 9.351, -81.641))
        Waypoints.append(vect(31.813, 9.351, -80.584))
        Waypoints.append(vect(31.29, 9.351, -91.556))
        Waypoints.append(vect(43.611, 6.22, -80.342))
        Waypoints.append(vect(51.927, 6.22, -75.978))
        Waypoints.append(vect(59.757, 6.221, -80.649))
        Waypoints.append(vect(40.175, 7.351, -91.417))
        Waypoints.append(vect(41.151, 7.418, -101.449))
        Waypoints.append(vect(40.149, 11.401, -109.444))
        Waypoints.append(vect(46.231, 8.067, -102.743))
        Waypoints.append(vect(46.201, 11.236, -109.082))
        Waypoints.append(vect(18.368, 14.351, -114.534))
        Waypoints.append(vect(17.507, 14.284, -124.023))
        Waypoints.append(vect(19.306, 14.351, -134.821))
        Waypoints.append(vect(20.687, 14.351, -130.174))
        Waypoints.append(vect(31.635, 16.351, -133.038))
        Waypoints.append(vect(37.132, 11.348, -136.7))
        Waypoints.append(vect(31.321, 16.348, -123.096))
        Waypoints.append(vect(36.594, 16.343, -122.538))
        Waypoints.append(vect(40.477, 11.351, -134.859))
        Waypoints.append(vect(50.936, 12.36, -140.792))
        Waypoints.append(vect(63.423, 11.351, -134.895))
        Waypoints.append(vect(51.955, 12.36, -137.102))
        Waypoints.append(vect(51.885, 12.247, -129.136))
        Waypoints.append(vect(51.998, 11.364, -122.746))
        Waypoints.append(vect(51.931, 11.351, -111.771))
        Waypoints.append(vect(51.959, 13.279, -101.39))
        Waypoints.append(vect(60.191, 13.279, -98.708))
        Waypoints.append(vect(63.988, 13.279, -91.87))
        Waypoints.append(vect(44.119, 13.278, -98.931))
        Waypoints.append(vect(39.979, 13.278, -91.938))
        Waypoints.append(vect(42.524, 11.351, -119.318))
        Waypoints.append(vect(64.957, 11.348, -121.728))
        Waypoints.append(vect(63.243, 11.383, -109.874))
        Waypoints.append(vect(58.228, 11.383, -110.115))
        Waypoints.append(vect(58.319, 7.554, -101.716))
        Waypoints.append(vect(63.254, 8.087, -102.78))
        Waypoints.append(vect(63.573, 7.351, -91.238))
        Waypoints.append(vect(72.415, 9.351, -91.124))
        Waypoints.append(vect(72.09, 9.351, -80.574))
        Waypoints.append(vect(84.155, 9.351, -82.475))
        Waypoints.append(vect(84.381, 11.351, -94.965))
        Waypoints.append(vect(83.904, 14.351, -108.563))
        Waypoints.append(vect(94.189, 15.568, -108.853))
        Waypoints.append(vect(104.505, 17.283, -109.135))
        Waypoints.append(vect(81.197, 14.351, -108.92))
        Waypoints.append(vect(85.439, 14.289, -115.78))
        Waypoints.append(vect(76.811, 14.259, -116.854))
        Waypoints.append(vect(66.479, 11.283, -116.236))
        Waypoints.append(vect(85.748, 14.351, -130.741))
        Waypoints.append(vect(81.973, 14.351, -134.896))
        Waypoints.append(vect(78.219, 15.256, -130.481))
        Waypoints.append(vect(71.84, 16.442, -133.38))
        Waypoints.append(vect(71.932, 16.352, -123.286))
        Waypoints.append(vect(92.429, 15.063, -125.521))
        Waypoints.append(vect(99.085, 17.287, -125.461))
        Waypoints.append(vect(133.133, 18.362, -119.832))
        Waypoints.append(vect(124.473, 18.351, -120.374))
        Waypoints.append(vect(119.832, 18.351, -125.807))
        Waypoints.append(vect(126.873, 18.351, -129.602))
        Waypoints.append(vect(132.735, 18.324, -125.291))
        Waypoints.append(vect(57.398, 7.351, -96.454))
        Waypoints.append(vect(57.465, 7.351, -92.32))
        Waypoints.append(vect(57.742, 7.351, -87.747))
        Waypoints.append(vect(51.704, 7.351, -89.052))
        Waypoints.append(vect(51.903, 7.357, -94.24))
        Waypoints.append(vect(51.824, 7.357, -101.368))
        Waypoints.append(vect(45.584, 7.351, -97.316))
        Waypoints.append(vect(45.758, 7.351, -92.479))
        Waypoints.append(vect(46.398, 7.351, -88.223))
        Waypoints.append(vect(-24.363, 17.455, -121.976))
        Waypoints.append(vect(-10.554, 17.375, -125.829))
        Waypoints.append(vect(29.555, 8.803, -80.548))
        Waypoints.append(vect(19.089, 8.578, -87.481))
        Waypoints.append(vect(28.253, 20.455, -112.276))
        Waypoints.append(vect(34.584, 20.563, -110.447))
        Waypoints.append(vect(76.473, 20.455, -112.614))
        Waypoints.append(vect(71.623, 20.627, -110.647))
        Waypoints.append(vect(68.972, 20.686, -110.819))
        Waypoints.append(vect(52.252, 13.943, -97.435))
        Waypoints.append(vect(34.488, 20.698, -109.583))
        Waypoints.append(vect(23.523, 20.512, -107.078))
        Waypoints.append(vect(24.506, 20.455, -109.972))
        #Waypoints.append(vect(21.818, 13.787, -98.833))
    if getCurrentObjective() == 1:
        Waypoints = []
        Waypoints.append(vect(-328.532, 14.528, 179.725))
        Waypoints.append(vect(-410.01, 11.457, 156.899))
        Waypoints.append(vect(-408.398, 11.456, 171.589))
        Waypoints.append(vect(-390.775, 10.704, 170.796))
        Waypoints.append(vect(-381.839, 13.416, 175.569))
        Waypoints.append(vect(-381.287, 13.51, 169.105))
        Waypoints.append(vect(-372.16, 13.424, 166.783))
        Waypoints.append(vect(-417.332, 12.459, 164.805))
        Waypoints.append(vect(-359.969, 13.398, 169.277))
        Waypoints.append(vect(-367.617, 13.401, 173.983))
        Waypoints.append(vect(-363.172, 13.387, 161.981))
        Waypoints.append(vect(-370.859, 13.424, 163.132))
        Waypoints.append(vect(-351.723, 12.422, 181.18))
        Waypoints.append(vect(-351.627, 13.423, 164.301))
        Waypoints.append(vect(-339.422, 12.422, 180.885))
        Waypoints.append(vect(-339.208, 13.424, 166.75))
        Waypoints.append(vect(-334.459, 13.365, 166.855))
        Waypoints.append(vect(-328.597, 13.36, 162.028))
        Waypoints.append(vect(-317.755, 13.424, 167.32))
        Waypoints.append(vect(-328.938, 13.365, 172.409))
        Waypoints.append(vect(-328.575, 15.424, 178.233))
        Waypoints.append(vect(-328.699, 9.421, 181.046))
        Waypoints.append(vect(-318.172, 12.424, 180.823))
        Waypoints.append(vect(-305.64, 12.424, 180.635))
        Waypoints.append(vect(-304.414, 13.416, 163.832))
        Waypoints.append(vect(-316.718, 13.424, 164.932))
        Waypoints.append(vect(-293.431, 13.387, 162.735))
        Waypoints.append(vect(-287.627, 13.424, 165.181))
        Waypoints.append(vect(-279.818, 13.424, 167.401))
        Waypoints.append(vect(-275.149, 13.425, 174.566))
        Waypoints.append(vect(-261.735, 10.704, 169.945))
        Waypoints.append(vect(-274.436, 11.305, 158.181))
        Waypoints.append(vect(-284.527, 13.173, 152.219))
        Waypoints.append(vect(-291.113, 13.383, 157.591))
        Waypoints.append(vect(-284.583, 13.173, 140.265))
        Waypoints.append(vect(-295.607, 11.807, 140.207))
        Waypoints.append(vect(-303.27, 11.943, 145.725))
        Waypoints.append(vect(-313.249, 9.638, 156.06))
        Waypoints.append(vect(-328.664, 9.559, 152.13))
        Waypoints.append(vect(-305.137, 11.81, 140.739))
        Waypoints.append(vect(-301.783, 11.81, 134.831))
        Waypoints.append(vect(-317.268, 9.559, 140.513))
        Waypoints.append(vect(-316.426, 9.559, 130.784))
        Waypoints.append(vect(-325.896, 9.559, 130.052))
        Waypoints.append(vect(-331.694, 9.559, 130.178))
        Waypoints.append(vect(-342.647, 9.559, 129.269))
        Waypoints.append(vect(-340.22, 9.559, 136.998))
        Waypoints.append(vect(-339.045, 9.559, 143.046))
        Waypoints.append(vect(-335.507, 9.559, 152.643))
        Waypoints.append(vect(-332.104, 10.165, 144.611))
        Waypoints.append(vect(-331.87, 10.165, 140.477))
        Waypoints.append(vect(-331.686, 10.165, 136.077))
        Waypoints.append(vect(-328.204, 10.166, 136.569))
        Waypoints.append(vect(-324.605, 10.166, 136.944))
        Waypoints.append(vect(-324.868, 10.166, 140.902))
        Waypoints.append(vect(-325.125, 10.166, 144.772))
        Waypoints.append(vect(-329.173, 10.163, 144.823))
        Waypoints.append(vect(-352.033, 11.81, 140.665))
        Waypoints.append(vect(-343.174, 9.638, 155.597))
        Waypoints.append(vect(-352.431, 12.004, 147.264))
        Waypoints.append(vect(-362.07, 11.808, 140.328))
        Waypoints.append(vect(-354.3, 11.808, 133.429))
        Waypoints.append(vect(-366.803, 13.185, 140.349))
        Waypoints.append(vect(-371.894, 13.176, 143.554))
        Waypoints.append(vect(-371.966, 13.178, 150.974))
        Waypoints.append(vect(-381.886, 11.536, 158.081))
        Waypoints.append(vect(-400.97, 10.707, 156.39))
        Waypoints.append(vect(-381.57, 10.726, 126.196))
        Waypoints.append(vect(-375.422, 11.984, 130.274))
        Waypoints.append(vect(-370.027, 13.389, 131.44))
        Waypoints.append(vect(-378.478, 10.686, 126.043))
        Waypoints.append(vect(-363.604, 11.424, 125.592))
        Waypoints.append(vect(-363.392, 10.687, 117.467))
        Waypoints.append(vect(-352.577, 9.559, 117.335))
        Waypoints.append(vect(-341.735, 9.559, 117.094))
        Waypoints.append(vect(-333.728, 11.161, 109.297))
        Waypoints.append(vect(-328.34, 11.161, 109.606))
        Waypoints.append(vect(-320.69, 11.161, 111.257))
        Waypoints.append(vect(-315.479, 9.559, 115.682))
        Waypoints.append(vect(-328.582, 11.161, 124.145))
        Waypoints.append(vect(-303.655, 9.546, 117.834))
        Waypoints.append(vect(-293.403, 10.69, 117.492))
        Waypoints.append(vect(-293.337, 11.424, 125.588))
        Waypoints.append(vect(-280.955, 10.686, 123.601))
        Waypoints.append(vect(-257.467, 10.705, 153.382))
        Waypoints.append(vect(-238.628, 12.708, 164.886))
        Waypoints.append(vect(-248.031, 11.706, 170.872))
        Waypoints.append(vect(-246.908, 11.706, 157.267))
    if getCurrentObjective() == 2:
        Waypoints = []
        Waypoints.append(vect(237.398, 9.349, 227.177))
        Waypoints.append(vect(275.869, 11.802, 210.768))
        Waypoints.append(vect(283.636, 12.796, 207.114))
        Waypoints.append(vect(265.208, 11.802, 214.845))
        Waypoints.append(vect(267.72, 11.802, 209.365))
        Waypoints.append(vect(273.484, 11.802, 216.493))
        Waypoints.append(vect(261.655, 13.946, 207.546))
        Waypoints.append(vect(249.232, 14.796, 201.719))
        Waypoints.append(vect(243.318, 14.796, 203.454))
        Waypoints.append(vect(232.618, 17.796, 207.612))
        Waypoints.append(vect(234.645, 17.796, 214.708))
        Waypoints.append(vect(239.196, 17.785, 220.439))
        Waypoints.append(vect(244.471, 14.794, 233.256))
        Waypoints.append(vect(247.255, 14.794, 240.695))
        Waypoints.append(vect(250.271, 12.797, 247.937))
        Waypoints.append(vect(242.859, 10.796, 251.787))
        Waypoints.append(vect(235.422, 10.796, 251.804))
        Waypoints.append(vect(235.41, 11.213, 245.828))
        Waypoints.append(vect(234.151, 11.797, 237.967))
        Waypoints.append(vect(240.419, 14.01, 235.18))
        Waypoints.append(vect(244.004, 15.157, 241.896))
        Waypoints.append(vect(238.944, 17.819, 244.122))
        Waypoints.append(vect(226.186, 17.819, 249.599))
        Waypoints.append(vect(211.348, 16.978, 256.123))
        Waypoints.append(vect(204.98, 14.792, 258.636))
        Waypoints.append(vect(208.501, 12.797, 266.688))
        Waypoints.append(vect(215.526, 10.796, 263.613))
        Waypoints.append(vect(221.434, 10.796, 259.992))
        Waypoints.append(vect(216.794, 11.374, 253.499))
        Waypoints.append(vect(227.056, 10.853, 251.528))
        Waypoints.append(vect(223.931, 10.937, 245.184))
        Waypoints.append(vect(211.943, 11.796, 247.791))
        Waypoints.append(vect(203.736, 14.794, 250.897))
        Waypoints.append(vect(201.629, 14.72, 259.716))
        Waypoints.append(vect(194.771, 12.797, 265.75))
        Waypoints.append(vect(194.082, 12.796, 262.861))
        Waypoints.append(vect(190.746, 12.796, 255.811))
        Waypoints.append(vect(188.025, 13.796, 248.408))
        Waypoints.append(vect(180.384, 14.795, 231.097))
        Waypoints.append(vect(184.327, 13.796, 240.465))
        Waypoints.append(vect(180.465, 14.796, 230.804))
        Waypoints.append(vect(192.146, 17.797, 225.385))
        Waypoints.append(vect(194.9, 17.796, 236.171))
        Waypoints.append(vect(200.158, 14.795, 248.898))
        Waypoints.append(vect(191.898, 17.794, 217.598))
        Waypoints.append(vect(201.091, 18.798, 213.895))
        Waypoints.append(vect(209.023, 18.89, 210.838))
        Waypoints.append(vect(217.552, 18.796, 206.895))
        Waypoints.append(vect(227.94, 17.794, 203.261))
        Waypoints.append(vect(230.516, 17.794, 208.925))
        Waypoints.append(vect(217.309, 18.797, 216.4))
        Waypoints.append(vect(216.894, 18.795, 229.062))
        Waypoints.append(vect(208.155, 18.794, 219.205))
        Waypoints.append(vect(248.215, 13.796, 214.531))
        Waypoints.append(vect(210.909, 19.128, 215.358))
        Waypoints.append(vect(212.549, 11.149, 218.491))
        Waypoints.append(vect(217.212, 10.797, 214.554))
        Waypoints.append(vect(209.204, 10.797, 210.336))
        Waypoints.append(vect(206.188, 10.797, 219.796))
        Waypoints.append(vect(215.642, 10.797, 225.003))
        Waypoints.append(vect(208.465, 11.797, 228.431))
        Waypoints.append(vect(211.381, 11.796, 233.895))
        Waypoints.append(vect(224.456, 11.797, 228.36))
        Waypoints.append(vect(223.095, 11.796, 222.368))
        Waypoints.append(vect(230.14, 11.797, 230.11))
        Waypoints.append(vect(233.338, 11.797, 238.306))
        Waypoints.append(vect(243.751, 6.789, 224.56))
        Waypoints.append(vect(247.472, 6.789, 220.363))
        Waypoints.append(vect(249.049, 6.789, 224.225))
        Waypoints.append(vect(251.68, 6.789, 220.732))
        Waypoints.append(vect(262.975, 11.908, 216.314))
        Waypoints.append(vect(276.474, 11.794, 224.728))
        Waypoints.append(vect(262.847, 11.794, 224.712))
        Waypoints.append(vect(254.664, 12.796, 228.414))
        Waypoints.append(vect(257.821, 12.796, 235.76))
        Waypoints.append(vect(251.704, 13.794, 221.31))
        Waypoints.append(vect(190.034, 17.793, 226.021))
        Waypoints.append(vect(180.329, 14.797, 230.373))
        Waypoints.append(vect(175.392, 14.793, 233.43))
        Waypoints.append(vect(171.095, 14.794, 244.471))
        Waypoints.append(vect(167.398, 11.798, 252.733))
        Waypoints.append(vect(174.818, 11.798, 254.184))
        Waypoints.append(vect(186.642, 6.789, 249.023))
        Waypoints.append(vect(189.69, 6.789, 245.177))
        Waypoints.append(vect(191.457, 6.789, 249.049))
        Waypoints.append(vect(195.681, 6.793, 245.346))
        Waypoints.append(vect(205.677, 11.446, 241.032))
        Waypoints.append(vect(219.556, 11.682, 234.578))
        Waypoints.append(vect(224.917, 10.805, 236.4))
        Waypoints.append(vect(228.978, 10.792, 242.262))
        Waypoints.append(vect(225.088, 10.849, 245.261))
        Waypoints.append(vect(219.732, 10.785, 246.838))
        Waypoints.append(vect(216.881, 10.8, 241.286))
        Waypoints.append(vect(222.019, 10.793, 259.962))
        Waypoints.append(vect(208.671, 12.796, 266.525))
        Waypoints.append(vect(204.536, 14.792, 258.46))
        Waypoints.append(vect(186.083, 12.908, 258.14))
        Waypoints.append(vect(178.271, 11.796, 266.177))
        Waypoints.append(vect(173.147, 11.796, 269.673))
        Waypoints.append(vect(169.017, 11.799, 261.104))
        Waypoints.append(vect(173.669, 11.798, 254.936))
        Waypoints.append(vect(159.966, 11.799, 260.269))


rule "Navigation: Busan - Jumps":
    @Event eachPlayer
    @Condition getCurrentMap() == Map.BUSAN
    @Condition isGameInProgress() == true
    
    if getCurrentObjective() == 0:
        JumpPointsGlobal = []
        JumpPointsGlobal.append(vect(57.899, 12.239, -102.793))
        JumpPointsGlobal.append(vect(-36.833, 18.7, -120.883))
        JumpPointsGlobal.append(vect(-43.465, 18.7, -118.991))
        JumpPointsGlobal.append(vect(-36.473, 18.7, -129.913))
        JumpPointsGlobal.append(vect(-43.034, 18.7, -131.01))
        JumpPointsGlobal.append(vect(-24.018, 18.7, -117.115))
        JumpPointsGlobal.append(vect(-23.995, 18.7, -133.677))
        JumpPointsGlobal.append(vect(17.169, 16.7, -141.322))
        JumpPointsGlobal.append(vect(31.24, 16.794, -133.416))
        JumpPointsGlobal.append(vect(36.589, 16.691, -121.234))
        JumpPointsGlobal.append(vect(36.594, 16.693, -125.674))
        JumpPointsGlobal.append(vect(21.097, 14.699, -122.627))
        JumpPointsGlobal.append(vect(22.186, 15.734, -120.87))
        JumpPointsGlobal.append(vect(23.126, 17.26, -119.413))
        JumpPointsGlobal.append(vect(21.952, 14.7, -99.059))
        JumpPointsGlobal.append(vect(22.986, 11.701, -93.004))
        JumpPointsGlobal.append(vect(14.863, 11.701, -93.004))
        JumpPointsGlobal.append(vect(21.895, 9.7, -90.257))
        JumpPointsGlobal.append(vect(15.884, 9.7, -90.396))
        JumpPointsGlobal.append(vect(40.081, 9.7, -86.213))
        JumpPointsGlobal.append(vect(35.486, 11.7, -111.883))
        JumpPointsGlobal.append(vect(37.548, 11.7, -102.144))
        JumpPointsGlobal.append(vect(39.137, 13.7, -101.277))
        JumpPointsGlobal.append(vect(47.19, 10.813, -107.539))
        JumpPointsGlobal.append(vect(51.753, 16.2, -113.841))
        JumpPointsGlobal.append(vect(54.286, 16.201, -116.165))
        JumpPointsGlobal.append(vect(49.467, 16.201, -116.806))
        JumpPointsGlobal.append(vect(56.587, 11.213, -108.333))
        JumpPointsGlobal.append(vect(57.251, 13.632, -101.654))
        JumpPointsGlobal.append(vect(68.196, 11.7, -111.979))
        JumpPointsGlobal.append(vect(55.033, 13.63, -98.208))
        JumpPointsGlobal.append(vect(50.042, 13.63, -98.208))
        JumpPointsGlobal.append(vect(43.595, 13.63, -97.251))
        JumpPointsGlobal.append(vect(41.228, 13.63, -90.013))
        JumpPointsGlobal.append(vect(61.421, 13.634, -96.055))
        JumpPointsGlobal.append(vect(62.623, 13.63, -88.687))
        JumpPointsGlobal.append(vect(63.475, 9.7, -86.649))
        JumpPointsGlobal.append(vect(81.692, 9.7, -89.594))
        JumpPointsGlobal.append(vect(80.788, 11.7, -93.004))
        JumpPointsGlobal.append(vect(81.826, 14.701, -99.093))
        JumpPointsGlobal.append(vect(82.998, 14.7, -122.269))
        JumpPointsGlobal.append(vect(136.827, 17.911, -125.376))
        JumpPointsGlobal.append(vect(82.238, 16.344, -120.893))
        JumpPointsGlobal.append(vect(81.405, 17.183, -119.491))
        JumpPointsGlobal.append(vect(72.901, 16.794, -133.308))
        JumpPointsGlobal.append(vect(67.197, 16.691, -121.664))
        JumpPointsGlobal.append(vect(67.192, 16.691, -125.566))
    if getCurrentObjective() == 1:
        JumpPointsGlobal = []
        JumpPointsGlobal.append(vect(-324.508, 8.744, 156.99))
        JumpPointsGlobal.append(vect(-404.272, 10.542, 163.511))
        JumpPointsGlobal.append(vect(-404.621, 10.528, 160.721))
        JumpPointsGlobal.append(vect(-392.153, 10.01, 150.61))
        JumpPointsGlobal.append(vect(-391.024, 10.754, 150.025))
        JumpPointsGlobal.append(vect(-390.736, 11.185, 148.228))
        JumpPointsGlobal.append(vect(-393.065, 9.994, 147.238))
        JumpPointsGlobal.append(vect(-385.819, 9.943, 140.802))
        JumpPointsGlobal.append(vect(-376.452, 10.037, 127.843))
        JumpPointsGlobal.append(vect(-373.502, 12.582, 132.145))
        JumpPointsGlobal.append(vect(-370.774, 12.6, 128.304))
        JumpPointsGlobal.append(vect(-404.133, 10.527, 166.184))
        JumpPointsGlobal.append(vect(-279.981, 9.793, 127.955))
        JumpPointsGlobal.append(vect(-349.142, 11.109, 140.625))
        JumpPointsGlobal.append(vect(-307.91, 11.108, 140.483))
        JumpPointsGlobal.append(vect(-283.301, 12.868, 132.118))
        JumpPointsGlobal.append(vect(-270.259, 10.03, 141.494))
        JumpPointsGlobal.append(vect(-263.972, 9.989, 147.273))
        JumpPointsGlobal.append(vect(-265.925, 10.535, 150.162))
        JumpPointsGlobal.append(vect(-251.875, 10.81, 160.735))
        JumpPointsGlobal.append(vect(-252.172, 10.821, 163.645))
        JumpPointsGlobal.append(vect(-252.554, 10.81, 166.94))
        JumpPointsGlobal.append(vect(-265.834, 9.924, 172.464))
        JumpPointsGlobal.append(vect(-267.591, 11.911, 148.711))
        JumpPointsGlobal.append(vect(-277.185, 13.382, 173.22))
        JumpPointsGlobal.append(vect(-271.23, 11.633, 171.424))
        JumpPointsGlobal.append(vect(-278.708, 12.847, 163.942))
        JumpPointsGlobal.append(vect(-325.492, 11.913, 160.855))
        JumpPointsGlobal.append(vect(-331.501, 12.181, 161.391))
        JumpPointsGlobal.append(vect(-332.485, 8.744, 156.94))
    if getCurrentObjective() == 2:
        JumpPointsGlobal = []
        JumpPointsGlobal.append(vect(203.888, 13.548, 241.743))
        JumpPointsGlobal.append(vect(218.176, 19.3, 231.194))
        JumpPointsGlobal.append(vect(236.685, 17.826, 242.829))
        JumpPointsGlobal.append(vect(213.649, 17.826, 252.759))
        JumpPointsGlobal.append(vect(224.323, 17.903, 245.989))
        JumpPointsGlobal.append(vect(235.406, 13.548, 227.962))


rule "Navigation: Busan - Healthpacks":
    @Condition getCurrentMap() == Map.BUSAN
    @Condition isGameInProgress() == true
    
    if getCurrentObjective() == 0:
        HealthpackLocations = []
        HealthpackLocations.append(vect(51.722, 6.298, -75.969))
        HealthpackLocations.append(vect(22.743, 11.426, -95.352))
        HealthpackLocations.append(vect(79.743, 11.426, -94.972))
        HealthpackLocations.append(vect(82.321, 14.424, -137.873))
        HealthpackLocations.append(vect(21.279, 14.426, -137.461))
    if getCurrentObjective() == 1:
        HealthpackLocations = []
        HealthpackLocations.append(vect(-285.201, 12.528, 161.213))
        HealthpackLocations.append(vect(-306.068, 11.528, 183.07))
        HealthpackLocations.append(vect(-351.533, 11.528, 183.08))
        HealthpackLocations.append(vect(-328.647, 14.528, 179.533))
        HealthpackLocations.append(vect(-372.223, 12.528, 161.152))
        HealthpackLocations.append(vect(-374.961, 12.284, 139.886))
        HealthpackLocations.append(vect(-362.509, 10.528, 128.488))
        HealthpackLocations.append(vect(-294.266, 10.692, 128.278))
        HealthpackLocations.append(vect(-281.799, 12.391, 139.896))
    if getCurrentObjective() == 2:
        HealthpackLocations = []
        HealthpackLocations.append(vect(225.72, 17.819, 249.525))
        HealthpackLocations.append(vect(259.61, 12.796, 238.906))
        HealthpackLocations.append(vect(242.667, 10.796, 251.47))
        HealthpackLocations.append(vect(215.758, 10.794, 263.498))
        HealthpackLocations.append(vect(194.73, 12.794, 266.273))
        HealthpackLocations.append(vect(184.113, 11.796, 268.982))
        HealthpackLocations.append(vect(177.121, 14.796, 226.612))
        HealthpackLocations.append(vect(268.563, 11.796, 232.534))
        HealthpackLocations.append(vect(197.785, 17.794, 222.999))
        HealthpackLocations.append(vect(225.616, 17.794, 210.846))
        HealthpackLocations.append(vect(243.053, 14.794, 198.76))
        HealthpackLocations.append(vect(208.87, 10.794, 210.671))


/*
rule "===== NAVIGATION: ILIOS =====":
*/

rule "Navigation: Ilios - Waypoints":
    @Condition getCurrentMap() == Map.ILIOS
    @Condition isGameInProgress() == true
    
    if getCurrentObjective() == 0:
        Waypoints = []
        Waypoints.append(vect(329.868, -22.747, -62.7))
        Waypoints.append(vect(329.647, -24.279, 23.745))
        Waypoints.append(vect(325.679, -21.454, 36.43))
        Waypoints.append(vect(329.12, -24.009, 14.217))
        Waypoints.append(vect(325.531, -23.338, 4.074))
        Waypoints.append(vect(318.727, -22.343, -16.614))
        Waypoints.append(vect(316.351, -22.289, -21.742))
        Waypoints.append(vect(326.514, -22.289, -20.254))
        Waypoints.append(vect(324.782, -22.289, -24.954))
        Waypoints.append(vect(334.252, -22.29, -24.004))
        Waypoints.append(vect(330.815, -22.29, -30.722))
        Waypoints.append(vect(340.344, -23.366, -11.065))
        Waypoints.append(vect(343.197, -23.348, -2.942))
        Waypoints.append(vect(331.348, -23.29, -1.356))
        Waypoints.append(vect(325.726, -19.29, -14.49))
        Waypoints.append(vect(343.071, -23.291, 0.281))
        Waypoints.append(vect(340.592, -23.314, 12.871))
        Waypoints.append(vect(346.022, -24.273, 19.797))
        Waypoints.append(vect(354.472, -23.289, -0.744))
        Waypoints.append(vect(365.138, -26.292, -5.527))
        Waypoints.append(vect(361.922, -26.289, -12.872))
        Waypoints.append(vect(355.485, -26.289, -10.082))
        Waypoints.append(vect(358.176, -26.289, -21.332))
        Waypoints.append(vect(353.831, -24.29, -32.4))
        Waypoints.append(vect(360.139, -24.232, -42.674))
        Waypoints.append(vect(356.583, -24.29, -45.884))
        Waypoints.append(vect(354.714, -24.29, -51.033))
        Waypoints.append(vect(352.27, -24.29, -55.807))
        Waypoints.append(vect(355.33, -24.29, -57.142))
        Waypoints.append(vect(359.187, -24.29, -55.235))
        Waypoints.append(vect(371.233, -25.693, -57.278))
        Waypoints.append(vect(367.284, -27.293, -56.316))
        Waypoints.append(vect(369.706, -26.289, -44.704))
        Waypoints.append(vect(365.844, -24.919, -43.191))
        Waypoints.append(vect(361.711, -26.289, -64.409))
        Waypoints.append(vect(357.666, -24.828, -62.474))
        Waypoints.append(vect(345.471, -24.29, -50.83))
        Waypoints.append(vect(347.415, -24.29, -46.574))
        Waypoints.append(vect(349.725, -24.29, -41.823))
        Waypoints.append(vect(352.414, -24.29, -32.152))
        Waypoints.append(vect(345.37, -22.289, -28.873))
        Waypoints.append(vect(341.477, -22.289, -26.973))
        Waypoints.append(vect(345.023, -22.37, -18.463))
        Waypoints.append(vect(346.976, -22.792, -13.755))
        Waypoints.append(vect(348.787, -23.289, -7.955))
        Waypoints.append(vect(338.49, -22.333, -35.025))
        Waypoints.append(vect(334.067, -22.338, -41.583))
        Waypoints.append(vect(332.843, -22.341, -47.639))
        Waypoints.append(vect(327.318, -22.317, -38.793))
        Waypoints.append(vect(327.318, -22.317, -38.793))
        Waypoints.append(vect(318.796, -22.317, -35.609))
        Waypoints.append(vect(320.978, -22.317, -40.519))
        Waypoints.append(vect(273.231, -21.451, -91.949))
        Waypoints.append(vect(289.76, -24.246, -82.94))
        Waypoints.append(vect(296.78, -24.154, -86.788))
        Waypoints.append(vect(302.164, -24.213, -93.063))
        Waypoints.append(vect(292.608, -24.316, -94.697))
        Waypoints.append(vect(317.366, -23.32, -85.498))
        Waypoints.append(vect(331.081, -26.293, -87.652))
        Waypoints.append(vect(333.458, -26.289, -80.929))
        Waypoints.append(vect(328.33, -26.289, -78.477))
        Waypoints.append(vect(337.27, -26.289, -71.787))
        Waypoints.append(vect(340.852, -24.289, -63.396))
        Waypoints.append(vect(352.02, -24.289, -60.05))
        Waypoints.append(vect(340.047, -24.289, -61.217))
        Waypoints.append(vect(332.94, -22.289, -58.484))
        Waypoints.append(vect(329.261, -22.289, -57.068))
        Waypoints.append(vect(323.762, -22.793, -69.454))
        Waypoints.append(vect(319.407, -23.29, -76.886))
        Waypoints.append(vect(310.548, -23.29, -78.1))
        Waypoints.append(vect(299.866, -23.458, -84.824))
        Waypoints.append(vect(290.637, -24.008, -77.292))
        Waypoints.append(vect(297.217, -23.329, -65.482))
        Waypoints.append(vect(306.377, -23.289, -70.053))
        Waypoints.append(vect(304.672, -23.347, -65.382))
        Waypoints.append(vect(321.544, -23.289, -75.201))
        Waypoints.append(vect(329.582, -22.289, -56.539))
        Waypoints.append(vect(335.797, -22.708, -59.807))
        Waypoints.append(vect(321.632, -22.289, -53.896))
        Waypoints.append(vect(305.242, -22.316, -47.889))
        Waypoints.append(vect(313.254, -22.289, -51.275))
        Waypoints.append(vect(307.744, -22.289, -42.899))
        Waypoints.append(vect(318.189, -22.293, -45.729))
        Waypoints.append(vect(318.189, -22.293, -45.729))
        Waypoints.append(vect(327.623, -23.026, -61.49))
        Waypoints.append(vect(190.423, 3.201, 233.164))
        Waypoints.append(vect(344.929, -17.139, -24.017))
        Waypoints.append(vect(344.046, -17.139, -30.356))
        Waypoints.append(vect(324.101, -17.14, -61.169))
        Waypoints.append(vect(329.398, -17.14, -61.352))
        Waypoints.append(vect(335.102, -17.139, -56.185))
    if getCurrentObjective() == 1:
        Waypoints = []
        Waypoints.append(vect(-187.885, 1.719, -23.206))
        Waypoints.append(vect(-155.308, -1.345, -86.401))
        Waypoints.append(vect(-165.466, -3.645, -65.874))
        Waypoints.append(vect(-152.262, -1.358, -93.325))
        Waypoints.append(vect(-170.697, -3.498, -61.427))
        Waypoints.append(vect(-173.584, -1.519, -54.729))
        Waypoints.append(vect(-167.978, -3.237, -59.5))
        Waypoints.append(vect(-177.137, 0.412, -49.528))
        Waypoints.append(vect(-174.714, 0.446, -42.501))
        Waypoints.append(vect(-171.71, 0.446, -37.435))
        Waypoints.append(vect(-174.943, 0.446, -33.844))
        Waypoints.append(vect(-185.106, 0.364, -44.162))
        Waypoints.append(vect(-192.083, 0.447, -51.006))
        Waypoints.append(vect(-187.738, 0.444, -55.538))
        Waypoints.append(vect(-196.776, 0.447, -56.098))
        Waypoints.append(vect(-203.017, 2.447, -47.866))
        Waypoints.append(vect(-205.427, 2.447, -44.828))
        Waypoints.append(vect(-199.074, 2.447, -38.814))
        Waypoints.append(vect(-203.665, 2.447, -34.339))
        Waypoints.append(vect(-209.135, 2.447, -36.49))
        Waypoints.append(vect(-215.979, 0.443, -42.104))
        Waypoints.append(vect(-225.448, 0.443, -32.717))
        Waypoints.append(vect(-220.037, 1.447, -28.019))
        Waypoints.append(vect(-215.524, 2.446, -32.866))
        Waypoints.append(vect(-207.448, 1.443, -27.576))
        Waypoints.append(vect(-216.394, 1.447, -24.408))
        Waypoints.append(vect(-214.147, 1.447, -22.024))
        Waypoints.append(vect(-209.257, 1.447, -24.948))
        Waypoints.append(vect(-226.12, 2.446, -22.398))
        Waypoints.append(vect(-229.063, 2.446, -18.356))
        Waypoints.append(vect(-233.44, 0.443, -23.424))
        Waypoints.append(vect(-228.624, 2.447, -15.401))
        Waypoints.append(vect(-237.401, 2.447, -13.085))
        Waypoints.append(vect(-240.604, 2.447, -10.218))
        Waypoints.append(vect(-247.885, 0.444, -4.684))
        Waypoints.append(vect(-243.507, 0.447, -0.123))
        Waypoints.append(vect(-247.739, 0.446, 3.972))
        Waypoints.append(vect(-242.582, 0.446, 7.828))
        Waypoints.append(vect(-237.736, 0.446, 4.78))
        Waypoints.append(vect(-225.887, 2.389, 4.451))
        Waypoints.append(vect(-219.255, 2.385, -2.229))
        Waypoints.append(vect(-223.485, 2.428, -9.093))
        Waypoints.append(vect(-226.576, 2.447, -11.263))
        Waypoints.append(vect(-231, 2.447, -7.145))
        Waypoints.append(vect(-219.07, 1.444, -12.319))
        Waypoints.append(vect(-220.521, 2.365, 1.061))
        Waypoints.append(vect(-212.505, 2.458, 8.64))
        Waypoints.append(vect(-206.15, 2.447, 1.891))
        Waypoints.append(vect(-194.504, 2.459, -1.317))
        Waypoints.append(vect(-201.038, 2.459, -4.416))
        Waypoints.append(vect(-200.573, 2.459, -8.651))
        Waypoints.append(vect(-203.043, 1.623, -11.139))
        Waypoints.append(vect(-208.868, 1.443, -7.904))
        Waypoints.append(vect(-197.29, 1.444, -19.008))
        Waypoints.append(vect(-191.679, 2.446, -12.638))
        Waypoints.append(vect(-188.672, 2.446, -10.053))
        Waypoints.append(vect(-192.752, 2.459, -6.944))
        Waypoints.append(vect(-196.936, 2.459, -8.973))
        Waypoints.append(vect(-183.193, 2.447, -20.557))
        Waypoints.append(vect(-190.188, 2.398, -27.652))
        Waypoints.append(vect(-185.517, 2.447, -8.364))
        Waypoints.append(vect(-173.089, 1.239, -19.942))
        Waypoints.append(vect(-172.871, 0.445, -26.338))
        Waypoints.append(vect(-201.009, 2.447, 7.934))
        Waypoints.append(vect(-212.188, 0.783, 19.308))
        Waypoints.append(vect(-224.047, 0.444, 16.931))
        Waypoints.append(vect(-231.309, 0.444, 20.891))
        Waypoints.append(vect(-237.808, 0.444, 15.162))
        Waypoints.append(vect(-242.98, -0.082, 17.329))
        Waypoints.append(vect(-248.728, -1.457, 22.269))
        Waypoints.append(vect(-262.005, -3.642, 29.217))
        Waypoints.append(vect(-277.089, -1.346, 35.702))
    if getCurrentObjective() == 2:
        Waypoints = []
        Waypoints.append(vect(-72.339, 63.587, -158.749))
        Waypoints.append(vect(129.762, 63.754, -158.901))
        Waypoints.append(vect(119.259, 61.666, -158.458))
        Waypoints.append(vect(107.328, 61.843, -151.153))
        Waypoints.append(vect(102.489, 61.822, -150.942))
        Waypoints.append(vect(95.525, 61.824, -149.789))
        Waypoints.append(vect(93.257, 61.666, -156.596))
        Waypoints.append(vect(93.981, 61.669, -161.571))
        Waypoints.append(vect(105.447, 61.669, -165.096))
        Waypoints.append(vect(98.241, 62.918, -165.496))
        Waypoints.append(vect(95.162, 59.666, -169.863))
        Waypoints.append(vect(95.197, 59.666, -178.994))
        Waypoints.append(vect(84.445, 59.669, -175.017))
        Waypoints.append(vect(88.421, 59.669, -183.22))
        Waypoints.append(vect(79.396, 59.669, -183.465))
        Waypoints.append(vect(58.398, 61.669, -183.181))
        Waypoints.append(vect(53.357, 61.669, -183.416))
        Waypoints.append(vect(52.648, 61.669, -173.956))
        Waypoints.append(vect(53.4, 61.669, -171.105))
        Waypoints.append(vect(61.246, 61.669, -174.188))
        Waypoints.append(vect(62.548, 61.669, -178.137))
        Waypoints.append(vect(72.269, 59.665, -177.879))
        Waypoints.append(vect(72.028, 59.665, -171.125))
        Waypoints.append(vect(62.521, 61.669, -172.328))
        Waypoints.append(vect(73.055, 59.669, -164.957))
        Waypoints.append(vect(78.779, 59.669, -165.51))
        Waypoints.append(vect(84.01, 59.669, -156.194))
        Waypoints.append(vect(74.317, 59.912, -156.456))
        Waypoints.append(vect(83.348, 59.669, -146.86))
        Waypoints.append(vect(80.643, 59.669, -142.641))
        Waypoints.append(vect(70.823, 61.669, -142.999))
        Waypoints.append(vect(64.168, 61.669, -142.887))
        Waypoints.append(vect(63.923, 61.669, -151.474))
        Waypoints.append(vect(67.946, 61.668, -156.349))
        Waypoints.append(vect(67.946, 61.668, -156.349))
        Waypoints.append(vect(53.564, 61.668, -165.672))
        Waypoints.append(vect(46.182, 61.668, -165.444))
        Waypoints.append(vect(46.369, 61.668, -159.643))
        Waypoints.append(vect(45.956, 61.668, -151.724))
        Waypoints.append(vect(54.467, 61.669, -150.802))
        Waypoints.append(vect(53.797, 61.668, -142.946))
        Waypoints.append(vect(49.392, 61.668, -140.005))
        Waypoints.append(vect(45.287, 61.668, -145.79))
        Waypoints.append(vect(39.967, 62.623, -145.599))
        Waypoints.append(vect(16.182, 62.14, -145.416))
        Waypoints.append(vect(33.479, 58.665, -142.644))
        Waypoints.append(vect(27.89, 58.665, -141.872))
        Waypoints.append(vect(23.898, 58.666, -142.291))
        Waypoints.append(vect(23.687, 58.666, -153.28))
        Waypoints.append(vect(33.814, 58.665, -152.77))
        Waypoints.append(vect(41.641, 61.821, -153.56))
        Waypoints.append(vect(43.995, 61.669, -168.614))
        Waypoints.append(vect(45.121, 61.669, -173.926))
        Waypoints.append(vect(37.12, 61.669, -173.806))
        Waypoints.append(vect(37.898, 61.662, -167.398))
        Waypoints.append(vect(35.139, 61.899, -165.806))
        Waypoints.append(vect(35.101, 58.747, -159.603))
        Waypoints.append(vect(28.356, 61.942, -172.174))
        Waypoints.append(vect(27.844, 61.931, -179.305))
        Waypoints.append(vect(20.001, 61.668, -172.51))
        Waypoints.append(vect(20.22, 61.692, -166.972))
        Waypoints.append(vect(21.496, 58.666, -158.754))
        Waypoints.append(vect(28.819, 58.666, -161.366))
        Waypoints.append(vect(28.479, 58.666, -157.226))
        Waypoints.append(vect(28.479, 58.666, -157.226))
        Waypoints.append(vect(24.12, 58.666, -156.453))
        Waypoints.append(vect(21.895, 58.822, -153.784))
        Waypoints.append(vect(16.729, 62.06, -153.626))
        Waypoints.append(vect(11.26, 61.669, -154.561))
        Waypoints.append(vect(11.319, 61.669, -145.116))
        Waypoints.append(vect(7.84, 61.669, -140.052))
        Waypoints.append(vect(2.047, 61.627, -142.817))
        Waypoints.append(vect(-7.36, 61.669, -143.095))
        Waypoints.append(vect(-17.563, 61.668, -142.349))
        Waypoints.append(vect(-25.486, 59.666, -142.294))
        Waypoints.append(vect(-25.097, 59.669, -156.623))
        Waypoints.append(vect(-33.968, 61.669, -156.764))
        Waypoints.append(vect(-33.968, 61.669, -156.764))
        Waypoints.append(vect(-53.913, 61.914, -150.938))
        Waypoints.append(vect(-64.374, 63.151, -158.874))
        Waypoints.append(vect(-52.386, 61.666, -166.635))
        Waypoints.append(vect(-41.328, 61.668, -161.284))
        Waypoints.append(vect(-34.866, 59.665, -169.442))
        Waypoints.append(vect(-22.102, 59.665, -177.659))
        Waypoints.append(vect(-22.288, 59.666, -169.002))
        Waypoints.append(vect(-20.4, 59.669, -161.197))
        Waypoints.append(vect(-15.381, 59.669, -165.212))
        Waypoints.append(vect(-14.971, 59.668, -171.094))
        Waypoints.append(vect(-14.658, 59.668, -177.632))
        Waypoints.append(vect(-23.598, 59.669, -183.727))
        Waypoints.append(vect(-2.22, 61.668, -183.095))
        Waypoints.append(vect(-6.897, 61.668, -178.652))
        Waypoints.append(vect(-2.62, 61.668, -177.582))
        Waypoints.append(vect(-2.033, 61.668, -172.45))
        Waypoints.append(vect(-6.182, 61.668, -171.625))
        Waypoints.append(vect(3.434, 61.669, -171.664))
        Waypoints.append(vect(3.958, 61.669, -182.318))
        Waypoints.append(vect(4.115, 61.669, -173.704))
        Waypoints.append(vect(12.116, 61.669, -173.854))
        Waypoints.append(vect(12.705, 61.669, -168.649))


rule "Navigation: Ilios - Jumps":
    @Event eachPlayer
    @Condition getCurrentMap() == Map.ILIOS
    @Condition isGameInProgress() == true
    
    if getCurrentObjective() == 0:
        JumpPointsGlobal = []
        JumpPointsGlobal.append(vect(370.57, -27.817, -56.945))
        JumpPointsGlobal.append(vect(352.157, -17.186, -25.227))
        JumpPointsGlobal.append(vect(363.147, -16.502, -46.742))
        JumpPointsGlobal.append(vect(344.898, -17.293, -32.208))
        JumpPointsGlobal.append(vect(359.587, -16.502, -42.987))
        JumpPointsGlobal.append(vect(354.384, -16.502, -44.722))
        JumpPointsGlobal.append(vect(350.88, -16.502, -53.953))
        JumpPointsGlobal.append(vect(358.446, -16.502, -58.091))
    if getCurrentObjective() == 1:
        JumpPointsGlobal = []
        JumpPointsGlobal.append(vect(-202.144, 6.438, -45.567))
    if getCurrentObjective() == 2:
        JumpPointsGlobal = []
        JumpPointsGlobal.append(vect(51.114, 61.045, -170.708))
        JumpPointsGlobal.append(vect(23.873, 58.668, -162.271))
        JumpPointsGlobal.append(vect(33.019, 58.668, -162.555))
        JumpPointsGlobal.append(vect(16.171, 61.441, -159.734))
        JumpPointsGlobal.append(vect(40.822, 61.44, -160.153))


rule "Navigation: Ilios - Healthpacks":
    @Condition getCurrentMap() == Map.ILIOS
    @Condition isGameInProgress() == true
    
    if getCurrentObjective() == 0:
        HealthpackLocations = []
        HealthpackLocations.append(vect(354.209, -27.185, -9.296))
        HealthpackLocations.append(vect(346.038, -23.099, -23.449))
        HealthpackLocations.append(vect(325.377, -27.185, -78.337))
        HealthpackLocations.append(vect(329.527, -23.185, -62.388))
        HealthpackLocations.append(vect(367.168, -28.185, -55.864))
        HealthpackLocations.append(vect(319.26, -23.21, -35.866))
    if getCurrentObjective() == 1:
        HealthpackLocations = []
        HealthpackLocations.append(vect(-178.931, 0.459, -39.598))
        HealthpackLocations.append(vect(-194.073, 2.459, -1.966))
        HealthpackLocations.append(vect(-212.922, 2.458, 8.965))
        HealthpackLocations.append(vect(-182.837, 2.447, -21.199))
        HealthpackLocations.append(vect(-231.29, 0.463, 12.772))
        HealthpackLocations.append(vect(-230.958, 2.447, -6.454))
        HealthpackLocations.append(vect(-227.361, 0.443, -35.207))
        HealthpackLocations.append(vect(-199.303, 2.447, -39.211))
    if getCurrentObjective() == 2:
        HealthpackLocations = []
        HealthpackLocations.append(vect(62.24, 61.668, -174.55))
        HealthpackLocations.append(vect(-4.47, 61.669, -174.619))
        HealthpackLocations.append(vect(-23.326, 59.669, -156.861))
        HealthpackLocations.append(vect(-5.421, 61.666, -140.245))
        HealthpackLocations.append(vect(63.445, 61.669, -140.517))
        HealthpackLocations.append(vect(80.479, 59.666, -156.508))
        HealthpackLocations.append(vect(28.704, 61.93, -177.607))


/*
rule "===== NAVIGATION: LIJIANG TOWER =====":
*/

rule "Navigation: Lijiang Tower - Waypoints":
    @Condition (getCurrentMap() == Map.LIJIANG_TOWER or getCurrentMap() == Map.LIJIANG_TOWER_LNY) == true
    @Condition isGameInProgress() == true
    
    if getCurrentObjective() == 0:
        Waypoints = []
        Waypoints.append(vect(48.411, 3.349, -41.642))
        Waypoints.append(vect(37.788, 2.872, -42.043))
        Waypoints.append(vect(29.968, 1.348, -42.119))
        Waypoints.append(vect(60.669, 3.348, -34.315))
        Waypoints.append(vect(25.651, 1.348, -39.936))
        Waypoints.append(vect(18.354, 1.211, -40.729))
        Waypoints.append(vect(18.756, 1.348, -50.839))
        Waypoints.append(vect(27.629, -1.612, -54.271))
        Waypoints.append(vect(15.114, -1.649, -57.362))
        Waypoints.append(vect(11.938, 0.432, -75.489))
        Waypoints.append(vect(15.616, 0.352, -67.293))
        Waypoints.append(vect(5.075, 0.352, -66.238))
        Waypoints.append(vect(-0.113, 0.352, -66.067))
        Waypoints.append(vect(-3.053, 0.352, -61.179))
        Waypoints.append(vect(-1.109, 0.352, -56.23))
        Waypoints.append(vect(5.867, 0.352, -57.027))
        Waypoints.append(vect(6.381, 0.352, -63.703))
        Waypoints.append(vect(1.147, 0.352, -71.036))
        Waypoints.append(vect(7.021, 0.352, -76.019))
        Waypoints.append(vect(6.004, -0.651, -81.268))
        Waypoints.append(vect(-4.808, -0.651, -81.109))
        Waypoints.append(vect(-3.225, 0.352, -75.504))
        Waypoints.append(vect(-11.011, 0.352, -72.941))
        Waypoints.append(vect(-10.091, 0.352, -66.775))
        Waypoints.append(vect(-13.227, -1.651, -55.824))
        Waypoints.append(vect(-26.371, -1.652, -54.017))
        Waypoints.append(vect(-26.371, -1.652, -54.017))
        Waypoints.append(vect(-16.119, 1.211, -40.62))
        Waypoints.append(vect(-24.771, 1.351, -39.692))
        Waypoints.append(vect(-31.221, 1.352, -41.946))
        Waypoints.append(vect(-24.189, 1.348, -42.333))
        Waypoints.append(vect(-44.021, 3.351, -41.647))
        Waypoints.append(vect(-53.333, 3.211, -37.247))
        Waypoints.append(vect(-61.939, 3.349, -32.009))
        Waypoints.append(vect(-50.225, 3.211, -45.753))
        Waypoints.append(vect(-39.953, 7.359, -45.86))
        Waypoints.append(vect(-25.46, 7.352, -40.864))
        Waypoints.append(vect(-22.7, 7.352, -29.12))
        Waypoints.append(vect(-23.425, 7.351, -21.687))
        Waypoints.append(vect(-24.317, 7.351, -13.912))
        Waypoints.append(vect(-18.275, 7.351, -9.026))
        Waypoints.append(vect(-15.444, 7.422, -17.578))
        Waypoints.append(vect(-47.347, 5.348, -13.826))
        Waypoints.append(vect(-47.515, 3.211, -21.899))
        Waypoints.append(vect(-55.34, 3.211, -22.01))
        Waypoints.append(vect(-50.957, 3.349, -28.734))
        Waypoints.append(vect(-38.277, 1.211, -22.145))
        Waypoints.append(vect(-37.597, 1.211, -30.198))
        Waypoints.append(vect(-26.233, 1.351, -36.174))
        Waypoints.append(vect(-25.839, 1.351, -26.858))
        Waypoints.append(vect(-24.813, 1.351, -17.601))
        Waypoints.append(vect(-14.348, 1.351, -19.133))
        Waypoints.append(vect(-17.118, 1.349, -14.801))
        Waypoints.append(vect(-15.879, 1.349, -10.111))
        Waypoints.append(vect(-5.004, 1.358, -12.046))
        Waypoints.append(vect(1.127, 1.351, -14.854))
        Waypoints.append(vect(1.146, 0.211, -25.184))
        Waypoints.append(vect(-10.268, 1.109, -24.859))
        Waypoints.append(vect(-15.777, 1.211, -32.222))
        Waypoints.append(vect(-9.837, 0.893, -34.644))
        Waypoints.append(vect(1.24, 0.211, -35.105))
        Waypoints.append(vect(-4.748, 0.349, -37.375))
        Waypoints.append(vect(-3.549, 0.372, -47.264))
        Waypoints.append(vect(5.445, 0.372, -48.129))
        Waypoints.append(vect(7.002, 0.211, -36.978))
        Waypoints.append(vect(13.634, 1.351, -34.99))
        Waypoints.append(vect(18.367, 1.348, -28.761))
        Waypoints.append(vect(15.075, 1.211, -24.08))
        Waypoints.append(vect(7.698, 0.211, -25.007))
        Waypoints.append(vect(7.855, 1.352, -12.165))
        Waypoints.append(vect(18.376, 1.35, -10.092))
        Waypoints.append(vect(10.127, 1.35, -17.335))
        Waypoints.append(vect(26.172, 1.351, -16.627))
        Waypoints.append(vect(27.791, 1.351, -27.533))
        Waypoints.append(vect(27.616, 1.351, -35.005))
        Waypoints.append(vect(37.337, 1.351, -34.574))
        Waypoints.append(vect(49.744, 2.846, -36.703))
        Waypoints.append(vect(35.787, 1.211, -28.334))
        Waypoints.append(vect(42.332, 1.348, -21.934))
        Waypoints.append(vect(48.638, 3.211, -21.668))
        Waypoints.append(vect(53.433, 3.211, -21.534))
        Waypoints.append(vect(53.868, 3.348, -29.854))
        Waypoints.append(vect(49.756, 5.349, -13.449))
        Waypoints.append(vect(26.979, 7.351, -13.877))
        Waypoints.append(vect(20.541, 7.351, -9.005))
        Waypoints.append(vect(17.113, 7.352, -12.271))
        Waypoints.append(vect(17.657, 7.351, -16.999))
        Waypoints.append(vect(24.805, 7.352, -26.822))
        Waypoints.append(vect(26.222, 7.39, -45.539))
        Waypoints.append(vect(41.587, 7.351, -46.105))
        Waypoints.append(vect(51.971, 3.348, -43.969))
        Waypoints.append(vect(-69.207, 5.83, -30.877))
        Waypoints.append(vect(24.003, 0.594, -54.419))
        Waypoints.append(vect(7.546, -0.072, -30.9))
        Waypoints.append(vect(-8.639, 0.956, -31.186))
        Waypoints.append(vect(-23.099, 0.171, -53.778))
        Waypoints.append(vect(-9.767, 0.609, -65.011))
        Waypoints.append(vect(-5.506, 0.134, -65.477))
        Waypoints.append(vect(-18.384, 0.524, -51.133))
        Waypoints.append(vect(-12.063, -2.44, -58.622))
    if getCurrentObjective() == 1:
        Waypoints = []
        Waypoints.append(vect(11.961, 96.78, 129.132))
        Waypoints.append(vect(71.559, 98.69, 145.591))
        Waypoints.append(vect(78.318, 98.264, 144.688))
        Waypoints.append(vect(60.759, 95.691, 143.992))
        Waypoints.append(vect(58.224, 95.7, 168.501))
        Waypoints.append(vect(47.643, 99.7, 168.07))
        Waypoints.append(vect(-0.077, 95.7, 177.821))
        Waypoints.append(vect(34.274, 99.7, 163.876))
        Waypoints.append(vect(25.799, 99.7, 164.311))
        Waypoints.append(vect(16.31, 95.7, 170.217))
        Waypoints.append(vect(25.971, 95.7, 171.612))
        Waypoints.append(vect(33.313, 95.7, 165.545))
        Waypoints.append(vect(33.746, 99.7, 180.383))
        Waypoints.append(vect(30.038, 95.7, 161.645))
        Waypoints.append(vect(36.41, 96.682, 160.08))
        Waypoints.append(vect(45.632, 96.7, 151.638))
        Waypoints.append(vect(34.737, 96.693, 149.602))
        Waypoints.append(vect(30.716, 95.699, 148.248))
        Waypoints.append(vect(23.736, 95.699, 144.945))
        Waypoints.append(vect(20.346, 97.7, 133.621))
        Waypoints.append(vect(11.423, 96.7, 127.551))
        Waypoints.append(vect(12.649, 96.7, 115.729))
        Waypoints.append(vect(5.94, 97.7, 116.037))
        Waypoints.append(vect(4.21, 97.7, 107.594))
        Waypoints.append(vect(-4.517, 97.7, 107.727))
        Waypoints.append(vect(0.282, 98.615, 116.674))
        Waypoints.append(vect(-6.369, 97.7, 116.191))
        Waypoints.append(vect(-12.184, 96.886, 116.684))
        Waypoints.append(vect(-12.88, 96.7, 127.278))
        Waypoints.append(vect(0.171, 96.7, 126.669))
        Waypoints.append(vect(0.209, 95.75, 133.517))
        Waypoints.append(vect(-0.16, 95.7, 142.954))
        Waypoints.append(vect(-3.819, 95.7, 145.398))
        Waypoints.append(vect(-3.213, 95.7, 142.199))
        Waypoints.append(vect(3.465, 95.7, 141.874))
        Waypoints.append(vect(4.056, 95.7, 158.387))
        Waypoints.append(vect(-0.303, 95.7, 153.265))
        Waypoints.append(vect(-4.387, 95.7, 158.096))
        #Waypoints.append(vect(-0.052, 95.876, 168.663))
        Waypoints.append(vect(-0.077, 95.7, 177.821))
        Waypoints.append(vect(7.398, 95.7, 177.989))
        Waypoints.append(vect(-0.094, 95.7, 188.207))
        Waypoints.append(vect(-2.823, 95.7, 178.393))
        Waypoints.append(vect(-7.263, 95.7, 178.1))
        Waypoints.append(vect(-26.224, 95.75, 171.962))
        Waypoints.append(vect(-29.905, 95.75, 168.155))
        Waypoints.append(vect(-33.856, 95.75, 169.047))
        Waypoints.append(vect(-33.575, 99.7, 179.69))
        Waypoints.append(vect(-26.275, 99.7, 180.097))
        Waypoints.append(vect(-25.933, 99.7, 165.193))
        Waypoints.append(vect(-47.933, 99.7, 163.855))
        Waypoints.append(vect(-48.05, 99.7, 168.13))
        Waypoints.append(vect(-58.313, 95.7, 168.016))
        Waypoints.append(vect(-56.028, 95.7, 158.836))
        Waypoints.append(vect(-46.725, 95.7, 160.29))
        Waypoints.append(vect(-31.155, 95.7, 158.527))
        Waypoints.append(vect(-35.483, 96.7, 149.867))
        Waypoints.append(vect(-47.047, 96.599, 145.95))
        Waypoints.append(vect(-60.848, 95.687, 142.31))
        Waypoints.append(vect(-20.645, 97.7, 135.006))
        Waypoints.append(vect(-77.464, 98.264, 145.392))
        Waypoints.append(vect(-72.54, 98.278, 145.691))
        Waypoints.append(vect(27.937, 99.7, 178.58))
        Waypoints.append(vect(32.873, 99.7, 167.654))
        Waypoints.append(vect(27.885, 95.655, 170.113))
    if getCurrentObjective() == 2:
        Waypoints = []
        Waypoints.append(vect(-5.109, 268.757, 280.341))
        Waypoints.append(vect(60.315, 269.005, 341.581))
        Waypoints.append(vect(53.656, 268.313, 334.773))
        Waypoints.append(vect(39.506, 268.427, 320.696))
        Waypoints.append(vect(27.425, 268.426, 308.946))
        Waypoints.append(vect(23.551, 269.439, 304.861))
        Waypoints.append(vect(21.801, 268.423, 303.038))
        Waypoints.append(vect(13.1, 270.427, 293.912))
        Waypoints.append(vect(4.957, 271.424, 297.946))
        Waypoints.append(vect(-0.021, 271.424, 297.587))
        Waypoints.append(vect(0.028, 271.424, 304.973))
        Waypoints.append(vect(8.661, 271.424, 305.411))
        Waypoints.append(vect(-8.274, 271.424, 305.163))
        Waypoints.append(vect(-9.793, 271.424, 297.007))
        Waypoints.append(vect(0.147, 271.426, 313.598))
        Waypoints.append(vect(5.537, 271.426, 320.939))
        Waypoints.append(vect(14.925, 271.376, 320.756))
        Waypoints.append(vect(20.358, 269.361, 313.805))
        Waypoints.append(vect(4.256, 271.426, 322.821))
        Waypoints.append(vect(-7.524, 271.423, 320.822))
        Waypoints.append(vect(-2.7, 271.423, 313.403))
        Waypoints.append(vect(-10.568, 271.547, 321.621))
        Waypoints.append(vect(-17.533, 271.423, 317.518))
        Waypoints.append(vect(-26.325, 268.423, 307.675))
        Waypoints.append(vect(-21.273, 268.423, 302.708))
        Waypoints.append(vect(-32.438, 268.547, 313.467))
        Waypoints.append(vect(-28.018, 268.426, 297.091))
        Waypoints.append(vect(-12.686, 270.426, 294.225))
        Waypoints.append(vect(-17.26, 268.424, 287.968))
        Waypoints.append(vect(-17.93, 268.424, 273.244))
        Waypoints.append(vect(-20.393, 268.427, 270.468))
        Waypoints.append(vect(-14.289, 271.427, 264.259))
        Waypoints.append(vect(-3.467, 271.427, 260.494))
        Waypoints.append(vect(3.318, 271.427, 260.496))
        Waypoints.append(vect(13.474, 271.427, 262.61))
        Waypoints.append(vect(19.97, 268.423, 270.574))
        Waypoints.append(vect(16.625, 268.427, 274.866))
        Waypoints.append(vect(17.661, 268.427, 283.35))
        Waypoints.append(vect(17.161, 268.427, 288.945))
        Waypoints.append(vect(26.783, 268.427, 296.605))
        Waypoints.append(vect(11.17, 268.593, 275.447))
        Waypoints.append(vect(3.19, 268.593, 271.349))
        Waypoints.append(vect(-10.442, 268.593, 273.053))
        Waypoints.append(vect(-11.567, 268.593, 281.153))
        Waypoints.append(vect(-5.377, 268.757, 284.664))
        Waypoints.append(vect(0.057, 268.757, 284.995))
        Waypoints.append(vect(5.397, 268.757, 282.512))
        Waypoints.append(vect(3.557, 268.757, 277.935))
        Waypoints.append(vect(-2.172, 268.757, 274.819))
        Waypoints.append(vect(55.245, 267.64, 342.661))
        Waypoints.append(vect(-63.396, 268.705, 349.018))
        Waypoints.append(vect(-56.668, 267.701, 340.648))
        Waypoints.append(vect(-47.066, 266.199, 328.46))
        Waypoints.append(vect(-26.043, 271.199, 345.747))
        Waypoints.append(vect(-25.393, 271.202, 339.185))
        Waypoints.append(vect(-14.846, 271.151, 330.998))
        Waypoints.append(vect(-13.765, 271.151, 320.517))
        Waypoints.append(vect(-38.219, 268.202, 295.146))
        Waypoints.append(vect(-34.728, 268.202, 298.022))
        Waypoints.append(vect(38.217, 268.199, 295.352))
        Waypoints.append(vect(34.683, 268.202, 298.591))
        Waypoints.append(vect(27.016, 271.198, 343.073))
        Waypoints.append(vect(18.221, 271.151, 333.376))
        Waypoints.append(vect(15.165, 271.151, 331.714))
        Waypoints.append(vect(14.472, 271.151, 320.746))
        Waypoints.append(vect(-3.914, 279.201, 302.165))
        Waypoints.append(vect(0.121, 279.201, 297.518))
        Waypoints.append(vect(0.086, 279.201, 293.341))
        Waypoints.append(vect(-3.402, 271.198, 259.547))
        Waypoints.append(vect(63.561, 267.639, 337.618))
        Waypoints.append(vect(60.221, 268.647, 349.583))
        Waypoints.append(vect(49.273, 7.443, -5.441))
        Waypoints.append(vect(-46.797, 7.446, -5.746))
        Waypoints.append(vect(-60.082, 7.446, -5.322))
        Waypoints.append(vect(62.381, 7.443, -4.997))


rule "Navigation: Lijiang Tower - Jumps":
    @Event eachPlayer
    @Condition (getCurrentMap() == Map.LIJIANG_TOWER or getCurrentMap() == Map.LIJIANG_TOWER_LNY) == true
    @Condition isGameInProgress() == true
    
    if getCurrentObjective() == 0:
        JumpPointsGlobal = []
        JumpPointsGlobal.append(vect(-59.925, 3.169, -34.26))
        JumpPointsGlobal.append(vect(-14.604, -0.605, -61.834))
        JumpPointsGlobal.append(vect(-16.586, -1.545, -60.006))
        JumpPointsGlobal.append(vect(16.495, -0.835, -61.379))
        JumpPointsGlobal.append(vect(18.755, -1.612, -59.476))
        JumpPointsGlobal.append(vect(-20.346, -1.615, -54.643))
        JumpPointsGlobal.append(vect(22.271, -1.615, -54.643))
        JumpPointsGlobal.append(vect(61.865, 2.691, -34.402))
    if getCurrentObjective() == 1:
        JumpPointsGlobal = []
        JumpPointsGlobal.append(vect(-50.396, 99.129, 166.748))
        JumpPointsGlobal.append(vect(-52.31, 96.441, 163.292))
        JumpPointsGlobal.append(vect(-40.786, 100.696, 161.544))
        JumpPointsGlobal.append(vect(-31.992, 99.701, 167.633))
        JumpPointsGlobal.append(vect(-28.81, 100.642, 177.711))
        JumpPointsGlobal.append(vect(-32.072, 99.439, 177.229))
        JumpPointsGlobal.append(vect(32.384, 99.598, 177.545))
        JumpPointsGlobal.append(vect(41.602, 100.859, 161.813))
        JumpPointsGlobal.append(vect(52.116, 96.699, 163.854))
        JumpPointsGlobal.append(vect(8.545, 97.674, 126.284))
        JumpPointsGlobal.append(vect(-8.332, 97.674, 126.47))
        JumpPointsGlobal.append(vect(-1.826, 98.615, 115.751))
        JumpPointsGlobal.append(vect(2.039, 98.781, 116.011))
    if getCurrentObjective() == 2:
        JumpPointsGlobal = []
        JumpPointsGlobal.append(vect(-23.999, 268.423, 305.413))
        JumpPointsGlobal.append(vect(24.185, 268.427, 305.71))
        JumpPointsGlobal.append(vect(-4.723, 267.622, 290.543))


rule "Navigation: Lijiang Tower - Healthpacks":
    @Condition (getCurrentMap() == Map.LIJIANG_TOWER or getCurrentMap() == Map.LIJIANG_TOWER_LNY) == true
    @Condition isGameInProgress() == true
    
    if getCurrentObjective() == 0:
        HealthpackLocations = []
        HealthpackLocations.append(vect(1.46, -1.461, -81.364))
        HealthpackLocations.append(vect(14.356, 0.382, -46.801))
        HealthpackLocations.append(vect(52.983, 2.455, -31.89))
        HealthpackLocations.append(vect(-50.739, 2.573, -25.823))
        HealthpackLocations.append(vect(-12.404, 0.315, -47.261))
        HealthpackLocations.append(vect(0.903, 0.455, -9.838))
    if getCurrentObjective() == 1:
        HealthpackLocations = []
        HealthpackLocations.append(vect(26.813, 95.851, 179.147))
        HealthpackLocations.append(vect(23.699, 95.552, 144.536))
        HealthpackLocations.append(vect(-0.048, 95.552, 184.685))
        HealthpackLocations.append(vect(-23.315, 95.548, 145.334))
    if getCurrentObjective() == 2:
        HealthpackLocations = []
        HealthpackLocations.append(vect(-0.385, 271.427, 259.459))
        HealthpackLocations.append(vect(-11.615, 270.427, 292.745))
        HealthpackLocations.append(vect(-18.35, 268.426, 306.587))
        HealthpackLocations.append(vect(-0.007, 271.426, 328.087))
        HealthpackLocations.append(vect(17.889, 268.426, 306.639))
        HealthpackLocations.append(vect(11.541, 270.427, 292.691))


/*
rule "===== NAVIGATION: NEPAL =====":
*/

rule "Navigation: Nepal - Waypoints":
    @Condition getCurrentMap() == Map.NEPAL
    @Condition isGameInProgress() == true
    
    if getCurrentObjective() == 0:
        Waypoints = []
        Waypoints.append(vect(-206.808, -92.703, -8.334))
        Waypoints.append(vect(-168.871, -97.926, -68.37))
        Waypoints.append(vect(-164.133, -94.601, -78.162))
        Waypoints.append(vect(-158.144, -96.414, -61.1))
        Waypoints.append(vect(-159.458, -89.421, -47.233))
        Waypoints.append(vect(-162.97, -86.649, -25.702))
        Waypoints.append(vect(-165.501, -87.793, -31.459))
        Waypoints.append(vect(-157.155, -86.648, -17.327))
        Waypoints.append(vect(-159.071, -87.836, 0.139))
        Waypoints.append(vect(-156.686, -86.648, 18.318))
        Waypoints.append(vect(-162.896, -86.648, 25.813))
        Waypoints.append(vect(-163.989, -87.927, 33.236))
        Waypoints.append(vect(-158.913, -89.343, 46.995))
        Waypoints.append(vect(-158.222, -96.35, 60.752))
        Waypoints.append(vect(-166.652, -98.038, 69.083))
        Waypoints.append(vect(-162.984, -96.876, 54.211))
        Waypoints.append(vect(-168.396, -95.616, 44.23))
        Waypoints.append(vect(-172.285, -93.021, 29.931))
        Waypoints.append(vect(-185.063, -92.73, 29.327))
        Waypoints.append(vect(-195.308, -93.1, 38.461))
        Waypoints.append(vect(-186.717, -92.424, 35.261))
        Waypoints.append(vect(-191.437, -92.871, 42.093))
        Waypoints.append(vect(-177.021, -88.648, 42.027))
        Waypoints.append(vect(-181.475, -88.649, 20.823))
        Waypoints.append(vect(-178.293, -88.695, 19.97))
        Waypoints.append(vect(-170.332, -90.652, 20.294))
        Waypoints.append(vect(-162.358, -90.652, 19.375))
        Waypoints.append(vect(-162.364, -90.627, 11.491))
        Waypoints.append(vect(-171.531, -90.673, 14.268))
        Waypoints.append(vect(-183.917, -92.612, 13.46))
        Waypoints.append(vect(-193.244, -92.733, 22.328))
        Waypoints.append(vect(-199.067, -92.626, 29.102))
        Waypoints.append(vect(-213.323, -94.478, 29.117))
        Waypoints.append(vect(-201.094, -92.654, 33.959))
        Waypoints.append(vect(-197.584, -94.398, 48.959))
        Waypoints.append(vect(-192.779, -97.167, 62.132))
        Waypoints.append(vect(-182.351, -97.4, 68.069))
        Waypoints.append(vect(-189.742, -96.725, 51.521))
        Waypoints.append(vect(-174.897, -95.861, 46.74))
        Waypoints.append(vect(-192.653, -93.256, 45.335))
        Waypoints.append(vect(-195.237, -92.71, 11.029))
        Waypoints.append(vect(-201.599, -92.57, 17.383))
        Waypoints.append(vect(-201.599, -92.57, 17.383))
        Waypoints.append(vect(-203.93, -92.649, 21.539))
        Waypoints.append(vect(-213.894, -90.648, 22.385))
        Waypoints.append(vect(-219.711, -90.857, 18.466))
        Waypoints.append(vect(-220.117, -86.855, 4.426))
        Waypoints.append(vect(-220.431, -86.855, -9.265))
        Waypoints.append(vect(-220.007, -86.855, 0.304))
        Waypoints.append(vect(-212.805, -86.649, 0.102))
        Waypoints.append(vect(-199.037, -85.648, -0.08))
        Waypoints.append(vect(-199.698, -85.648, 4.933))
        Waypoints.append(vect(-190.205, -85.648, 5.211))
        Waypoints.append(vect(-189.968, -85.648, -5.259))
        Waypoints.append(vect(-200.3, -85.648, -5.113))
        Waypoints.append(vect(-191.845, -85.651, 0.054))
        Waypoints.append(vect(-162.093, -87.854, 0.305))
        Waypoints.append(vect(-162.493, -90.126, 9.259))
        Waypoints.append(vect(-162.493, -90.126, 9.259))
        Waypoints.append(vect(-162.82, -90.651, -19.313))
        Waypoints.append(vect(-170.824, -90.651, -19.999))
        Waypoints.append(vect(-170.927, -90.657, -8.57))
        Waypoints.append(vect(-178.556, -90.877, -14.068))
        Waypoints.append(vect(-180.98, -88.649, -19.88))
        Waypoints.append(vect(-177.337, -88.649, -41.953))
        Waypoints.append(vect(-191.925, -92.875, -42.013))
        Waypoints.append(vect(-158.337, -88.738, -41.857))
        Waypoints.append(vect(-163.23, -96.95, -54.634))
        Waypoints.append(vect(-168.493, -95.714, -44.863))
        Waypoints.append(vect(-171.891, -93.139, -31.188))
        Waypoints.append(vect(-185.368, -92.72, -29.786))
        Waypoints.append(vect(-189.867, -92.651, -36.034))
        Waypoints.append(vect(-200.142, -92.723, -37.32))
        Waypoints.append(vect(-200.92, -92.664, -29.809))
        Waypoints.append(vect(-213.451, -94.493, -28.796))
        Waypoints.append(vect(-197.5, -93.924, -46.614))
        Waypoints.append(vect(-193.319, -97.157, -60.34))
        Waypoints.append(vect(-181.514, -97.697, -68.364))
        Waypoints.append(vect(-189.737, -96.724, -51.417))
        Waypoints.append(vect(-178.139, -96.022, -49.661))
        Waypoints.append(vect(-169.758, -95.64, -43.144))
        Waypoints.append(vect(-193.675, -92.634, -23.659))
        Waypoints.append(vect(-194.087, -92.786, -12.508))
        Waypoints.append(vect(-184.948, -92.613, -6.89))
        Waypoints.append(vect(-178.019, -92.646, -6.315))
        Waypoints.append(vect(-178.383, -92.685, 4.586))
        Waypoints.append(vect(-184.848, -92.657, 3.979))
        Waypoints.append(vect(-190.52, -92.509, 0.223))
        Waypoints.append(vect(-190.313, -92.509, 4.45))
        Waypoints.append(vect(-195.223, -92.509, 4.054))
        Waypoints.append(vect(-199.706, -92.509, 3.905))
        Waypoints.append(vect(-199.314, -92.509, -0.303))
        Waypoints.append(vect(-199.218, -92.509, -3.821))
        Waypoints.append(vect(-194.747, -92.509, -3.922))
        Waypoints.append(vect(-190.965, -92.509, -4))
        Waypoints.append(vect(-204.855, -92.668, -0.267))
        Waypoints.append(vect(-205.055, -92.663, 7.46))
        Waypoints.append(vect(-220.078, -92.673, 5.91))
        Waypoints.append(vect(-219.899, -92.686, -6.137))
        Waypoints.append(vect(-208.138, -92.914, -5.911))
        Waypoints.append(vect(-213.289, -92.652, -6.237))
        Waypoints.append(vect(-213.213, -92.652, -0.346))
        Waypoints.append(vect(-217.689, -92.652, -0.118))
        Waypoints.append(vect(-212.798, -92.652, 5.279))
        Waypoints.append(vect(-162.183, -94.603, 78.1))
        Waypoints.append(vect(-201.987, -93.545, -21.317))
        Waypoints.append(vect(-216.319, -90.788, -21.838))
        Waypoints.append(vect(-219.859, -91.172, -17.474))
        Waypoints.append(vect(-220.093, -87.776, -10.313))
        Waypoints.append(vect(-217.988, -90.71, -30.94))
        Waypoints.append(vect(-217.224, -90.906, 31.911))
        Waypoints.append(vect(-160.479, -95.003, -82.902))
    if getCurrentObjective() == 1:
        Waypoints = []
        Waypoints.append(vect(-72.716, 11.701, -13.35))
        Waypoints.append(vect(-43.164, 16.702, -72.391))
        Waypoints.append(vect(-36.172, 16.501, -61.398))
        Waypoints.append(vect(-30.52, 16.948, -52.438))
        Waypoints.append(vect(-42.667, 19.491, -88.008))
        Waypoints.append(vect(-28.961, 17.699, -37.116))
        Waypoints.append(vect(-22.413, 17.699, -32.929))
        Waypoints.append(vect(-22.718, 18.701, -23.23))
        Waypoints.append(vect(-31.858, 18.701, -18.144))
        Waypoints.append(vect(-32.252, 18.701, -11.477))
        Waypoints.append(vect(-25.321, 18.701, -9.142))
        Waypoints.append(vect(-24.906, 14.698, 0.427))
        Waypoints.append(vect(-24.392, 11.699, -18.828))
        Waypoints.append(vect(-25.497, 11.802, -29.935))
        Waypoints.append(vect(-25.351, 12.702, -37.041))
        Waypoints.append(vect(-36.133, 12.501, -38.331))
        Waypoints.append(vect(-36.184, 12.702, -47.764))
        Waypoints.append(vect(-50.214, 12.701, -48.277))
        Waypoints.append(vect(-50.057, 12.501, -41.076))
        Waypoints.append(vect(-45.733, 12.501, -38.25))
        Waypoints.append(vect(-54.262, 12.501, -37.844))
        Waypoints.append(vect(-46.776, 11.708, -29.691))
        Waypoints.append(vect(-53.41, 11.699, -30.102))
        Waypoints.append(vect(-49.95, 11.501, -23.755))
        Waypoints.append(vect(-37.668, 12.167, -23.248))
        Waypoints.append(vect(-37.451, 11.499, -17.75))
        Waypoints.append(vect(-30.526, 11.699, -17.96))
        Waypoints.append(vect(-46.269, 11.699, -16.282))
        Waypoints.append(vect(-50.366, 11.576, -16.411))
        Waypoints.append(vect(-64.099, 11.501, -14.594))
        Waypoints.append(vect(-63.385, 11.501, -22.753))
        Waypoints.append(vect(-72.866, 11.699, -15.998))
        Waypoints.append(vect(-72.882, 13.701, -28.235))
        Waypoints.append(vect(-65.462, 12.699, -28.338))
        Waypoints.append(vect(-59.83, 12.699, -28.338))
        Waypoints.append(vect(-60.028, 12.501, -38.012))
        Waypoints.append(vect(-65.995, 12.696, -37.854))
        Waypoints.append(vect(-62.82, 16.699, -60.406))
        Waypoints.append(vect(-57.37, 16.501, -64.493))
        Waypoints.append(vect(-57.694, 20.702, -48.616))
        Waypoints.append(vect(-44.633, 20.668, -50.885))
        Waypoints.append(vect(-25.473, 23.702, -51.016))
        Waypoints.append(vect(-19.766, 23.702, -49.207))
        Waypoints.append(vect(-49.933, 14.699, -6.854))
        Waypoints.append(vect(-55.362, 14.552, -6.054))
        Waypoints.append(vect(-55.435, 14.552, 0.367))
        Waypoints.append(vect(-55.916, 14.552, 5.808))
        Waypoints.append(vect(-49.934, 14.552, 5.793))
        Waypoints.append(vect(-44.456, 14.552, 5.187))
        Waypoints.append(vect(-44.417, 14.552, 0.172))
        Waypoints.append(vect(-45.151, 14.552, -5.646))
        Waypoints.append(vect(-30.762, 14.698, -5.631))
        Waypoints.append(vect(-38.415, 14.698, -0.569))
        Waypoints.append(vect(-30.019, 14.698, 4.785))
        Waypoints.append(vect(-24.667, 11.698, 19.612))
        Waypoints.append(vect(-26.304, 11.821, 29.862))
        Waypoints.append(vect(-26.032, 12.702, 36.83))
        Waypoints.append(vect(-36.502, 12.573, 36.859))
        Waypoints.append(vect(-36.499, 12.704, 48.263))
        Waypoints.append(vect(-36.502, 16.702, 59.177))
        Waypoints.append(vect(-31.072, 16.698, 55.064))
        Waypoints.append(vect(-29.281, 17.699, 37.323))
        Waypoints.append(vect(-21.606, 17.699, 32.733))
        Waypoints.append(vect(-19.666, 23.36, 46.833))
        Waypoints.append(vect(-23.579, 23.702, 51.323))
        Waypoints.append(vect(-40.209, 22.698, 51.237))
        Waypoints.append(vect(-56.989, 20.702, 49.105))
        Waypoints.append(vect(-56.89, 16.702, 62.126))
        Waypoints.append(vect(-63.382, 16.662, 59.959))
        Waypoints.append(vect(-64.108, 12.501, 39.804))
        Waypoints.append(vect(-59.473, 12.699, 29.477))
        Waypoints.append(vect(-65.656, 12.699, 28.621))
        Waypoints.append(vect(-65.874, 12.699, 35.306))
        Waypoints.append(vect(-66.856, 12.699, 27.717))
        Waypoints.append(vect(-74.034, 13.769, 28.456))
        Waypoints.append(vect(-72.806, 11.701, 15.78))
        Waypoints.append(vect(-62.367, 11.501, 15.371))
        Waypoints.append(vect(-49.784, 11.501, 17.701))
        Waypoints.append(vect(-49.548, 11.698, 29.748))
        Waypoints.append(vect(-45.641, 12.501, 38.81))
        Waypoints.append(vect(-53.557, 12.501, 38.849))
        Waypoints.append(vect(-50.318, 12.699, 48.542))
        Waypoints.append(vect(-37.517, 12.706, 47.782))
        Waypoints.append(vect(-22.398, 18.702, 22.232))
        Waypoints.append(vect(-31.287, 18.702, 18.929))
        Waypoints.append(vect(-31.996, 18.702, 10.999))
        Waypoints.append(vect(-24.636, 18.698, 10.088))
        Waypoints.append(vect(-43.124, 11.57, 24.282))
        Waypoints.append(vect(-64.712, 14.698, -0.396))
        Waypoints.append(vect(-64.712, 14.698, -0.396))
        Waypoints.append(vect(-70.621, 15.712, 3.117))
        Waypoints.append(vect(-75.452, 9.698, 5.32))
        Waypoints.append(vect(-79.627, 9.698, 0.352))
        Waypoints.append(vect(-73.09, 9.854, -6.002))
    if getCurrentObjective() == 2:
        Waypoints = []
        Waypoints.append(vect(105.029, 132.804, 1.389))
        Waypoints.append(vect(81.446, 134.131, -86.798))
        Waypoints.append(vect(81.196, 131.499, -64.97))
        Waypoints.append(vect(85.966, 131.698, -51.587))
        Waypoints.append(vect(80.39, 131.574, -44.435))
        Waypoints.append(vect(76.095, 131.699, -52.091))
        Waypoints.append(vect(66.58, 129.501, -51.971))
        Waypoints.append(vect(80.598, 133.501, -36.306))
        Waypoints.append(vect(110.743, 133.579, -40.848))
        Waypoints.append(vect(110.271, 133.701, -17.997))
        Waypoints.append(vect(96.595, 133.552, -17.516))
        Waypoints.append(vect(88.815, 133.698, -24.049))
        Waypoints.append(vect(80.731, 133.351, -24.167))
        Waypoints.append(vect(80.948, 133.501, -35.594))
        Waypoints.append(vect(72.634, 133.691, -24.046))
        Waypoints.append(vect(94.192, 133.702, -15.403))
        Waypoints.append(vect(83.273, 131.552, -14.019))
        Waypoints.append(vect(84.411, 129.698, -5.537))
        Waypoints.append(vect(79.788, 129.709, -2.295))
        Waypoints.append(vect(79.518, 129.71, 2.491))
        Waypoints.append(vect(82.633, 129.702, 6.203))
        Waypoints.append(vect(88.14, 129.702, 4.763))
        Waypoints.append(vect(86.362, 129.894, 0.608))
        Waypoints.append(vect(87.582, 129.702, -4.422))
        Waypoints.append(vect(98.491, 129.702, -4.166))
        Waypoints.append(vect(97.99, 129.702, 3.901))
        Waypoints.append(vect(100.396, 129.702, 0.157))
        Waypoints.append(vect(96.982, 133.552, -10.476))
        Waypoints.append(vect(96.936, 133.438, -5.371))
        Waypoints.append(vect(96.74, 133.438, 5.744))
        Waypoints.append(vect(97.215, 133.552, 17.963))
        Waypoints.append(vect(84.299, 131.552, 14.112))
        Waypoints.append(vect(91.148, 133.552, 24.088))
        Waypoints.append(vect(80.79, 133.351, 24.11))
        Waypoints.append(vect(80.869, 133.699, 39.848))
        Waypoints.append(vect(86.807, 131.699, 52.326))
        Waypoints.append(vect(76.267, 131.709, 52.059))
        Waypoints.append(vect(66.376, 129.501, 51.423))
        Waypoints.append(vect(89.379, 131.699, 52.319))
        Waypoints.append(vect(101.064, 133.701, 50.868))
        Waypoints.append(vect(104.905, 133.501, 41.872))
        Waypoints.append(vect(111.808, 133.701, 31.775))
        Waypoints.append(vect(110.923, 133.701, 18.076))
        Waypoints.append(vect(101.248, 133.701, 17.775))
        Waypoints.append(vect(101.951, 133.499, -42.504))
        Waypoints.append(vect(102.425, 133.699, -51.129))
        Waypoints.append(vect(90.504, 131.699, -51.701))
        Waypoints.append(vect(106.264, 133.36, -0.116))
        Waypoints.append(vect(99.967, 132.222, 0.112))
        Waypoints.append(vect(73.19, 133.427, 24.109))
        Waypoints.append(vect(58.093, 129.423, -24.004))
        Waypoints.append(vect(74.178, 133.427, -23.916))
        Waypoints.append(vect(58.725, 129.544, 24.605))


rule "Navigation: Nepal - Jumps":
    @Event eachPlayer
    @Condition getCurrentMap() == Map.NEPAL
    @Condition isGameInProgress() == true
    
    if getCurrentObjective() == 0:
        JumpPointsGlobal = []
        JumpPointsGlobal.append(vect(-180.699, -98.463, -66.519))
        JumpPointsGlobal.append(vect(-165.202, -87.493, 4.082))
        JumpPointsGlobal.append(vect(-164.223, -90.199, 8.283))
        JumpPointsGlobal.append(vect(-164.385, -87.38, -4.261))
        JumpPointsGlobal.append(vect(-160.329, -87.479, -4.764))
        JumpPointsGlobal.append(vect(-216.104, -92.128, -2.788))
        JumpPointsGlobal.append(vect(-217.011, -91.918, 2.05))
        JumpPointsGlobal.append(vect(-180.625, -98.043, -66.674))
    if getCurrentObjective() == 1:
        JumpPointsGlobal = []
        JumpPointsGlobal.append(vect(-67.248, 11.701, 10.356))
        JumpPointsGlobal.append(vect(-25.086, 18.672, -8.161))
        JumpPointsGlobal.append(vect(-67.171, 14.698, 1.439))
        JumpPointsGlobal.append(vect(-67.171, 14.701, -2.713))
        JumpPointsGlobal.append(vect(-24.868, 18.672, 7.926))
    if getCurrentObjective() == 2:
        JumpPointsGlobal = []
        JumpPointsGlobal.append(vect(83.239, 130.495, -44.073))
        JumpPointsGlobal.append(vect(81.171, 129.698, -9.898))
        JumpPointsGlobal.append(vect(86.641, 131.702, 12.769))
        JumpPointsGlobal.append(vect(86.745, 129.702, 9.483))
        JumpPointsGlobal.append(vect(81.244, 129.698, 10.156))
        JumpPointsGlobal.append(vect(86.655, 131.699, -12.752))
        JumpPointsGlobal.append(vect(86.808, 129.698, -9.973))


rule "Navigation: Nepal - Healthpacks":
    @Condition getCurrentMap() == Map.NEPAL
    @Condition isGameInProgress() == true
    
    if getCurrentObjective() == 0:
        HealthpackLocations = []
        HealthpackLocations.append(vect(-161.229, -91.545, 22.298))
        HealthpackLocations.append(vect(22.743, 11.426, -95.352))
        HealthpackLocations.append(vect(79.743, 11.426, -94.972))
        HealthpackLocations.append(vect(82.321, 14.424, -137.873))
        HealthpackLocations.append(vect(21.279, 14.426, -137.461))
        HealthpackLocations.append(vect(51.722, 6.298, -75.969))
        HealthpackLocations.append(vect(-216.117, -95.429, 29.371))
        HealthpackLocations.append(vect(-219.903, -92.76, -0.077))
        HealthpackLocations.append(vect(-216.794, -95.463, -29.428))
        HealthpackLocations.append(vect(-161.873, -91.382, -21.136))
    if getCurrentObjective() == 1:
        HealthpackLocations = []
        HealthpackLocations.append(vect(-45.858, 12.698, -47.978))
        HealthpackLocations.append(vect(-59.136, 12.698, 29.854))
        HealthpackLocations.append(vect(-43.553, 12.698, 48.029))
        HealthpackLocations.append(vect(-36.802, 12.699, 35.952))
        HealthpackLocations.append(vect(-23.011, 11.698, 19.848))
        HealthpackLocations.append(vect(-23.703, 11.698, -17.746))
        HealthpackLocations.append(vect(-35.721, 12.698, -35.898))
        HealthpackLocations.append(vect(-79.932, 9.698, -0.055))
        HealthpackLocations.append(vect(-59.898, 12.698, -28.84))
    if getCurrentObjective() == 2:
        HealthpackLocations = []
        HealthpackLocations.append(vect(98.604, 133.698, 48.425))
        HealthpackLocations.append(vect(81.087, 133.348, -20.954))
        HealthpackLocations.append(vect(92.818, 133.589, 0.102))
        HealthpackLocations.append(vect(80.892, 133.348, 20.741))
        HealthpackLocations.append(vect(98.484, 133.698, -48.22))


/*
rule "===== NAVIGATION: OASIS =====":
*/

rule "Navigation: Oasis - Waypoints":
    @Condition getCurrentMap() == Map.OASIS
    @Condition isGameInProgress() == true
    
    if getCurrentObjective() == 0:
        Waypoints = []
        Waypoints.append(vect(142.365, 4.612, 226.897))
        Waypoints.append(vect(81.453, 2.351, 312.549))
        Waypoints.append(vect(77.701, 2.351, 315.037))
        Waypoints.append(vect(83.03, 2.351, 304.517))
        Waypoints.append(vect(89.622, 2.349, 314.961))
        Waypoints.append(vect(91.961, 2.352, 306.212))
        Waypoints.append(vect(117.448, 2.747, 299.945))
        Waypoints.append(vect(124.014, 4.329, 291.967))
        Waypoints.append(vect(118.416, 4.067, 274.604))
        Waypoints.append(vect(108.988, 2.351, 268.019))
        Waypoints.append(vect(105.037, 2.401, 259.328))
        Waypoints.append(vect(114.671, 5.352, 256.23))
        Waypoints.append(vect(122.986, 5.352, 268.501))
        Waypoints.append(vect(128.415, 5.352, 273.687))
        Waypoints.append(vect(135.181, 5.352, 276.356))
        Waypoints.append(vect(151.272, 5.45, 280.505))
        Waypoints.append(vect(152.784, 5.352, 273.759))
        Waypoints.append(vect(153.962, 5.352, 268.563))
        Waypoints.append(vect(170.021, 5.352, 274.056))
        Waypoints.append(vect(162.07, 5.45, 266.445))
        Waypoints.append(vect(161.057, 12.89, 265.479))
        Waypoints.append(vect(154.736, 12.873, 258.699))
        Waypoints.append(vect(146.657, 11.352, 250.357))
        Waypoints.append(vect(156.439, 5.352, 260.433))
        Waypoints.append(vect(170.358, 5.352, 257.799))
        Waypoints.append(vect(177.17, 5.449, 255.221))
        Waypoints.append(vect(172.362, 5.352, 238.667))
        Waypoints.append(vect(187.442, 4.36, 228.97))
        Waypoints.append(vect(173.994, 5.351, 237.989))
        Waypoints.append(vect(162.986, 5.351, 241.281))
        Waypoints.append(vect(157.67, 5.351, 233.73))
        Waypoints.append(vect(166.835, 5.349, 228.393))
        Waypoints.append(vect(165.197, 5.349, 226.351))
        Waypoints.append(vect(151.782, 5.349, 218.713))
        Waypoints.append(vect(149.561, 5.349, 227.217))
        Waypoints.append(vect(140.168, 5.349, 227.229))
        Waypoints.append(vect(128.447, 5.349, 232.106))
        Waypoints.append(vect(118.268, 2.349, 222.382))
        Waypoints.append(vect(139.386, 4.161, 219.913))
        Waypoints.append(vect(147.361, 5.428, 217.268))
        Waypoints.append(vect(156.004, 2.378, 209.192))
        Waypoints.append(vect(174.82, 3.351, 222.169))
        Waypoints.append(vect(115.952, 4.227, 243.523))
        Waypoints.append(vect(112.968, 5.428, 251.364))
        Waypoints.append(vect(124.958, 5.352, 238.24))
        Waypoints.append(vect(134.486, 5.351, 228.597))
        Waypoints.append(vect(129.181, 5.351, 262.193))
        Waypoints.append(vect(137.314, 3.351, 253.367))
        Waypoints.append(vect(136.192, 3.351, 244.719))
        Waypoints.append(vect(138.728, 3.351, 241.582))
        Waypoints.append(vect(146.268, 3.351, 239.787))
        Waypoints.append(vect(150.705, 3.351, 243.448))
        Waypoints.append(vect(149.532, 3.351, 253.513))
        Waypoints.append(vect(140.725, 3.498, 244.782))
        Waypoints.append(vect(214.542, 2.351, 179.539))
        Waypoints.append(vect(210.552, 2.351, 185.465))
        Waypoints.append(vect(211.969, 2.351, 177.252))
        Waypoints.append(vect(208.143, 2.351, 183.539))
        Waypoints.append(vect(200.974, 2.351, 187.126))
        Waypoints.append(vect(203.079, 2.351, 194.238))
        Waypoints.append(vect(210.898, 2.351, 192.937))
        Waypoints.append(vect(198.682, 2.201, 205.201))
        Waypoints.append(vect(190.423, 3.201, 233.164))
        Waypoints.append(vect(117.313, 5.085, 255.021))
        Waypoints.append(vect(124.777, 5.002, 253.257))
        Waypoints.append(vect(127.224, 4.932, 257.252))
        Waypoints.append(vect(124.023, 2.784, 292.818))
        Waypoints.append(vect(164.119, 5.533, 245.695))
    if getCurrentObjective() == 1:
        Waypoints = []
        Waypoints.append(vect(183.712, 9.232, -205.66))
        Waypoints.append(vect(187.128, 10.12, -193.259))
        Waypoints.append(vect(194.753, 10.12, -201.247))
        Waypoints.append(vect(188.67, 10.12, -200.419))
        Waypoints.append(vect(170.175, 9.699, -201.29))
        Waypoints.append(vect(158.486, 9.199, -213.614))
        Waypoints.append(vect(195.553, 9.058, -193.028))
        Waypoints.append(vect(164.555, 9.199, -219.878))
        Waypoints.append(vect(156.422, 9.199, -228.347))
        Waypoints.append(vect(146.557, 9.202, -220.188))
        Waypoints.append(vect(128.586, 9.202, -211.669))
        Waypoints.append(vect(123.857, 7.198, -217.297))
        Waypoints.append(vect(128.4, 7.198, -222.438))
        Waypoints.append(vect(131.856, 7.198, -227.203))
        Waypoints.append(vect(139.188, 9.236, -234.114))
        Waypoints.append(vect(149.904, 9.236, -234.503))
        Waypoints.append(vect(149.904, 9.236, -234.503))
        Waypoints.append(vect(128.44, 9.236, -246.516))
        Waypoints.append(vect(119.566, 7.199, -238.181))
        Waypoints.append(vect(124.654, 7.199, -231.977))
        Waypoints.append(vect(113.011, 7.199, -230.78))
        Waypoints.append(vect(115.429, 7.199, -222.217))
        Waypoints.append(vect(119.399, 7.199, -217.679))
        Waypoints.append(vect(108.948, 6.198, -215.454))
        Waypoints.append(vect(132.774, 9.198, -216.832))
        Waypoints.append(vect(110.51, 7.201, -230.558))
        Waypoints.append(vect(104.535, 9.202, -237.267))
        Waypoints.append(vect(110.834, 9.202, -237.892))
        Waypoints.append(vect(109.3, 9.198, -241.67))
        Waypoints.append(vect(115.404, 9.198, -254.238))
        Waypoints.append(vect(122.158, 9.201, -261.605))
        Waypoints.append(vect(129.447, 9.236, -255.691))
        Waypoints.append(vect(114.152, 9.198, -269.595))
        Waypoints.append(vect(104.671, 9.198, -267.102))
        Waypoints.append(vect(96.709, 9.701, -275.173))
        Waypoints.append(vect(103.061, 9.701, -285.494))
        Waypoints.append(vect(86.779, 9.081, -301.854))
        Waypoints.append(vect(95.165, 10.121, -301.478))
        Waypoints.append(vect(94.797, 10.121, -294.209))
        Waypoints.append(vect(152.932, 8.96, -255.158))
        Waypoints.append(vect(148.512, 8.96, -259.214))
        Waypoints.append(vect(141.127, 8.96, -258.797))
        Waypoints.append(vect(141.339, 8.804, -248.071))
        Waypoints.append(vect(151.157, 8.964, -247.426))
        Waypoints.append(vect(134.283, 8.964, -240.266))
    if getCurrentObjective() == 2:
        Waypoints = []
        Waypoints.append(vect(-194.173, 9.455, 3.023))
        Waypoints.append(vect(-187.798, 21.447, 73.536))
        Waypoints.append(vect(-193.82, 21.447, 74.165))
        Waypoints.append(vect(-181.806, 21.447, 74.185))
        Waypoints.append(vect(-187.741, 19.446, 51.468))
        Waypoints.append(vect(-188.029, 16.443, 40.902))
        Waypoints.append(vect(-197.424, 16.447, 25.647))
        Waypoints.append(vect(-197.459, 17.446, 14.638))
        Waypoints.append(vect(-188.613, 17.446, 15.093))
        Waypoints.append(vect(-177.163, 17.447, 21.139))
        Waypoints.append(vect(-179.967, 16.443, 28.988))
        Waypoints.append(vect(-193.586, 11.443, 31.714))
        Waypoints.append(vect(-194.24, 10.447, 10.704))
        Waypoints.append(vect(-194.78, 10.447, -7.051))
        Waypoints.append(vect(-202.914, 10.569, 0.181))
        Waypoints.append(vect(-210.213, 12.447, -0.127))
        Waypoints.append(vect(-209.667, 14.447, -7.634))
        Waypoints.append(vect(-202.29, 16.447, -7.708))
        Waypoints.append(vect(-202.194, 16.447, -3.818))
        Waypoints.append(vect(-194.809, 16.447, -3.778))
        Waypoints.append(vect(-201.323, 16.447, 3.97))
        Waypoints.append(vect(-202.063, 16.447, 7.674))
        Waypoints.append(vect(-209.459, 14.444, 7.996))
        Waypoints.append(vect(-197.267, 16.447, 4.546))
        Waypoints.append(vect(-194.093, 16.447, 6.586))
        Waypoints.append(vect(-188.025, 16.447, 6.798))
        Waypoints.append(vect(-182.663, 16.447, 5.721))
        Waypoints.append(vect(-182.816, 16.447, -1.226))
        Waypoints.append(vect(-183.203, 16.447, -6.238))
        Waypoints.append(vect(-188.567, 16.447, -6.087))
        Waypoints.append(vect(-201.51, 17.443, 13.93))
        Waypoints.append(vect(-209.943, 18.572, 12.812))
        Waypoints.append(vect(-217.21, 20.447, 5.296))
        Waypoints.append(vect(-216.307, 20.447, -4.08))
        Waypoints.append(vect(-205.291, 20.447, -3.651))
        Waypoints.append(vect(-206.884, 20.447, 4.27))
        Waypoints.append(vect(-210.067, 18.607, -12.661))
        Waypoints.append(vect(-199.676, 17.443, -14.389))
        Waypoints.append(vect(-188.966, 17.443, -13.659))
        Waypoints.append(vect(-197.18, 16.444, -27.14))
        Waypoints.append(vect(-188.061, 16.446, -40.208))
        Waypoints.append(vect(-187.986, 19.447, -48.356))
        Waypoints.append(vect(-184.271, 16.443, -35.209))
        Waypoints.append(vect(-177.726, 17.267, -22.688))
        Waypoints.append(vect(-178.636, 17.446, -15.159))
        Waypoints.append(vect(-193.082, 11.443, -31.999))
        Waypoints.append(vect(-183.488, 15.863, -32.154))
        Waypoints.append(vect(-193.873, 10.447, -8.712))
        Waypoints.append(vect(-193.873, 10.447, -8.712))
        Waypoints.append(vect(-194.127, 21.253, -74.153))
        Waypoints.append(vect(-187.443, 21.253, -74.022))
        Waypoints.append(vect(-187.443, 21.253, -74.022))
        Waypoints.append(vect(-187.495, 12.909, 32.035))


rule "Navigation: Oasis - Healthpacks":
    @Condition getCurrentMap() == Map.OASIS
    @Condition isGameInProgress() == true
    
    if getCurrentObjective() == 0:
        HealthpackLocations = []
        HealthpackLocations.append(vect(152.929, 5.449, 281.647))
        HealthpackLocations.append(vect(118.063, 2.352, 222.254))
        HealthpackLocations.append(vect(162.615, 5.352, 228.665))
        HealthpackLocations.append(vect(124.582, 5.352, 266.536))
        HealthpackLocations.append(vect(177.613, 5.45, 256.849))
        HealthpackLocations.append(vect(170.065, 5.352, 274.075))
    if getCurrentObjective() == 1:
        HealthpackLocations = []
        HealthpackLocations.append(vect(107.389, 6.198, -213.437))
    if getCurrentObjective() == 2:
        HealthpackLocations = []
        HealthpackLocations.append(vect(-188.107, 16.447, 36.032))


