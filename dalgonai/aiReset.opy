#!mainFile "main.opy"

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
