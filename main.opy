#!include "settings.opy"


#!extension spawnMoreDummyBots


globalvar i
globalvar j

globalvar botNames = random.shuffle([
    "Alexandra [Bot]ez",
    "Andrea [Bot]ez",
    "[Bot]tleneck",
    "[Bot]anist",
    "Lo[Bot]omy",
    "Sa[Bot]eur",
    "Gigabr[AI]n",
    "Quadrillion[AI]re",
    "Barm[AI]d",
    "Ch[AI]nsaw",
    "Mayonn[AI]se",
    "P[AI]nkiller",
    "Vill[AI]n",
    "R[AI]lgunner",
    "Desp[AI]r",
    "Tr[AI]torous",
    "Murm[AI]der",
    "Samur[AI]",
    "Cors[AI]r",
])

playervar name #needed because apparently spectators can't see dummy bot names


enum Team:
    HUMANS = Team.1,
    BOTS = Team.2,


rule "Init gamemode":
    print("load: {} | avg: {} | max: {}".format(getServerLoad(), getAverageServerLoad(), getPeakServerLoad()))
    
    #Spawn the bots
    createDummy(Hero.REINHARDT, Team.BOTS, 0, getSpawnPoints(Team.BOTS)[0], null)
    createDummy(Hero.ZARYA, Team.BOTS, 1, getSpawnPoints(Team.BOTS)[1], null)
    createDummy(Hero.MCCREE, Team.BOTS, 2, getSpawnPoints(Team.BOTS)[2], null)
    createDummy(Hero.REAPER, Team.BOTS, 3, getSpawnPoints(Team.BOTS)[3], null)
    createDummy(Hero.ANA, Team.BOTS, 4, getSpawnPoints(Team.BOTS)[4], null)
    createDummy(Hero.BAPTISTE, Team.BOTS, 5, getSpawnPoints(Team.BOTS)[5], null)

rule "Initialize dummy":
    @Event eachPlayer
    @Condition eventPlayer.isDummy()
    eventPlayer.name = eventPlayer.getCurrentHero()
    eventPlayer.startForcingName(eventPlayer.name)

#!include "heroes/"


#!include "pathmaps/"
#!include "target_priority.opy"
#!include "pathfinding.opy"
#!include "actions.opy"

#!include "debug.opy"

