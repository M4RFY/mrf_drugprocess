local SpawnedChemicals = 0
local Chemicals = {}
inChemicalField = false

local function createChemicalMenu()
    local chemMenu = {
        {
            isHeader = true,
            header = Lang:t('menu.chemMenuHeader'),
			params = {}
        },
        {
            header = Lang:t('items.hydrochloric_acid'),
            txt = Lang:t('menu.chemicals'),
			params = {
                event = 'mrf_drugprocess:hydrochloric_acid',
            }
        },
        {
            header = Lang:t('items.sodium_hydroxide'),
            txt = Lang:t('menu.chemicals'),
			params = {
                event = 'mrf_drugprocess:sodium_hydroxide',
            }
        },
        {
            header = Lang:t('items.sulfuric_acid'),
            txt = Lang:t('menu.chemicals'),
			params = {
                event = 'mrf_drugprocess:sulfuric_acid',
            }
        },
        {
			header = Lang:t('items.lsa'),
            txt = Lang:t('menu.chemicals'),
			params = {
                event = 'mrf_drugprocess:lsa',
            }
        },
        {
            header = Lang:t('menu.close'),
			txt = Lang:t('menu.closetxt'),
			params = {
                event = exports['qb-menu']:closeMenu(),
            }
        }
    }
    exports['qb-menu']:openMenu(chemMenu)
end
RegisterNetEvent('mrf_drugprocess:chemicalmenu', createChemicalMenu)

local function ValidatechemicalsCoord(plantCoord)
	local validate = true
	if SpawnedChemicals > 0 then
		for _, v in pairs(Chemicals) do
			if #(plantCoord-GetEntityCoords(v)) < 5 then
				validate = false
			end
		end
		if not inChemicalField then
			validate = false
		end
	end
	return validate
end

local function GetCoordZChemicals(x, y)
	local groundCheckHeights = { 1, 5.0, 10.0, 15.0, 20.0, 25.0, 30.0, 35.0, 40.0, 315.0, 320.0 }

	for i, height in ipairs(groundCheckHeights) do
		local foundGround, z = GetGroundZFor_3dCoord(x, y, height)
		if foundGround then
			return z
		end
	end

	return 5.9
end

local function GeneratechemicalsCoords(serverCoords)
	while inChemicalField do
		Wait(1)

		local chemicalsCoordX, chemicalsCoordY

		math.randomseed(GetGameTimer())
		local modX = math.random(-20, 20)

		Wait(100)

		math.randomseed(GetGameTimer())
		local modY = math.random(-20, 20)

		chemicalsCoordX = serverCoords.Zones.ChemicalFarm.coords.x + modX
		chemicalsCoordY = serverCoords.Zones.ChemicalFarm.coords.y + modY

		local coordZ = GetCoordZChemicals(chemicalsCoordX, chemicalsCoordY)
		local coord = vector3(chemicalsCoordX, chemicalsCoordY, coordZ)

		if ValidatechemicalsCoord(coord) then
			return coord
		end
	end
end

function SpawnChemicals(serverCoords)
	local model = `mw_chemical_barrel`
	while SpawnedChemicals < 10 do
		Wait(0)
		local chemicalsCoords = GeneratechemicalsCoords(serverCoords)
		RequestModel(model)
		while not HasModelLoaded(model) do
			Wait(100)
		end
		local obj = CreateObject(model, chemicalsCoords.x, chemicalsCoords.y, chemicalsCoords.z, false, true, false)
		PlaceObjectOnGroundProperly(obj)
		FreezeEntityPosition(obj, true)
		table.insert(Chemicals, obj)
		SpawnedChemicals += 1
	end
	SetModelAsNoLongerNeeded(model)
end

local function ProcessHydrochloric()
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
		TriggerServerEvent('mrf_drugprocess:processHydrochloricAcid')
		isProcessing = false
	end, function()
		ClearPedTasks(playerPed)
		isProcessing = false
	end)
end

local function ProcessLsa()
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
		TriggerServerEvent('mrf_drugprocess:processLsa')
		isProcessing = false
	end, function()
		ClearPedTasks(playerPed)
		isProcessing = false
	end)
end

local function ProcessSulfuric()
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
		TriggerServerEvent('mrf_drugprocess:processprocessSulfuricAcid')
		isProcessing = false
	end, function()
		ClearPedTasks(playerPed)
		isProcessing = false
	end)
end

local function ProcessSodiumHydroxide()
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
		TriggerServerEvent('mrf_drugprocess:processsodiumHydroxide')
		isProcessing = false
	end, function()
		ClearPedTasks(playerPed)
		isProcessing = false
	end)
end

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for _, v in pairs(Chemicals) do
			SetEntityAsMissionEntity(v, false, true)
			DeleteObject(v)
		end
	end
end)

RegisterNetEvent('mrf_drugprocess:hydrochloric_acid', function()
	if not GetItem({chemicals = 1}) then return end
	ProcessHydrochloric()
end)

RegisterNetEvent('mrf_drugprocess:lsa', function()
	if not GetItem({chemicals = 1}) then return end
	ProcessLsa()
end)

RegisterNetEvent('mrf_drugprocess:sulfuric_acid', function()
	if not GetItem({chemicals = 1}) then return end
	ProcessSulfuric()
end)

RegisterNetEvent('mrf_drugprocess:sodium_hydroxide', function()
	if not GetItem({chemicals = 1}) then return end
	ProcessSodiumHydroxide()
end)

RegisterNetEvent('mrf_drugprocess:pickChemicals', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	local nearbyObject, nearbyID

	for i=1, #Chemicals, 1 do
		if #(coords-GetEntityCoords(Chemicals[i])) < 2 then
			nearbyObject, nearbyID = Chemicals[i], i
		end
	end

	if nearbyObject and IsPedOnFoot(playerPed) then
		isPickingUp = true
		TaskStartScenarioInPlace(playerPed, 'world_human_gardener_plant', 0, false)
		QBCore.Functions.Progressbar('doing_processing', Lang:t('progressbar.pickup_chemicals'), 8000, false, true, {
			disableMovement = true,
			disableCarMovement = true,
			disableMouse = false,
			disableCombat = true,
		}, {}, {}, {}, function()
			ClearPedTasks(playerPed)
			SetEntityAsMissionEntity(nearbyObject, false, true)
			DeleteObject(nearbyObject)
			table.remove(Chemicals, nearbyID)
			SpawnedChemicals -= 1
			TriggerServerEvent('mrf_drugprocess:pickedUpChemicals')
			isPickingUp = false
		end, function()
			ClearPedTasks(playerPed)
			isPickingUp = false
		end)
	end
end)