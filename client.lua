local QBCore = exports['qb-core']:GetCoreObject()
local originalHair = {}
local isHairEnabled = true

RegisterCommand('togglehair', function(source, args, rawCommand)
    isHairEnabled = not isHairEnabled
    TriggerServerEvent('toggleHair', isHairEnabled)
end)

RegisterNetEvent('toggleHairClient')
AddEventHandler('toggleHairClient', function(enable)
    isHairEnabled = enable
    if isHairEnabled then
        RestoreOrSaveHair()
        local message = isHairEnabled and "Activado." or "Desactivado."
        QBCore.Functions.Notify("El pelo ha sido " .. message, "success")
    else
        SaveOriginalHair()
        SetPedComponentVariation(PlayerPedId(), 2, 0, 0, 2)
        QBCore.Functions.Notify("El pelo ha sido Desactivado.", "error")
    end
end)

function SaveOriginalHair()
    originalHair = {}
    for i = 0, GetNumberOfPedDrawableVariations(PlayerPedId(), 2) - 1 do
        table.insert(originalHair, GetPedDrawableVariation(PlayerPedId(), 2))
    end
end

function RestoreOrSaveHair()
    if #originalHair == 0 then
        SaveOriginalHair()
    else
        for i, drawable in ipairs(originalHair) do
            SetPedComponentVariation(PlayerPedId(), 2, drawable, 0, 2)
        end
    end
end