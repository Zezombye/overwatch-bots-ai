#!mainFile "main.opy"

rule "Module: Dummy Bot can See Enemy - FALSE":
    @Event eachPlayer
    @Condition (eventPlayer.BotActive and eventPlayer.CanSeeEnemy and StartBots and ServerLoadIsHigh == false) == false
    
    eventPlayer.Module_001_DummyBotEnemy = false


rule "Module: Dummy Bot can See Damaged Ally - TRUE":
    @Event eachPlayer
    @Condition eventPlayer.BotActive == true
    @Condition eventPlayer.CanSeeDamagedAlly == true
    @Condition StartBots == true
    @Condition ServerLoadIsHigh == false
    
    eventPlayer.Module_007_DummyBot_SeeDamagedA = true


rule "Module: Dummy Bot can See Damaged Ally - FALSE":
    @Event eachPlayer
    @Condition (eventPlayer.BotActive and eventPlayer.CanSeeDamagedAlly and StartBots and ServerLoadIsHigh == false) == false
    
    eventPlayer.Module_007_DummyBot_SeeDamagedA = false


rule "Module: Dummy Bot - TRUE":
    @Event eachPlayer
    @Condition eventPlayer.BotActive == true
    @Condition isGameInProgress() == true 
    @Condition StartBots == true 
    @Condition ServerLoadIsHigh == false
    
    eventPlayer.Module_002_DummyBot = true


rule "Module: Dummy Bot  - FALSE":
    @Event eachPlayer
    @Condition (eventPlayer.BotActive and isGameInProgress() and StartBots and ServerLoadIsHigh == false) == false
    
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
    
    if eventPlayer.isFiringSecondaryFire():
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
    
    if eventPlayer.isFiringSecondaryFire():
        wait(0.25)
        if eventPlayer.isFiringSecondaryFire():
            goto RULE_START
    else:
        eventPlayer.stopForcingButton(Button.SECONDARY_FIRE)


def Action_Module_013_Ability1_S():
    @Name "Action Module: Wait for finish Ability 1"
    
    if eventPlayer.isUsingAbility1():
        wait(0.25)
        if eventPlayer.isUsingAbility1():
            goto RULE_START
    else:


def Action_Module_014_Ability2_S():
    @Name "Action Module: Wait for finish Ability 2"
    
    if eventPlayer.isUsingAbility2():
        wait(0.25)
        if eventPlayer.isUsingAbility2():
            goto RULE_START
    else:


def Action_Module_015_Ultimate_S():
    @Name "Action Module: Wait for finish Ultimate"
    
    if eventPlayer.isUsingUltimate():
        wait(0.25)
        if eventPlayer.isUsingUltimate():
            goto RULE_START
    else:


def Action_Module_016_Chase_Ult():
    @Name "Action Module: Chase Enemy during ult"
    
    if isInLoS(eventPlayer, eventPlayer.CurrentTarget[0], BarrierLos.PASS_THROUGH_BARRIERS) and eventPlayer.CurrentTarget != []:
        eventPlayer.StopAutomaticGoTo = false
        eventPlayer.CurrentGoToTarget = getClosestPlayer(eventPlayer, getOppositeTeam(eventPlayer.getTeam()))
        eventPlayer.CurrentVisibleWaypoints = sorted([i for i in [player for player in Waypoints if isInLoS(eventPlayer, player, BarrierLos.PASS_THROUGH_BARRIERS)] if i in eventPlayer.WaypointBlacklist == false], lambda i: distance(i, eventPlayer.CurrentGoToTarget[0]))
        eventPlayer.startThrottleInDirection(directionTowards(eventPlayer, eventPlayer.CurrentVisibleWaypoints[0]), 1, Relativity.TO_WORLD, Throttle.REPLACE_EXISTING, ThrottleReeval.DIRECTION_AND_MAGNITUDE)
    else:
        eventPlayer.StopAutomaticGoTo = true
        eventPlayer.startThrottleInDirection(directionTowards(eventPlayer, eventPlayer.CurrentTarget[0]), 1, Relativity.TO_WORLD, Throttle.REPLACE_EXISTING, ThrottleReeval.DIRECTION_AND_MAGNITUDE)
    wait(eventPlayer.Bot_Waiting_Time)
    if eventPlayer.isUsingUltimate():
        goto RULE_START


def Action_Module_017_Sec_S():
    @Name "Action Module: Wait for finish Sec"
    
    if eventPlayer.isFiringSecondaryFire():
        wait(0.25)
        if eventPlayer.isFiringSecondaryFire():
            goto RULE_START
    else:


rule "Module: Dummy Bot can See Ally - TRUE":
    @Event eachPlayer
    @Condition eventPlayer.BotActive == true 
    @Condition eventPlayer.CanSeeAlly == true 
    @Condition StartBots == true 
    @Condition ServerLoadIsHigh == false
    
    eventPlayer.Module_012_DummyBotAlly = true


rule "Module: Dummy Bot can See Ally - FALSE":
    @Event eachPlayer
    @Condition (eventPlayer.BotActive and eventPlayer.CanSeeAlly and StartBots and ServerLoadIsHigh == false) == false
    
    eventPlayer.Module_012_DummyBotAlly = false


rule "Module: Dummy Bot can See Enemy - TRUE":
    @Event eachPlayer
    @Condition eventPlayer.BotActive == true 
    @Condition eventPlayer.CanSeeEnemy == true 
    @Condition StartBots == true 
    @Condition ServerLoadIsHigh == false
    
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

