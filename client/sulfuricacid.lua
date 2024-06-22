local spawnedSulfuricAcidBarrels = 0
local SulfuricAcidBarrels = {}
inSulfuricFarm = false

local function ValidateSulfuricAcidCoord(plantCoord)
	local validate = true
	if spawnedSulfuricAcidBarrels > 0 then
		for _, v in pairs(SulfuricAcidBarrels) do
			if #(plantCoord - GetEntityCoords(v)) < 5 then
				validate = false
			end
		end
		if not inSulfuricFarm then
			validate2 = false
		end
	end
	return validate
end

local function GetCoordZSulfuricAcid(x, y)
	local groundCheckHeights = { 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0, 17.0, 18.0, 19.0, 150.0 }

	for _, height in ipairs(groundCheckHeights) do
		local foundGround, z = GetGroundZFor_3dCoord(x, y, height)

		if foundGround then
			return z
		end
	end

	return 18.31
end

local function GenerateSulfuricAcidCoords(serverCoords)
	while true do
		Wait(1)

		local sulCoordX, sulCoordY

		math.randomseed(GetGameTimer())
		local modX = math.random(-7, 7)

		Wait(100)

		math.randomseed(GetGameTimer())
		local modY = math.random(-7, 7)

		sulCoordX = serverCoords.Zones.SulfuricAcidFarm.coords.x + modX
		sulCoordY = serverCoords.Zones.SulfuricAcidFarm.coords.y + modY

		local coordZ = GetCoordZSulfuricAcid(sulCoordX, sulCoordY)
		local coord = vector3(sulCoordX, sulCoordY, coordZ)

		if ValidateSulfuricAcidCoord(coord) then
			return coord
		end
	end
end

function SpawnSulfuricAcidBarrels(serverCoords)
	local model = `mw_sulfuric_barrel`
	while spawnedSulfuricAcidBarrels < 10 do
		Wait(0)
		local sulCoords = GenerateSulfuricAcidCoords(serverCoords)
		RequestModel(model)
		while not HasModelLoaded(model) do
			Wait(100)
		end
		local obj = CreateObject(model, sulCoords.x, sulCoords.y, sulCoords.z, false, true, false)
		PlaceObjectOnGroundProperly(obj)
		FreezeEntityPosition(obj, true)
		table.insert(SulfuricAcidBarrels, obj)
		spawnedSulfuricAcidBarrels += 1
	end
	SetModelAsNoLongerNeeded(model)
end

RegisterNetEvent('mrf_drugprocess:pickSulfuric', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	local nearbyObject, nearbyID

	for i=1, #SulfuricAcidBarrels, 1 do
		if #(coords - GetEntityCoords(SulfuricAcidBarrels[i])) < 2 then
			nearbyObject, nearbyID = SulfuricAcidBarrels[i], i
		end
	end

	if nearbyObject and IsPedOnFoot(playerPed) then
		if not isPickingUp then
			isPickingUp = true
			TaskStartScenarioInPlace(playerPed, 'world_human_gardener_plant', 0, false)
			QBCore.Functions.Progressbar('doing_processing', Lang:t('progressbar.collecting'), 8000, false, true, {
				disableMovement = true,
				disableCarMovement = true,
				disableMouse = false,
				disableCombat = true,
			}, {}, {}, {}, function()
				ClearPedTasks(PlayerPedId())
				SetEntityAsMissionEntity(nearbyObject, false, true)
				DeleteObject(nearbyObject)
				table.remove(SulfuricAcidBarrels, nearbyID)
				spawnedSulfuricAcidBarrels -= 1
				TriggerServerEvent('mrf_drugprocess:pickedUpSulfuricAcid')
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
		for _, v in pairs(SulfuricAcidBarrels) do
			SetEntityAsMissionEntity(v, false, true)
			DeleteObject(v)
		end
	end
end)