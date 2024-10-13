RegisterCommand('lfm', function(source, args, rawCommand)
    local xPlayer = source

    -- Trigger het client-side event voor de speler die het commando heeft ingevoerd
    TriggerClientEvent('openLFM', xPlayer)
end, false)
