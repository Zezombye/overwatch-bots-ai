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

rule "Init gamemode":
    print("load: {} | avg: {} | max: {}".format(getServerLoad(), getAverageServerLoad(), getPeakServerLoad()))
    
    #Spawn the bots
    createDummy(Hero.REINHARDT, Team.2, 0, getSpawnPoints(Team.2)[0], null)
    createDummy(Hero.ZARYA, Team.2, 1, getSpawnPoints(Team.2)[1], null)
    createDummy(Hero.MCCREE, Team.2, 2, getSpawnPoints(Team.2)[2], null)
    createDummy(Hero.REAPER, Team.2, 3, getSpawnPoints(Team.2)[3], null)
    createDummy(Hero.ANA, Team.2, 4, getSpawnPoints(Team.2)[4], null)
    createDummy(Hero.BAPTISTE, Team.2, 5, getSpawnPoints(Team.2)[5], null)

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

