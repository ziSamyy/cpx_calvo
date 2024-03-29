RegisterServerEvent('toggleHair')
AddEventHandler('toggleHair', function(enable)
    TriggerClientEvent('toggleHairClient', -1, enable)
end)