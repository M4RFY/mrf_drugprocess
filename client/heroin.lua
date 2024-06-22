local spawnedPoppys = 0
local PoppyPlants = {}
local isProcessing = false
inHeroinField = false

local function ValidateHeroinCoord(plantCoord)
	local validate = true
	if spawnedPoppys > 0 then
		for _, v in pairs(PoppyPlants) do
			if #(plantCoord - GetEntityCoords(v)) < 5 then
				validate = false
			end
		end
		if not inHeroinField then
			validate = false
		end
	end
	return validate
end

local function GetCoordZHeroin(x, y)
	local groundCheckHeights = { 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 50.0, 75.0, 100.0, 110.0, 125.0 }

	for _, height in ipairs(groundCheckHeights) do
		local foundGround, z = GetGroundZFor_3dCoord(x, y, height)

		if foundGround then
			return z
		end
	end

	return 12.64
end

local function GenerateHeroinCoords(serverCoords)
	while true do
		Wait(1)

		local heroinCoordX, heroinCoordY

		math.randomseed(GetGameTimer())
		local modX = math.random(-60, 60)

		Wait(100)

		math.randomseed(GetGameTimer())
		local modY = math.random(-60, 60)

		heroinCoordX = serverCoords.Zones.HeroinField.coords.x + modX
		heroinCoordY = serverCoords.Zones.HeroinField.coords.y + modY

		local coordZ = GetCoordZHeroin(heroinCoordX, heroinCoordY)
		local coord = vector3(heroinCoordX, heroinCoordY, coordZ)

		if ValidateHeroinCoord(coord) then
			return coord
		end
	end
end

function SpawnPoppyPlants(serverCoords)
	local model = `prop_plant_01b`
	while spawnedPoppys < 15 do
		Wait(0)
		local heroinCoords = GenerateHeroinCoords(serverCoords)
		RequestModel(model)
		while not HasModelLoaded(model) do
			Wait(100)
		end
		local obj = CreateObject(model, heroinCoords.x, heroinCoords.y, heroinCoords.z, false, true, false)
		PlaceObjectOnGroundProperly(obj)
		FreezeEntityPosition(obj, true)
		table.insert(PoppyPlants, obj)
		spawnedPoppys += 1
	end
	SetModelAsNoLongerNeeded(model)
end

local function ProcessHeroin()
	isProcessing = true
	local playerPed = PlayerPedId()

	TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_PARKING_METER', 0, true)
	QBCore.Functions.Progressbar('doing_processing', Lang:t('progressbar.processing'), 6000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function()
		ClearPedTasks(playerPed)
		TriggerServerEvent('mrf_drugprocess:processPoppyResin')
		isProcessing = false
	end, function()
		ClearPedTasks(playerPed)
		isProcessing = false
	end)
end

RegisterNetEvent('mrf_drugprocess:ProcessPoppy', function()
	if not isProcessing then
		if not GetItem({poppyresin = 1}) then return end
		ProcessHeroin()
	else
		QBCore.Functions.Notify(Lang:t('error.already_processing'), 'error')
	end
end)

RegisterNetEvent('mrf_drugprocess:processHeroin',function()
	if not GetItem({poppyresin = 1}) then return end
	ProcessHeroin()
end)

RegisterNetEvent('mrf_drugprocess:pickHeroin', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	local nearbyObject, nearbyID

	for i=1, #PoppyPlants, 1 do
		if #(coords - GetEntityCoords(PoppyPlants[i])) < 2 then
			nearbyObject, nearbyID = PoppyPlants[i], i
		end
	end

	if nearbyObject and IsPedOnFoot(playerPed) then
		TaskStartScenarioInPlace(playerPed, 'world_human_gardener_plant', 0, false)
		QBCore.Functions.Progressbar('doing_processing', Lang:t('progressbar.collecting'), 8000, false, true, {
			disableMovement = true,
			disableCarMovement = true,
			disableMouse = false,
			disableCombat = true,
		}, {}, {}, {}, function()
			ClearPedTasks(playerPed)
			SetEntityAsMissionEntity(nearbyObject, false, true)
			DeleteObject(nearbyObject)
			table.remove(PoppyPlants, nearbyID)
			spawnedPoppys -= 1
			TriggerServerEvent('mrf_drugprocess:pickedUpPoppy')
		end, function()
			ClearPedTasks(playerPed)
		end)
	end
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for _, v in pairs(PoppyPlants) do
			SetEntityAsMissionEntity(v, false, true)
			DeleteObject(v)
		end
	end
end)