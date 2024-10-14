RegisterNetEvent('openLFM')
AddEventHandler('openLFM', function()
    -- Zet de NUI-focus op true zodat je kunt interacteren
    SetNuiFocus(true, true)

    -- Stuurt een bericht naar de NUI om de UI te tonen
    SendNUIMessage({
        type = 'ui',
        display = true
    })
end)

-- NUI callback om de UI te sluiten
RegisterNUICallback('close', function(data, cb)
    -- Zet de NUI-focus weer uit
    SetNuiFocus(false, false)

    -- Verstopt de UI
    SendNUIMessage({
        type = 'ui',
        display = false
    })

    cb('ok')
end)

RegisterCommand("lfm", function()
    -- Trigger het client-side event om de UI te openen
    TriggerEvent('openLFM') -- Roep direct het event aan dat de UI opent
end, false)

-- Optioneel: Voeg een beschrijving toe aan het commando
TriggerEvent('chat:addSuggestion', '/lfm', 'Open de League-FM speler.')
