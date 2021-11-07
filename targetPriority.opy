#!mainFile "main.opy"

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

