RegisterServerEvent('mrf_drugprocess:pickedUpHydrochloricAcid', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	if not Player then return end

	if Player.Functions.AddItem('hydrochloric_acid', 1) then
		TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items['hydrochloric_acid'], 'add', 1)
		TriggerEvent('qb-log:server:CreateLog', 'methlogs', 'Drug Processing (Meth)', 'pink', ('**Player:** %s | **License:** ||(%s)||\n **Info:** Collected Hydrochloric Acid From Location'):format(GetPlayerName(src), Player.PlayerData.license))
	end
end)

RegisterServerEvent('mrf_drugprocess:pickedUpSodiumHydroxide', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	if not Player then return end

	if Player.Functions.AddItem('sodium_hydroxide', 1) then
		TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items['sodium_hydroxide'], 'add', 1)
		TriggerEvent('qb-log:server:CreateLog', 'methlogs', 'Drug Processing (Meth)', 'pink', ('**Player:** %s | **License:** ||(%s)||\n **Info:** Collected Sodium Hydroxide From Location'):format(GetPlayerName(src), Player.PlayerData.license))
	end
end)

RegisterServerEvent('mrf_drugprocess:pickedUpSulfuricAcid', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	if not Player then return end

	if Player.Functions.AddItem('sulfuric_acid', 1) then
		TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items['sulfuric_acid'], 'add', 1)
		TriggerEvent('qb-log:server:CreateLog', 'methlogs', 'Drug Processing (Meth)', 'pink', ('**Player:** %s | **License:** ||(%s)||\n **Info:** Collected Sulfuric Acid From Location'):format(GetPlayerName(src), Player.PlayerData.license))
	end
end)

RegisterServerEvent('mrf_drugprocess:processChemicals', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	if not Player then return end

	if Player.Functions.RemoveItem('sulfuric_acid', 1) then
		if Player.Functions.RemoveItem('hydrochloric_acid', 1) then
			if Player.Functions.RemoveItem('sodium_hydroxide', 1) then
				if Player.Functions.AddItem('liquidmix', 1) then
					TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items['sulfuric_acid'], 'remove', 1)
					TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items['hydrochloric_acid'], 'remove', 1)
					TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items['sodium_hydroxide'], 'remove', 1)
					TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items['liquidmix'], 'add', 1)
					TriggerEvent('qb-log:server:CreateLog', 'methlogs', 'Drug Processing (Meth)', 'pink', ('**Player:** %s | **License:** ||(%s)||\n **Info:** Processed Items Into Liquid Mix'):format(GetPlayerName(src), Player.PlayerData.license))
				else
					Player.Functions.AddItem('sulfuric_acid', 1)
					Player.Functions.AddItem('hydrochloric_acid', 1)
					Player.Functions.AddItem('sodium_hydroxide', 1)
				end
			else
				Player.Functions.AddItem('sulfuric_acid', 1)
				Player.Functions.AddItem('hydrochloric_acid', 1)
				TriggerClientEvent('QBCore:Notify', src, Lang:t('error.no_sodium_hydroxide'), 'error')
			end
		else
			Player.Functions.AddItem('sulfuric_acid', 1)
			TriggerClientEvent('QBCore:Notify', src, Lang:t('error.no_hydrochloric_acid'), 'error')
		end
	else
		TriggerClientEvent('QBCore:Notify', src, Lang:t('error.no_sulfuric_acid'), 'error')
	end
end)

RegisterServerEvent('mrf_drugprocess:processTempUp', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	if not Player then return end

	if Player.Functions.RemoveItem('liquidmix', 1) then
		if Player.Functions.AddItem('chemicalvapor', 1) then
			TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items['liquidmix'], 'remove', 1)
			TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items['chemicalvapor'], 'add', 1)
		else
			Player.Functions.AddItem('liquidmix', 1)
		end
	else
		TriggerClientEvent('QBCore:Notify', src, Lang:t('error.no_liquidmix'), 'error')
	end
end)

RegisterServerEvent('mrf_drugprocess:processTempDown', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	if not Player then return end

	if Player.Functions.RemoveItem('chemicalvapor', 1) then
		if Player.Functions.AddItem('methtray', 1) then
			TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items['chemicalvapor'], 'remove', 1)
			TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items['methtray'], 'add', 1)
		else
			Player.Functions.AddItem('chemicalvapor', 1)
		end
	else
		TriggerClientEvent('QBCore:Notify', src, Lang:t('error.no_chemicalvapor'), 'error')
	end

end)

RegisterServerEvent('mrf_drugprocess:processMeth', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	if not Player then return end

	if Player.Functions.RemoveItem('methtray', 1) then
		if Player.Functions.AddItem('meth', math.random(8, 10)) then
			TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items['methtray'], 'remove', 1)
			TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items['meth'], 'add', 1)
			TriggerClientEvent('QBCore:Notify', src, Lang:t('success.meth'), 'success')
			TriggerEvent('qb-log:server:CreateLog', 'methlogs', 'Drug Processing (Meth)', 'pink', ('**Player:** %s | **License:** ||(%s)||\n **Info:** Processed And Received Meth'):format(GetPlayerName(src), Player.PlayerData.license))
		else
			Player.Functions.AddItem('methtray', 1)
		end
	else
		TriggerClientEvent('QBCore:Notify', src, Lang:t('error.no_chemicalvapor'), 'error')
	end
end)

RegisterServerEvent('mrf_drugprocess:processFailUp', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	if not Player then return end

	Player.Functions.RemoveItem('liquidmix', 1)
	TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items['liquidmix'], 'remove', 1)
	TriggerClientEvent('QBCore:Notify', src, Lang:t('error.temp_too_high'), 'error')
end)

RegisterServerEvent('mrf_drugprocess:processFailDown', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	if not Player then return end

	Player.Functions.RemoveItem('chemicalvapor', 1)
	TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items['chemicalvapor'], 'remove', 1)
	TriggerClientEvent('QBCore:Notify', src, Lang:t('error.temp_too_low'), 'error')
end)