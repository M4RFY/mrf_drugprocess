QBCore = exports['qb-core']:GetCoreObject()

local coords = lib.require('sv_config')

lib.callback.register('requestCoordinates', function()
    return coords
end)