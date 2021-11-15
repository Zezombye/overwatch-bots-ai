
#!include "settings.opy"

#Global variables

globalvar StartBots
globalvar HackedHealthpack
globalvar TargetArray
globalvar AutomaticFireList
globalvar HealthpackLocations
globalvar HealthpackBlacklist
globalvar DummyBots
globalvar JumpPointsGlobal
globalvar Waypoints
globalvar GlobalTeamComp
globalvar weirdVect1
globalvar weirdVect2
globalvar ServerLoadIsHigh
globalvar AllowedHeroesT1
globalvar AllowedHeroesT2
globalvar Difficulty
globalvar BotsTeam1
globalvar BotsTeam2
globalvar ReplacerBots
globalvar AFK_protection
globalvar AFK_timer
globalvar team1BotHeroes
globalvar team2BotHeroes
globalvar Teams
globalvar I 41


#Player variables

playervar CanSeeEnemy
playervar CanSeeAlly
playervar CanSeeDamagedAlly
playervar TouchedTheObjective
playervar DealtDamage
playervar TookDamage
playervar FocusDamagedAlly
playervar HasCC
playervar GotElimination
playervar StopFacing
playervar ChaseEnemy
playervar HeroPriorityRating
playervar BastionTurretMode
playervar CurrentWaypoint
playervar StopAutomaticGoTo
playervar BrigitteBotRepairPackAmmo
playervar CurrentTarget
playervar StopShoot
playervar MoiraOrbReady
playervar CurrentHealthpack
playervar Stealth
playervar VisibleEnemies
playervar CurrentHealTarget
playervar ClosestHealthpackPosition
playervar TeleportLocation
playervar BotActive
playervar CanHeal
playervar CurrentVisibleWaypoints
playervar WaypointBlacklist
playervar CurrentGoToTarget
playervar JumpPoint
playervar RandomFacingDirection
playervar Communicate
playervar PickedUpHealthpack
playervar VisibleTurretSpots
playervar LucioAuraMode
playervar RandomizedWaypointArray
playervar IndexNumber
playervar TurnRate
playervar ZaryaUlt
playervar PlayerClosestToObjectiveCenter
playervar HackTargets
playervar Module_001_DummyBotEnemy
playervar Module_002_DummyBot
playervar Bot_Waiting_Time
playervar Module_003_LowRange5m
playervar Module_004_MidRange10m
playervar Module_005_LongRange15m
playervar Module_006_HighRange20m
playervar Module_007_DummyBot_SeeDamagedA
playervar Module_008_VeryLowHealth30
playervar Module_009_HalfHealth50
playervar Module_010_HighHealth75
playervar Module_011_OverHealth75
playervar CanSeeDeadAlly
playervar CurrentAllyTarget
playervar Module_012_DummyBotAlly
playervar CurrentDeadAlly
playervar Mercy_Rez
playervar BlacklistedWaypoint


#Subroutine names

subroutine Action_Module_001_UseAbility1
subroutine Action_Module_002_UseAbility2
subroutine Action_Module_003_UseUltimate
subroutine Action_Module_004_UsePrimary_B
subroutine Action_Module_005_UseSecondary_B
subroutine Action_Module_006_UsePrimary_A
subroutine Action_Module_007_UseSecondary_A
subroutine Action_Module_008_UseSecondary_S
subroutine Action_Module_009_Distance_Info
subroutine Action_Module_010_Selfuse_Start
subroutine Action_Module_010_Selfuse_End
subroutine Action_Module_011_StopAction
subroutine Action_Module_011_StartAction
subroutine Action_Module_012_Health
subroutine Action_Module_013_Ability1_S
subroutine Action_Module_014_Ability2_S
subroutine Action_Module_015_Ultimate_S
subroutine Action_Module_016_Chase_Ult
subroutine Action_Module_017_Sec_S
subroutine Action_Module_018_Hold_POS


rule "Initialize settings":
    Difficulty = createWorkshopSetting(int[1:5], "AI Settings", "AI Difficulty", 3, 0)

    #Bot number
    BotsTeam1 = createWorkshopSetting(int[0:12], "AI Settings", "Number of Bots in Team 1", 6, 0)
    BotsTeam2 = createWorkshopSetting(int[0:12], "AI Settings", "Number of Bots in Team 2", 6, 0)
    
    #General
    ReplacerBots = createWorkshopSetting(bool, "AI Settings", "Replace left player with Bots", false, 0)
    AFK_protection = createWorkshopSetting(bool, "AI Settings", "AI Controls AFK Player", false, 0)
    AFK_timer = createWorkshopSetting(float[10:60], "AI Settings", "AFK Time needed to start Bot", 30, 0)

    Teams = createWorkshopSetting(enum["Default Teams", "Random teams + custom bot number", "Custom heroes"], "", "Team composition", 0, 0)
    #Team composition
    team1BotHeroes = [
        createWorkshopSetting(Hero, " \nTeam composition (only applies with custom heroes)\n", "Team 1, Bot 1", Hero.ANA, 0),
        createWorkshopSetting(Hero, " \nTeam composition (only applies with custom heroes)\n", "Team 1, Bot 2", Hero.MERCY, 1),
        createWorkshopSetting(Hero, " \nTeam composition (only applies with custom heroes)\n", "Team 1, Bot 3", Hero.MCCREE, 2),
        createWorkshopSetting(Hero, " \nTeam composition (only applies with custom heroes)\n", "Team 1, Bot 4", Hero.SOLDIER, 3),
        createWorkshopSetting(Hero, " \nTeam composition (only applies with custom heroes)\n", "Team 1, Bot 5", Hero.REINHARDT, 4),
        createWorkshopSetting(Hero, " \nTeam composition (only applies with custom heroes)\n", "Team 1, Bot 6", Hero.ZARYA, 5),
    ]
    team2BotHeroes = [
        createWorkshopSetting(Hero, b" ", "Team 2, Bot 1", Hero.LUCIO, 6),
        createWorkshopSetting(Hero, b" ", "Team 2, Bot 2", Hero.BAPTISTE, 7),
        createWorkshopSetting(Hero, b" ", "Team 2, Bot 3", Hero.BASTION, 8),
        createWorkshopSetting(Hero, b" ", "Team 2, Bot 4", Hero.MEI, 9),
        createWorkshopSetting(Hero, b" ", "Team 2, Bot 5", Hero.ROADHOG, 10),
        createWorkshopSetting(Hero, b" ", "Team 2, Bot 6", Hero.SIGMA, 11),
    ]


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
