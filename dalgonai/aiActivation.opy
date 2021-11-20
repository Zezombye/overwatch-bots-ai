#!mainFile "main.opy"

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

