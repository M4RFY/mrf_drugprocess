RegisterServerEvent('mrf_drugprocess:pickedUpWeedSeed', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	if not Player then return end

	if Player.Functions.AddItem('weed_seed', 1) then
		TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items['weed_seed'], 'add', 1)
		TriggerClientEvent('QBCore:Notify', src, Lang:t('success.weed_seed'), 'success')
		TriggerEvent('qb-log:server:CreateLog', 'weedlogs', 'Drug Processing (Weed)', 'pink', ('**Player:** %s | **License:** ||(%s)||\n **Info:** Collected Weed Seed From Weed Location'):format(GetPlayerName(src), Player.PlayerData.license))
	end
end)

RegisterServerEvent('mrf_drugprocess:server:processWeedCannabis', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)

	if not Player then return end

	if Player.Functions.RemoveItem('weed_seed', 1) then
		if Player.Functions.AddItem('cannabis', 1) then
			TriggerClientEvent('qb-inventory:client:ItemBox', source, QBCore.Shared.Items['weed_seed'], 'remove', 1)
			TriggerClientEvent('qb-inventory:client:ItemBox', source, QBCore.Shared.Items['cannabis'], 'add', 1)
			TriggerClientEvent('QBCore:Notify', src, Lang:t('success.cannabis'), 'success')
			TriggerEvent('qb-log:server:CreateLog', 'weedlogs', 'Drug Processing (Weed)', 'pink', ('**Player:** %s | **License:** ||(%s)||\n **Info:** Processed Weed Seed Into Cannabis'):format(GetPlayerName(src), Player.PlayerData.license))
		else
			Player.Functions.AddItem('weed_seed', 1)
		end
	else
		TriggerClientEvent('QBCore:Notify', src, Lang:t('error.no_weed_seed'), 'error')
	end
end)

RegisterServerEvent('mrf_drugprocess:processCannabis', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)

	if not Player then return end

	if Player.Functions.RemoveItem('cannabis', 1) then
		if Player.Functions.RemoveItem('empty_weed_bag', 1) then
			if Player.Functions.AddItem('marijuana', 1) then
				TriggerClientEvent('qb-inventory:client:ItemBox', source, QBCore.Shared.Items['cannabis'], 'remove', 1)
				TriggerClientEvent('qb-inventory:client:ItemBox', source, QBCore.Shared.Items['empty_weed_bag'], 'remove', 1)
				TriggerClientEvent('qb-inventory:client:ItemBox', source, QBCore.Shared.Items['marijuana'], 'add', 1)
				TriggerClientEvent('QBCore:Notify', src, Lang:t('success.marijuana'), 'success')
				TriggerEvent('qb-log:server:CreateLog', 'weedlogs', 'Drug Processing (Weed)', 'pink', ('**Player:** %s | **License:** ||(%s)||\n **Info:** Processed Cannabis Into Marijuana'):format(GetPlayerName(src), Player.PlayerData.license))
			else
				Player.Functions.AddItem('cannabis', 1)
				Player.Functions.AddItem('empty_weed_bag', 1)
			end
		else
			Player.Functions.AddItem('cannabis', 1)
			TriggerClientEvent('QBCore:Notify', src, Lang:t('error.no_empty_weed_bag'), 'error')
		end
	else
		TriggerClientEvent('QBCore:Notify', src, Lang:t('error.no_cannabis'), 'error')
	end
end)