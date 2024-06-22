local isProcessing = false

local function Processlsd()
	isProcessing = true
	local playerPed = PlayerPedId()

	TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_PARKING_METER', 0, true)
	QBCore.Functions.Progressbar('doing_processing', Lang:t('progressbar.processing'), 6000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
		disableKeyboard = true,
	}, {}, {}, {}, function()
		ClearPedTasks(playerPed)
		TriggerServerEvent('mrf_drugprocess:Processlsd')
		isProcessing = false
	end, function()
		ClearPedTasks(playerPed)
		isProcessing = false
	end)
end

local function Processthionylchloride()
	isProcessing = true
	local playerPed = PlayerPedId()

	TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_PARKING_METER', 0, true)
	QBCore.Functions.Progressbar('doing_processing', Lang:t('progressbar.processing'), 6000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
		disableKeyboard = true,
	}, {}, {}, {}, function()
		ClearPedTasks(playerPed)
		TriggerServerEvent('mrf_drugprocess:processThionylChloride')
		isProcessing = false
	end, function()
		ClearPedTasks(playerPed)
		isProcessing = false
	end)
end

RegisterNetEvent('mrf_drugprocess:processingLSD', function()
	if not isProcessing then
		if not GetItem({lsa = 1, thionyl_chloride = 1}) then return end
		Processlsd()
	else
		QBCore.Functions.Notify(Lang:t('error.already_processing'), 'error')
	end
end)

RegisterNetEvent('mrf_drugprocess:processingThiChlo', function()
	if not isProcessing then
		if not GetItem({lsa = 1, chemicals = 1}) then return end
		Processthionylchloride()
	else
		QBCore.Functions.Notify(Lang:t('error.already_processing'), 'error')
	end
end)