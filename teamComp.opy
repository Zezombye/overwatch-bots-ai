#!mainFile "main.opy"

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


