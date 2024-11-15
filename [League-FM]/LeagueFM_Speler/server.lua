RegisterCommand('lfm', function(source, args, rawCommand)
    -- Trigger het client-side event voor de speler die het commando heeft ingevoerd
    TriggerClientEvent('openLFM', source)
end, false)

CreateThread(function()
    local resourceName = GetCurrentResourceName()
    local currentVersion, latestVersion = GetResourceMetadata(resourceName, 'version')
    local outdated = '^6[%s]^3 Version ^2%s^3 is available! You are using version ^1%s^7'
    Citizen.Wait(2000)
    while Config.CheckVersion do
        Citizen.Wait(0)
        PerformHttpRequest(GetResourceMetadata(resourceName, 'versioncheck'), function (errorCode, resultData, resultHeaders)
            if errorCode ~= 200 then print("Returned error code:" .. tostring(errorCode)) else
                local data, version = tostring(resultData)
                for line in data:gmatch("([^\n]*)\n?") do
                    if line:find('^version') then version = line:sub(10, (line:len(line) - 1)) break end
                end         
                latestVersion = version
            end
        end)
        if latestVersion then 
            if currentVersion ~= latestVersion then
                print(outdated:format(resourceName, latestVersion, currentVersion))
            end
            Citizen.Wait(60000*Config.CheckVersionDelay)
        end
    end
end)