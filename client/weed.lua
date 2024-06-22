local spawnedWeeds = 0
local weedPlants = {}
local isPickingUp = false
inWeedField = false

local function ValidateWeedCoord(plantCoord)
	local validate = true
	if spawnedWeeds > 0 then
		for _, v in pairs(weedPlants) do
			if #(plantCoord - GetEntityCoords(v)) < 5 then
				validate = false
			end
		end
		if not inWeedField then
			validate = false
		end
	end
	return validate
end

local function GetCoordZWeed(x, y)
	local groundCheckHeights = { 50, 51.0, 52.0, 53.0, 54.0, 55.0, 56.0, 57.0, 58.0, 59.0, 60.0 }

	for _, height in ipairs(groundCheckHeights) do
		local foundGround, z = GetGroundZFor_3dCoord(x, y, height)

		if foundGround then
			return z
		end
	end

	return 53.85
end

local function GenerateWeedCoords(serverCoords)
	while true do
		Wait(1)

		local weedCoordX, weedCoordY

		math.randomseed(GetGameTimer())
		local modX = math.random(-20, 20)

		Wait(100)

		math.randomseed(GetGameTimer())
		local modY = math.random(-20, 20)

		weedCoordX = serverCoords.Zones.WeedField.coords.x + modX
		weedCoordY = serverCoords.Zones.WeedField.coords.y + modY

		local coordZ = GetCoordZWeed(weedCoordX, weedCoordY)
		local coord = vector3(weedCoordX, weedCoordY, coordZ)

		if ValidateWeedCoord(coord) then
			return coord
		end
	end
end

function SpawnWeedPlants(serverCoords)
	local model = `mw_weed_plant`
	while spawnedWeeds < 15 do
		Wait(0)
		local weedCoords = GenerateWeedCoords(serverCoords)
		RequestModel(model)
		while not HasModelLoaded(model) do
			Wait(100)
		end
		local obj = CreateObject(model, weedCoords.x, weedCoords.y, weedCoords.z, false, true, false)
		PlaceObjectOnGroundProperly(obj)
		FreezeEntityPosition(obj, true)
		table.insert(weedPlants, obj)
		spawnedWeeds += 1
	end
	SetModelAsNoLongerNeeded(model)
end

local function ProcessWeed()
	local playerPed = PlayerPedId()

	TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_PARKING_METER', 0, true)
	QBCore.Functions.Progressbar('doing_processing', Lang:t('progressbar.processing'), 15000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function()
		ClearPedTasks(playerPed)
		TriggerServerEvent('mrf_drugprocess:processCannabis')
	end, function()
		ClearPedTasks(playerPed)
	end)
end

local function ProcessWeedSeed()
	local playerPed = PlayerPedId()

	TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_PARKING_METER', 0, true)
	QBCore.Functions.Progressbar('doing_processing', Lang:t('progressbar.processing'), 15000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function()
		ClearPedTasks(playerPed)
		TriggerServerEvent('mrf_drugprocess:server:processWeedCannabis')
	end, function()
		ClearPedTasks(playerPed)
	end)
end

RegisterNetEvent('mrf_drugprocess:processWeed',function()
	if not GetItem({cannabis = 1, empty_weed_bag = 1}) then return end
	ProcessWeed()
end)

RegisterNetEvent('mrf_drugprocess:processWeedSeed',function()
	if not GetItem({weed_seed = 1}) then return end
	ProcessWeedSeed()
end)

RegisterNetEvent('mrf_drugprocess:pickWeed', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	local nearbyObject, nearbyID

	for i=1, #weedPlants, 1 do
		if #(coords - GetEntityCoords(weedPlants[i])) < 2 then
			nearbyObject, nearbyID = weedPlants[i], i
		end
	end

	if nearbyObject and IsPedOnFoot(playerPed) then
		if not isPickingUp then
			isPickingUp = true
			TaskStartScenarioInPlace(playerPed, 'world_human_gardener_plant', 0, false)
			QBCore.Functions.Progressbar('doing_processing', Lang:t('progressbar.collecting'), 10000, false, true, {
				disableMovement = true,
				disableCarMovement = true,
				disableMouse = false,
				disableCombat = true,
			}, {}, {}, {}, function()
				ClearPedTasks(PlayerPedId())
				SetEntityAsMissionEntity(nearbyObject, false, true)
				DeleteObject(nearbyObject)
				table.remove(weedPlants, nearbyID)
				spawnedWeeds -= 1
				TriggerServerEvent('mrf_drugprocess:pickedUpWeedSeed')
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
		for _, v in pairs(weedPlants) do
			SetEntityAsMissionEntity(v, false, true)
			DeleteObject(v)
		end
	end
end)