QBCore = exports['qb-core']:GetCoreObject()

local animDict = 'anim@heists@keycard@'
local animName = 'exit'

function EnterAnim()
    lib.requestAnimDict(animDict, 1000)
    TaskPlayAnim(cache.ped, animDict, animName, 5.0, 1.0, -1, 16, 0, false, false, false)
    RemoveAnimDict(animDict)
    Wait(400)
    ClearPedTasks(cache.ped)
end

function Teleport(coords)
    EnterAnim()
    Wait(400)
    DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
    SetEntityCoords(cache.ped, coords.x, coords.y , coords.z, false, false, false, false)
    SetEntityHeading(cache.ped, coords.w)
    FreezeEntityPosition(cache.ped,true)
    StopAnimTask(cache.ped, animDict, animName, 3.0)
    Wait(100)
    DoScreenFadeIn(500)
    FreezeEntityPosition(cache.ped, false)
end

function GetItem(items)
    local missingItems = {}

    for item, amount in pairs(items) do
        local label = QBCore.Shared.Items[item].label
        if not QBCore.Functions.HasItem(item, amount) then
            table.insert(missingItems, {item = item, label = label, amount = amount})
        end
    end

    if #missingItems > 0 then
        local itemDescriptions = {}
        for _, missingItem in ipairs(missingItems) do
            local description
            if missingItem.amount == 1 then
                description = string.format('You don\'t have enough %s.', missingItem.label)
            else
                description = string.format('You don\'t have enough %s. Required: %d Stacked', missingItem.label, missingItem.amount)
            end
            table.insert(itemDescriptions, description)
        end
        local combinedDescription = table.concat(itemDescriptions, '\n')
        lib.notify({ title = 'Drug Processing', description = combinedDescription, type = 'error', icon = 'fas fa-xmark'})
        return false
    end

    return true
end