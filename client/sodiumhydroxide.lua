local spawnedSodiumHydroxideBarrels = 0
local SodiumHydroxideBarrels = {}
inSodiumFarm = false

local function ValidateSodiumHydroxideCoord(plantCoord)
	local validate2 = true
	if spawnedSodiumHydroxideBarrels > 0 then
		for _, v in pairs(SodiumHydroxideBarrels) do
			if #(plantCoord - GetEntityCoords(v)) < 5 then
				validate2 = false
			end
		end
		if not inSodiumFarm then
			validate = false
		end
	end
	return validate2
end

local function GetCoordZSodiumHydroxide(x, y)
	local groundCheckHeights = { 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 300.0 }

	for i, height in ipairs(groundCheckHeights) do
		local found3Ground, z = GetGroundZFor_3dCoord(x, y, height)

		if found3Ground then
			return z
		end
	end

	return 100.0
end

local function GenerateSodiumHydroxideCoords(serverCoords)
	while true do
		Wait(1)

		local sodiCoordX, sodiCoordY

		math.randomseed(GetGameTimer())
		local modX3 = math.random(-7, 7)

		Wait(100)

		math.randomseed(GetGameTimer())
		local modY3 = math.random(-7, 7)

		sodiCoordX = serverCoords.Zones.SodiumHydroxideFarm.coords.x + modX3
		sodiCoordY = serverCoords.Zones.SodiumHydroxideFarm.coords.y + modY3

		local coordZ3 = GetCoordZSodiumHydroxide(sodiCoordX, sodiCoordY)
		local coord3 = vector3(sodiCoordX, sodiCoordY, coordZ3)

		if ValidateSodiumHydroxideCoord(coord3) then
			return coord3
		end
	end
end

function SpawnSodiumHydroxideBarrels(serverCoords)
	local model = `mw_sodium_barrel`
	while spawnedSodiumHydroxideBarrels < 10 do
		Wait(0)
		local sodiumCoords = GenerateSodiumHydroxideCoords(serverCoords)
		RequestModel(model)
		while not HasModelLoaded(model) do
			Wait(100)
		end
		local obj = CreateObject(model, sodiumCoords.x, sodiumCoords.y, sodiumCoords.z, false, true, false)
		PlaceObjectOnGroundProperly(obj)
		FreezeEntityPosition(obj, true)
		table.insert(SodiumHydroxideBarrels, obj)
		spawnedSodiumHydroxideBarrels = spawnedSodiumHydroxideBarrels + 1
	end
	SetModelAsNoLongerNeeded(model)
end

RegisterNetEvent('mrf_drugprocess:pickSodium', function()
	local playerPe3 = PlayerPedId()
	local coords = GetEntityCoords(playerPe3)
	local nearbyObject3, nearbyID3

	for i=1, #SodiumHydroxideBarrels, 1 do
		if #(coords - GetEntityCoords(SodiumHydroxideBarrels[i])) < 2 then
			nearbyObject3, nearbyID3 = SodiumHydroxideBarrels[i], i
		end
	end

	if nearbyObject3 and IsPedOnFoot(playerPe3) then
		if not isPickingUp then
			isPickingUp = true
			TaskStartScenarioInPlace(playerPe3, 'world_human_gardener_plant', 0, false)
			QBCore.Functions.Progressbar('doing_processing', Lang:t('progressbar.collecting'), 8000, false, true, {
				disableMovement = true,
				disableCarMovement = true,
				disableMouse = false,
				disableCombat = true,
			}, {}, {}, {}, function()
				ClearPedTasks(PlayerPedId())
				SetEntityAsMissionEntity(nearbyObject3, false, true)
				DeleteObject(nearbyObject3)
				table.remove(SodiumHydroxideBarrels, nearbyID3)
				spawnedSodiumHydroxideBarrels -= 1
				TriggerServerEvent('mrf_drugprocess:pickedUpSodiumHydroxide')
				isPickingUp = false
			end, function()
				ClearPedTasks(PlayerPedId())
				isPickingUp = false
			end)
		end
	end
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for _, v in pairs(SodiumHydroxideBarrels) do
			SetEntityAsMissionEntity(v, false, true)
			DeleteObject(v)
		end
	end
end)