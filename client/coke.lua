local spawnedCocaLeaf = 0
local CocaPlants = {}
local isPickingUp, isProcessing = false, false
inCokeField = false

local function ProcessCoke()
	isProcessing = true
	local playerPed = PlayerPedId()
	TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_PARKING_METER', 0, true)

	QBCore.Functions.Progressbar('search_register', Lang:t('progressbar.processing'), 15000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function()
		TriggerServerEvent('mrf_drugprocess:processCocaLeaf')
		ClearPedTasks(playerPed)
		isProcessing = false
	end, function()
		ClearPedTasks(playerPed)
		isProcessing = false
	end)
end

local function ValidateCocaLeafCoord(plantCoord)
	local validate = true
	if spawnedCocaLeaf > 0 then
		for _, v in pairs(CocaPlants) do
			if #(plantCoord - GetEntityCoords(v)) < 5 then
				validate = false
			end
		end
		if not inCokeField then
			validate = false
		end
	end
	return validate
end

local function GetCoordZCoke(x, y)
	local groundCheckHeights = { 1.0, 25.0, 50.0, 73.0, 74.0, 75.0, 76.0, 77.0, 78.0, 79.0, 80.0 }

	for _, height in ipairs(groundCheckHeights) do
		local foundGround, z = GetGroundZFor_3dCoord(x, y, height)

		if foundGround then
			return z
		end
	end

	return 77
end

local function GenerateCocaLeafCoords(serverCoords)
	while true do
		Wait(1)

		local cokeCoordX, cokeCoordY

		math.randomseed(GetGameTimer())
		local modX = math.random(-35, 35)

		Wait(100)

		math.randomseed(GetGameTimer())
		local modY = math.random(-35, 35)

		cokeCoordX = serverCoords.Zones.CokeField.coords.x + modX
		cokeCoordY = serverCoords.Zones.CokeField.coords.y + modY

		local coordZ = GetCoordZCoke(cokeCoordX, cokeCoordY)
		local coord = vector3(cokeCoordX, cokeCoordY, coordZ)

		if ValidateCocaLeafCoord(coord) then
			return coord
		end
	end
end

function SpawnCocaPlants(serverCoords)
	local model = `h4_prop_bush_cocaplant_01`
	while spawnedCocaLeaf < 15 do
		Wait(0)
		local cokeCoords = GenerateCocaLeafCoords(serverCoords)
		RequestModel(model)
		while not HasModelLoaded(model) do
			Wait(100)
		end
		local obj = CreateObject(model, cokeCoords.x, cokeCoords.y, cokeCoords.z, false, true, false)
		PlaceObjectOnGroundProperly(obj)
		FreezeEntityPosition(obj, true)
		table.insert(CocaPlants, obj)
		spawnedCocaLeaf += 1
	end
	SetModelAsNoLongerNeeded(model)
end

local function CutCokePowder()
	isProcessing = true
	local playerPed = PlayerPedId()

	TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_PARKING_METER', 0, true)
	QBCore.Functions.Progressbar('search_register', Lang:t('progressbar.processing'), 15000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function()
		TriggerServerEvent('mrf_drugprocess:processCocaPowder')
		ClearPedTasks(playerPed)
		isProcessing = false
	end, function()
		ClearPedTasks(playerPed)
		isProcessing = false
	end)
end

local function ProcessBricks()
	isProcessing = true
	local playerPed = PlayerPedId()

	TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_PARKING_METER', 0, true)
	QBCore.Functions.Progressbar('search_register', Lang:t('progressbar.packing'), 15000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function()
		TriggerServerEvent('mrf_drugprocess:processCocaBrick')
		ClearPedTasks(playerPed)
		isProcessing = false
	end, function()
		ClearPedTasks(playerPed)
		isProcessing = false
	end)
end

RegisterNetEvent('mrf_drugprocess:ProcessCocaFarm', function()
    if not isProcessing then
        if not GetItem({coca_leaf = 1, trimming_scissors = 1}) then return end
        ProcessCoke()
    else
        QBCore.Functions.Notify(Lang:t('error.already_processing'), 'error')
    end
end)

RegisterNetEvent('mrf_drugprocess:ProcessCocaPowder', function()
    if not isProcessing then
        if not GetItem({coke = 1, bakingsoda = 1, finescale = 1}) then return end
        CutCokePowder()
    else
        QBCore.Functions.Notify(Lang:t('error.already_processing'), 'error')
    end
end)

RegisterNetEvent('mrf_drugprocess:ProcessBricks', function()
    if not isProcessing then
        if not GetItem({coke_small_brick = 1, finescale = 1}) then return end
        ProcessBricks()
    else
        QBCore.Functions.Notify(Lang:t('error.already_processing'), 'error')
    end
end)

RegisterNetEvent('mrf_drugprocess:pickCocaLeaves', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	local nearbyObject, nearbyID

	for i = 1, #CocaPlants, 1 do
		if #(coords - GetEntityCoords(CocaPlants[i])) < 2 then
			nearbyObject, nearbyID = CocaPlants[i], i
		end
	end

	if nearbyObject and IsPedOnFoot(playerPed) then
		if not isPickingUp then
			isPickingUp = true
			TaskStartScenarioInPlace(playerPed, 'world_human_gardener_plant', 0, false)
			QBCore.Functions.Progressbar('search_register', Lang:t('progressbar.collecting'), 5000, false, true, {
				disableMovement = true,
				disableCarMovement = true,
				disableMouse = false,
				disableCombat = true,
			}, {}, {}, {}, function()
				ClearPedTasks(playerPed)
				SetEntityAsMissionEntity(nearbyObject, false, true)
				DeleteObject(nearbyObject)
				table.remove(CocaPlants, nearbyID)
				spawnedCocaLeaf -= 1
				TriggerServerEvent('mrf_drugprocess:pickedUpCocaLeaf')
				isPickingUp = false
			end, function()
				ClearPedTasks(playerPed)
				isPickingUp = false
			end)
		end
	end
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for _, v in pairs(CocaPlants) do
			SetEntityAsMissionEntity(v, false, true)
			DeleteObject(v)
		end
	end
end)