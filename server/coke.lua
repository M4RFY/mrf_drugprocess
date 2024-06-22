RegisterServerEvent('mrf_drugprocess:pickedUpCocaLeaf', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	if Player.Functions.AddItem('coca_leaf', 1) then
		TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items['coca_leaf'], 'add', 1)
		TriggerClientEvent('QBCore:Notify', src, Lang:t('success.coca_leaf'), 'success')
		TriggerEvent('qb-log:server:CreateLog', 'cokelogs', 'Drug Processing (Coke)', 'pink', ('**Player:** %s | **License:** ||(%s)||\n **Info:** Collected Coke Leaf From Coke Location'):format(GetPlayerName(src), Player.PlayerData.license))
	else
		TriggerClientEvent('QBCore:Notify', src, Lang:t('error.no_coca_leaf'), 'error')
	end
end)

RegisterServerEvent('mrf_drugprocess:processCocaLeaf', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)

	if Player.Functions.RemoveItem('coca_leaf', 1) then
		if Player.Functions.AddItem('coke', 1) then
			TriggerClientEvent('qb-inventory:client:ItemBox', source, QBCore.Shared.Items['coca_leaf'], 'remove', 1)
			TriggerClientEvent('qb-inventory:client:ItemBox', source, QBCore.Shared.Items['coke'], 'add', 1)
			TriggerClientEvent('QBCore:Notify', src, Lang:t('success.coke'), 'success')
			TriggerEvent('qb-log:server:CreateLog', 'cokelogs', 'Drug Processing (Coke)', 'pink', ('**Player:** %s | **License:** ||(%s)||\n **Info:** Processed Coke Leaf Into Coke'):format(GetPlayerName(src), Player.PlayerData.license))
		else
			Player.Functions.AddItem('coca_leaf', 1)
		end
	else
		TriggerClientEvent('QBCore:Notify', src, Lang:t('error.no_coca_leaf'), 'error')
	end
end)

RegisterServerEvent('mrf_drugprocess:processCocaPowder', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)

	if Player.Functions.RemoveItem('coke', 1) then
		if Player.Functions.RemoveItem('bakingsoda', 1) then
			if Player.Functions.AddItem('coke_small_brick', 1) then
				TriggerClientEvent('qb-inventory:client:ItemBox', source, QBCore.Shared.Items['coke'], 'remove', 1)
				TriggerClientEvent('qb-inventory:client:ItemBox', source, QBCore.Shared.Items['bakingsoda'], 'remove', 1)
				TriggerClientEvent('qb-inventory:client:ItemBox', source, QBCore.Shared.Items['coke_small_brick'], 'add', 1)
				TriggerClientEvent('QBCore:Notify', src, Lang:t('success.coke_small_brick'), 'success')
				TriggerEvent('qb-log:server:CreateLog', 'cokelogs', 'Drug Processing (Coke)', 'pink', ('**Player:** %s | **License:** ||(%s)||\n **Info:** Processed Coke Into Small Brick'):format(GetPlayerName(src), Player.PlayerData.license))
			else
				Player.Functions.AddItem('coke', 1)
				Player.Functions.AddItem('bakingsoda', 1)
			end
		else
			Player.Functions.AddItem('coke', 1)
			TriggerClientEvent('QBCore:Notify', src, Lang:t('error.no_bakingsoda'), 'error')
		end
	else
		TriggerClientEvent('QBCore:Notify', src, Lang:t('error.no_cokain'), 'error')
	end
end)

RegisterServerEvent('mrf_drugprocess:processCocaBrick', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)

	if Player.Functions.RemoveItem('coke_small_brick', 1) then
		if Player.Functions.AddItem('coke_brick', 1) then
			TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items['coke_small_brick'], 'remove', 1)
			TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items['coke_brick'], 'add', 1)
			TriggerClientEvent('QBCore:Notify', src, Lang:t('success.coke_brick'), 'success')
			TriggerEvent('qb-log:server:CreateLog', 'cokelogs', 'Drug Processing (Coke)', 'pink', ('**Player:** %s | **License:** ||(%s)||\n **Info:** Processed Small Brick Into Coke Brick'):format(GetPlayerName(src), Player.PlayerData.license))
		else
			Player.Functions.AddItem('coke_small_brick', 1)
		end
	end
end)