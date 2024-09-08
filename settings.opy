#!mainFile "main.opy"

settings {
    "main": {
        "description": "https://github.com/Zezombye/overwatch-bots-ai/\n\nGeneric gamemode to fight against workshop bots. Takes some elements from DalgonAI.\n\nCode: 299TV",
        "modeName": "Overwatch bot AI"
    },
    "lobby": {
        #need 2 slots, else ana can't nano others
        "team2Slots": 2
    },
    "gamemodes": {
        "control": {
            "enabledMaps": [
                "nepal"
            ],
            "gamemodeStartTrigger": "manual",
            "setValidControlPoints": "second"
        },
        "ffa": {
            "enabled": true,
            "gamemodeStartTrigger": "immediately",
            "heroLimit": "off",
            "enableRandomHeroes": true,
            "respawnTime%": 10
        }
    }
}
