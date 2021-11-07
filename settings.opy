#!mainFile "main.opy"

settings {
    "main": {
        "modeName": "Custom Legendary Bots V11",
        "description": "Custom Legendary Bots V11 - Control Mode/Skirmish\n\nBy DalgonAI\nRemastered by Zezombye"
    },
    "lobby": {
        "allowPlayersInQueue": true,
        "mapRotation": "afterGame",
        "enableMatchVoiceChat": true,
        "spectatorSlots": 12,
        "returnToLobby": "never",
        "teamBalancing": "afterGame"
    },
    "gamemodes": {
        "control": {
            "enableCompetitiveRules": true,
            "scoreToWin": 1,
            "scoringSpeed%": 101
        },
        "elimination": {
            "enabled": false,
            "scoreToWin": 9
        },
        "skirmish": {
            "enabledMaps": []
        },
        "general": {
            "gamemodeStartTrigger": "immediately",
            "enableKillCam": false,
            "respawnTime%": 50
        }
    },
    "heroes": {
        "allTeams": {
            "baptiste": {
                "enableInfiniteAmmo": true
            },
            "mercy": {
                "weaponsEnabled": "staff"
            },
            "symmetra": {
                "enableAbility1": false
            },
            "torbjorn": {
                "enableAbility1": false
            }
        }
    }
}