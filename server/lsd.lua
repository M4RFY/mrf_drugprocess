RegisterServerEvent('mrf_drugprocess:Processlsd', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	if not Player then return end

	if Player.Functions.RemoveItem('lsa', 1) then
		if Player.Functions.RemoveItem('thionyl_chloride', 1) then
			if Player.Functions.AddItem('lsd', 1) then
				TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items['lsd'], 'add', 1)
				TriggerClientEvent('QBCore:Notify', src, Lang:t('success.lsd'), 'success')
				TriggerEvent('qb-log:server:CreateLog', 'lsdlogs', 'Drug Processing (LSD)', 'pink', ('**Player:** %s | **License:** ||(%s)||\n **Info:** Processed LSA Into LSD'):format(GetPlayerName(src), Player.PlayerData.license))
			else
				Player.Functions.AddItem('lsa', 1)
				Player.Functions.AddItem('thionyl_chloride', 1)
			end
		else
			Player.Functions.AddItem('lsa', 1)
			TriggerClientEvent('QBCore:Notify', src, Lang:t('error.no_thionyl_chloride'), 'error')
		end
	else
		TriggerClientEvent('QBCore:Notify', src, Lang:t('error.no_lsa'), 'error')
	end
end)

RegisterServerEvent('mrf_drugprocess:processThionylChloride', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	if not Player then return end

	if Player.Functions.RemoveItem('lsa', 1) then
		if Player.Functions.RemoveItem('chemicals', 1) then
			if Player.Functions.AddItem('thionyl_chloride', 1) then
				TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items['thionyl_chloride'], 'add', 1)
				TriggerClientEvent('QBCore:Notify', src, Lang:t('success.thionyl_chloride'), 'success')
				TriggerEvent('qb-log:server:CreateLog', 'lsdlogs', 'Drug Processing (LSD)', 'pink', ('**Player:** %s | **License:** ||(%s)||\n **Info:** Processed Chemicals Into Thionyl Chloride'):format(GetPlayerName(src), Player.PlayerData.license))
			else
				Player.Functions.AddItem('lsa', 1)
				Player.Functions.AddItem('chemicals', 1)
			end
		else
			Player.Functions.AddItem('lsa', 1)
			TriggerClientEvent('QBCore:Notify', src, Lang:t('error.no_chemicals'), 'error')
		end
	else
		TriggerClientEvent('QBCore:Notify', src, Lang:t('error.no_lsa'), 'error')
	end
end)