local isProcessing = false
local isTempChangeU = false
local isTempChangeD = false
local isBagging = false

local function ProcessChemicals()
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
		TriggerServerEvent('mrf_drugprocess:processChemicals')
		isProcessing = false
	end, function()
		ClearPedTasks(playerPed)
		isProcessing = false
	end)
end

local function ProcessTempUp()
	isTempChangeU = true
	local playerPed = PlayerPedId()

	TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_PARKING_METER', 0, true)
	QBCore.Functions.Progressbar('doing_processing', Lang:t('progressbar.temp_up'), 6000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function()
		ClearPedTasks(playerPed)
		TriggerServerEvent('mrf_drugprocess:processTempUp')
		isTempChangeU = false
	end, function()
		ClearPedTasks(playerPed)
		isTempChangeU = false
	end)
end

local function ProcessTempDown()
	isTempChangeD = true
	local playerPed = PlayerPedId()

	TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_PARKING_METER', 0, true)
	QBCore.Functions.Progressbar('doing_processing', Lang:t('progressbar.temp_down'), 6000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function()
		ClearPedTasks(playerPed)
		TriggerServerEvent('mrf_drugprocess:processTempDown')
		isTempChangeD = false
	end, function()
		ClearPedTasks(playerPed)
		isTempChangeD = false
	end)
end

local function ProcessProduct()
	isBagging = true
	local playerPed = PlayerPedId()

	TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_PARKING_METER', 0, true)
	QBCore.Functions.Progressbar('doing_processing', Lang:t('progressbar.packing'), 6000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function()
		ClearPedTasks(playerPed)
		TriggerServerEvent('mrf_drugprocess:processMeth')
		isBagging = false
	end, function()
		ClearPedTasks(playerPed)
		isBagging = false
	end)
end

RegisterNetEvent('mrf_drugprocess:ProcessChemicals', function()
	if not isProcessing then
		if not GetItem({sulfuric_acid = 1, hydrochloric_acid = 1, sodium_hydroxide = 1}) then return end
		ProcessChemicals()
	else
		QBCore.Functions.Notify(Lang:t('error.already_processing'), 'error')
	end
end)

RegisterNetEvent('mrf_drugprocess:ChangeTemp', function()
	if not isTempChangeU then
		if not GetItem({liquidmix = 1}) then return end
		exports['ps-ui']:Thermite(function(success)
			if success then
				QBCore.Functions.Notify(Lang:t('success.temp_up'), 'success')
				ProcessTempUp()
			else
				TriggerServerEvent('mrf_drugprocess:processFailUp')
			end
		end, 10, 5, 3)
	else
		QBCore.Functions.Notify(Lang:t('error.enough_temp'), 'error')
	end
end)

RegisterNetEvent('mrf_drugprocess:ChangeTemp2', function()
	if not isTempChangeD then
		if not GetItem({chemicalvapor = 1}) then return end
		exports['ps-ui']:Thermite(function(success)
			if success then
				QBCore.Functions.Notify(Lang:t('success.temp_down'), 'success')
				ProcessTempDown()
			else
				TriggerServerEvent('mrf_drugprocess:processFailDown')
			end
		end, 10, 5, 3)
	else
		QBCore.Functions.Notify(Lang:t('error.enough_temp'), 'error')
	end
end)

RegisterNetEvent('mrf_drugprocess:ProcessProduct', function()
	if not isBagging then
		if not GetItem({methtray = 1}) then return end
		ProcessProduct()
	else
		QBCore.Functions.Notify(Lang:t('error.already_processing'), 'error')
	end
end)