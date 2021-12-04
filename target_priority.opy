#!mainFile "main.opy"

# Threat. Shows the potential danger of the enemy. This value is only for players, i.e bots always have 0 threat.
playervar threat

# Attractiveness. Shows how big of a "target" the hero is. For both bots and players (for bots, it can show who to heal, for example)
playervar attractiveness

# Do note that these values are for each player. It is up to each bot to find their own target, which is a combination of both this value, and some of their own values.


rule "Calculate threat":
    @Event eachPlayer
    @Condition not eventPlayer.isDummy()

    /* Threat is based on:
    - Health (lower health is less threatening)
    - Proximity to other players (a fully formed team is more threatening)
    - Ability cooldown (players whose abilities are on CD are less threatening)
    - Ult usage (in general, ulting players should be avoided at all costs)
    - Random noise (so it's not too predictable)
    - i forgor :skull:

    I put the weights of the sum pretty much randomly, feel free to tweak.
    */

    eventPlayer.threat = 8 * eventPlayer.getNormalizedHealth() + min(10 / distance(eventPlayer.getPosition(), getClosestPlayer(eventPlayer, eventPlayer.getTeam())), 3) + (10 - eventPlayer.getAbilityCooldown(Button.ABILITY_1)) + (10 - eventPlayer.getAbilityCooldown(Button.ABILITY_2)) + 10 * eventPlayer.isUsingUltimate() + random.randint(-3, 3)

    # When the enemy decides to ult, it's important that the value gets changed immediately so that the bots can react in time. Otherwise, it's 2 seconds (could be decreased if load isn't too bad)
    waitUntil(eventPlayer.isUsingUltimate(), 2)

    goto RULE_START


rule "Calculate attractiveness":
    @Event eachPlayer

    /* Attractiveness is based on:
    - Health (lower health is more attractive, for both enemies and healers)
    - Absolute health (low hp means quicker kill)
    - Proximity to other players (lonely players are better targets)
    - Ability cooldown (high cooldown means safer attack)
    - Random noise (so it's not too predictable)
    - i forgor :skull:

    I put the weights of the sum pretty much randomly, feel free to tweak.
    */

    eventPlayer.attractiveness = 8 * (1 - eventPlayer.getNormalizedHealth()) + min(100 / eventPlayer.getHealth(), 6) + min(distance(eventPlayer.getPosition(), getClosestPlayer(eventPlayer, eventPlayer.getTeam())), 3) + eventPlayer.getAbilityCooldown(Button.ABILITY_1) + eventPlayer.getAbilityCooldown(Button.ABILITY_2) + random.randint(-3, 3)

    wait(2)

    goto RULE_START