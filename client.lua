-- Detection Loop for Blacklisted Props
CreateThread(function()
    while true do
        Wait(2000)
        local ped = PlayerPedId()
        local pCoords = GetEntityCoords(ped)

        for _, model in ipairs(Config.BlacklistedProps) do
            local hash = type(model) == "string" and GetHashKey(model) or model
            local prop = GetClosestObjectOfType(pCoords.x, pCoords.y, pCoords.z, 15.0, hash, false, false, false)

            if DoesEntityExist(prop) then
                local owner = NetworkGetEntityOwner(prop)
                if owner == PlayerId() then
                    DeleteEntity(prop)
                    TriggerServerEvent('DONxDEV_anti_prop:handleViolation', "Spawned blacklisted prop: " .. tostring(model))
                    break
                end
            end
        end
    end
end)

-- Screenshot Trigger from Server
RegisterNetEvent('DONxDEV_anti_prop:takeScreenshot', function(reason)
    exports['screenshot-basic']:requestScreenshotUpload(Config.WebhookURL, 'files[]', function(data)
        local resp = json.decode(data)
        local imageURL = nil
        if resp and resp.attachments and resp.attachments[1] then
            imageURL = resp.attachments[1].url
        end
        TriggerServerEvent('DONxDEV_anti_prop:finalizeDetection', reason, imageURL)
    end)
end)