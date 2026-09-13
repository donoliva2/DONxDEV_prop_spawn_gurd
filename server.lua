local function sendDiscordEmbed(src, reason, imageURL)
    local name = GetPlayerName(src) or "Unknown"
    local license = GetPlayerIdentifierByType(src, 'license') or "N/A"
    local discord = GetPlayerIdentifierByType(src, 'discord') or "N/A"

    local embed = {{
        ["color"] = 16711680, -- Red
        ["title"] = "🚨 DONxDEV Anti-Prop Detection",
        ["description"] = string.format("**Player:** %s\n**Server ID:** %s\n**License:** %s\n**Discord:** %s\n**Reason:** %s", name, src, license, discord, reason),
        ["image"] = imageURL and { ["url"] = imageURL } or nil,
        ["footer"] = { ["text"] = "DONxDEV Protection System" },
        ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
    }}

    PerformHttpRequest(Config.WebhookURL, function(err, text, headers) end, 'POST', json.encode({
        username = Config.BotName,
        avatar_url = Config.BotAvatar,
        embeds = embed
    }), { ['Content-Type'] = 'application/json' })
end

RegisterNetEvent('DONxDEV_anti_prop:handleViolation', function(reason)
    local src = source
    -- Step 1: Request client to capture a screenshot before kick
    TriggerClientEvent('DONxDEV_anti_prop:takeScreenshot', src, reason)
end)

RegisterNetEvent('DONxDEV_anti_prop:finalizeDetection', function(reason, imageURL)
    local src = source

    -- Step 2: Send log with screenshot to Discord
    sendDiscordEmbed(src, reason, imageURL)

    -- Step 3: Kick the player
    Wait(500)
    DropPlayer(src, Config.KickReason)
end)