RegisterServerEvent('mrf_drugprocess:pickedUpChemicals', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	if not Player then return end

	if Player.Functions.AddItem('chemicals', 1) then
		TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items['chemicals'], 'add', 1)
		TriggerClientEvent('QBCore:Notify', src, Lang:t('success.chemicals'), 'success')
		TriggerEvent('qb-log:server:CreateLog', 'chemicalslog', 'Drug Processing (Chemicals)', 'pink', ('**Player:** %s | **License:** ||(%s)||\n **Info:** Collected Chemical Container From Chemical Location'):format(GetPlayerName(src), Player.PlayerData.license))
	end
end)

RegisterServerEvent('mrf_drugprocess:processHydrochloricAcid', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)

	if not Player then return end

	if Player.Functions.RemoveItem('chemicals', 1) then
		if Player.Functions.AddItem('hydrochloric_acid', 1) then
			TriggerClientEvent('qb-inventory:client:ItemBox', source, QBCore.Shared.Items['chemicals'], 'remove', 1)
			TriggerClientEvent('qb-inventory:client:ItemBox', source, QBCore.Shared.Items['hydrochloric_acid'], 'add', 1)
			TriggerClientEvent('QBCore:Notify', src, Lang:t('success.hydrochloric_acid'), 'success')
			TriggerEvent('qb-log:server:CreateLog', 'chemicalslog', 'Drug Processing (Chemicals)', 'pink', ('**Player:** %s | **License:** ||(%s)||\n **Info:** Processed Container Into Hydrochloric Acid'):format(GetPlayerName(src), Player.PlayerData.license))
		else
			Player.Functions.AddItem('chemicals', 1)
		end
	else
		TriggerClientEvent('QBCore:Notify', src, Lang:t('error.no_chemicals'), 'error')
	end
end)

RegisterServerEvent('mrf_drugprocess:processsodiumHydroxide', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)

	if not Player then return end

	if Player.Functions.RemoveItem('chemicals', 1) then
		if Player.Functions.AddItem('sodium_hydroxide', 1) then
			TriggerClientEvent('qb-inventory:client:ItemBox', source, QBCore.Shared.Items['chemicals'], 'remove', 1)
			TriggerClientEvent('qb-inventory:client:ItemBox', source, QBCore.Shared.Items['sodium_hydroxide'], 'add', 1)
			TriggerClientEvent('QBCore:Notify', src, Lang:t('success.sodium_hydroxide'), 'success')
			TriggerEvent('qb-log:server:CreateLog', 'chemicalslog', 'Drug Processing (Chemicals)', 'pink', ('**Player:** %s | **License:** ||(%s)||\n **Info:** Processed Container Into Sodium Hydroxide'):format(GetPlayerName(src), Player.PlayerData.license))
		else
			Player.Functions.AddItem('chemicals', 1)
		end
	else
		TriggerClientEvent('QBCore:Notify', src, Lang:t('error.no_chemicals'), 'error')
	end
end)

RegisterServerEvent('mrf_drugprocess:processprocessSulfuricAcid', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)

	if not Player then return end

	if Player.Functions.RemoveItem('chemicals', 1) then
		if Player.Functions.AddItem('sulfuric_acid', 1) then
			TriggerClientEvent('qb-inventory:client:ItemBox', source, QBCore.Shared.Items['chemicals'], 'remove', 1)
			TriggerClientEvent('qb-inventory:client:ItemBox', source, QBCore.Shared.Items['sulfuric_acid'], 'add', 1)
			TriggerClientEvent('QBCore:Notify', src, Lang:t('success.sulfuric_acid'), 'success')
			TriggerEvent('qb-log:server:CreateLog', 'chemicalslog', 'Drug Processing (Chemicals)', 'pink', ('**Player:** %s | **License:** ||(%s)||\n  **Info:** Processed Container Into Sulfuric Acid'):format(GetPlayerName(src), Player.PlayerData.license))
		else
			Player.Functions.AddItem('chemicals', 1)
		end
	else
		TriggerClientEvent('QBCore:Notify', src, Lang:t('error.no_chemicals'), 'error')
	end
end)

RegisterServerEvent('mrf_drugprocess:processLsa', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)

	if not Player then return end

	if Player.Functions.RemoveItem('chemicals', 1) then
		if Player.Functions.AddItem('lsa', 1) then
			TriggerClientEvent('qb-inventory:client:ItemBox', source, QBCore.Shared.Items['chemicals'], 'remove', 1)
			TriggerClientEvent('qb-inventory:client:ItemBox', source, QBCore.Shared.Items['lsa'], 'add', 1)
			TriggerClientEvent('QBCore:Notify', src, Lang:t('success.lsa'), 'success')
			TriggerEvent('qb-log:server:CreateLog', 'chemicalslog', 'Drug Processing (Chemicals)', 'pink', ('**Player:** %s | **License:** ||(%s)||\n  **Info:** Processed Container Into LSA'):format(GetPlayerName(src), Player.PlayerData.license))
		else
			Player.Functions.AddItem('chemicals', 1)
		end
	else
		TriggerClientEvent('QBCore:Notify', src, Lang:t('error.no_chemicals'), 'error')
	end
end)