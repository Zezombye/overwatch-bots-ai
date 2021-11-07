
#!include "settings.opy"

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


rule "Initialize settings":
    Difficulty = createWorkshopSetting(int[1:5], "AI Difficulty", "AI Difficulty", 3, 0)

    #Bot number
    Teams = createWorkshopSetting(int[0:2], "AI TEAM", "0 = Default Teams - 1 = Random Teams + Custom Bot Number - 2 = Custom Heroes", 0, 0)
    BotsTeam1 = createWorkshopSetting(int[0:12], "AI Number", "Number of Bots Team 1", 6, 0)
    BotsTeam2 = createWorkshopSetting(int[0:12], "AI Number", "Number of Bots Team 2", 6, 0)

    #General
    ReplacerBots = createWorkshopSetting(bool, "AI Settings", "Replace left player with Bots", false, 0)
    AFK_protection = createWorkshopSetting(bool, "AI Settings", "AI Controls AFK Player", false, 0)
    AFK_timer = createWorkshopSetting(float[10:60], "AI Settings", "AFK Time needed to start Bot", 30, 0)

    #Custom heroes
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

    #Setting: Debug Array for Custom Hero Setting [0 = No hero]
    AllHeros.append(getAllHeroes())


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


#!include "teamComp.opy"
#!include "aiPrepare.opy"
#!include "aiTriggers.opy"
#!include "aiAction.opy"
#!include "aiActivation.opy"
#!include "aiBasic.opy"
#!include "targetPriority.opy"
#!include "aiReset.opy"
#!include "aiModules.opy"
#!include "navigation.opy"


#!include "heroes/reaper.opy"
#!include "heroes/tracer.opy"
#!include "heroes/mercy.opy"
#!include "heroes/hanzo.opy"
#!include "heroes/torbjorn.opy"
#!include "heroes/reinhardt.opy"
#!include "heroes/pharah.opy"
#!include "heroes/winston.opy"
#!include "heroes/widowmaker.opy"
#!include "heroes/bastion.opy"
#!include "heroes/symmetra.opy"
#!include "heroes/zenyatta.opy"
#!include "heroes/genji.opy"
#!include "heroes/roadhog.opy"
#!include "heroes/mccree.opy"
#!include "heroes/junkrat.opy"
#!include "heroes/zarya.opy"
#!include "heroes/soldier.opy"
#!include "heroes/lucio.opy"
#!include "heroes/dva.opy"
#!include "heroes/mei.opy"
#!include "heroes/sombra.opy"
#!include "heroes/doomfist.opy"
#!include "heroes/ana.opy"
#!include "heroes/orisa.opy"
#!include "heroes/brigitte.opy"
#!include "heroes/moira.opy"
#!include "heroes/hammond.opy"
#!include "heroes/ashe.opy"
#!include "heroes/echo.opy"
#!include "heroes/baptiste.opy"
#!include "heroes/sigma.opy"

#!include "aiCommunication.opy"
#!include "aiCore.opy"

#!include "maps/busan.opy"
#!include "maps/ilios.opy"
#!include "maps/lijiang.opy"
#!include "maps/nepal.opy"
#!include "maps/oasis.opy"
