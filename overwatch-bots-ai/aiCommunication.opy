#!mainFile "main.opy"

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
