#!mainFile "main.opy"

settings {
    "main": {
        "description": "https://github.com/Zezombye/overwatch-bots-ai/\n\nGeneric gamemode to fight against workshop bots. Takes some elements from DalgonAI.\n\nCode: 299TV",
        "modeName": "Overwatch bot AI"
    },
    "lobby": {
        "team2Slots": 0
    },
    "gamemodes": {
        "control": {
            "enabledMaps": [
                "nepal"
            ],
            "setValidControlPoints": "second"
        },
        "ffa": {
            "enabled": false,
            "gamemodeStartTrigger": "immediately",
            "heroLimit": "off",
            "enableRandomHeroes": true,
            "respawnTime%": 10
        }
    }
}
