RegisterServerEvent('mrf_drugprocess:pickedUpPoppy', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	if not Player then return end

	if Player.Functions.AddItem('poppyresin', 1) then
		TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items['poppyresin'], 'add', 1)
		TriggerClientEvent('QBCore:Notify', src, Lang:t('success.poppyresin'), 'success')
		TriggerEvent('qb-log:server:CreateLog', 'heroinlogs', 'Drug Processing (Heroin)', 'pink', ('**Player:** %s | **License:** ||(%s)||\n **Info:** Collected Poppy From Poppy Plant Location'):format(GetPlayerName(src), Player.PlayerData.license))
	end
end)

RegisterServerEvent('mrf_drugprocess:processPoppyResin', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)

	if not Player then return end

	if Player.Functions.RemoveItem('poppyresin', 1) then
		if Player.Functions.AddItem('heroin', 1) then
			TriggerClientEvent('qb-inventory:client:ItemBox', source, QBCore.Shared.Items['poppyresin'], 'remove', 1)
			TriggerClientEvent('qb-inventory:client:ItemBox', source, QBCore.Shared.Items['heroin'], 'add', 1)
			TriggerClientEvent('QBCore:Notify', src, Lang:t('success.heroin'), 'success')
			TriggerEvent('qb-log:server:CreateLog', 'heroinlogs', 'Drug Processing (Heroin)', 'pink', ('**Player:** %s | **License:** ||(%s)||\n **Info:** Processed Poppy Into Heroin'):format(GetPlayerName(src), Player.PlayerData.license))
		else
			Player.Functions.AddItem('poppyresin', 1)
		end
	else
		TriggerClientEvent('QBCore:Notify', src, Lang:t('error.no_poppy_resin'), 'error')
	end
end)