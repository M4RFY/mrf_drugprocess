local serverCoords

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
	Wait(200)
	lib.callback('requestCoordinates', 200, function(pos)
		serverCoords = pos
	end)
end)

AddEventHandler('onResourceStart', function(res)
	if res == GetCurrentResourceName() then
		if LocalPlayer.state.isLoggedIn then
			Wait(500)
			lib.callback('requestCoordinates', 200, function(pos)
				serverCoords = pos
			end)
		end
	end
end)

local function addTargetBoxZone(name, coords, length, width, heading, minZ, maxZ, event, icon, label)
    exports['qb-target']:AddBoxZone(name, vec3(coords.vector), length, width, {
        name = name,
        heading = heading,
        debugPoly = false,
        minZ = minZ,
        maxZ = maxZ,
    }, {
        options = {
            {
                type = 'client',
                event = event,
                icon = icon,
                label = Lang:t(label),
            },
        },
        distance = 2.0
    })
end

local function addLabPoint(coords, teleportCoords, labelText)
    local point = lib.points.new({
        coords = coords,
        distance = 2.0,
        nearby = function(self)
            lib.showTextUI('[E] - ' .. Lang:t(labelText), {
                position = 'left-center',
                icon = 'fas fa-door-open'
            })
            DrawMarker(2, self.coords.x, self.coords.y, self.coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.25, 0.2, 0.1, 255, 255, 255, 155, false, false, 0, true, 0, 0, false)
            if IsControlJustPressed(1, 51) then
                Teleport(teleportCoords)
            end
        end,
        onExit = function()
            lib.hideTextUI()
        end
    })
end

local function addTargetModel(model, event, icon, label)
    exports['qb-target']:AddTargetModel(model, {
        options = {
            {
                type = 'client',
                event = event,
                icon = icon,
                label = Lang:t(label),
            },
        },
        distance = 2.5
    })
end

local function addZone(coords, radius, zoneName, enterCallback, exitCallback)
    local zone = CircleZone:Create(coords, radius, {
        name = zoneName,
        debugPoly = false
    })

    zone:onPlayerInOut(function(isPointInside)
        if isPointInside then
            enterCallback()
        else
            exitCallback()
        end
    end)
end

CreateThread(function()
    while serverCoords == nil do
        Wait(300)
    end

    -- Interactions

    addTargetBoxZone('methprocess', serverCoords.methprocess, serverCoords.methprocess.length, serverCoords.methprocess.width, 0, serverCoords.methprocess.minZ, serverCoords.methprocess.maxZ, 'mrf_drugprocess:ProcessChemicals', 'fas fa-vials', 'target.methprocess')
    addTargetBoxZone('methtempup', serverCoords.methtempup, serverCoords.methtempup.length, serverCoords.methtempup.width, 0, serverCoords.methtempup.minZ, serverCoords.methtempup.maxZ, 'mrf_drugprocess:ChangeTemp', 'fas fa-temperature-empty', 'target.methtempup')
    addTargetBoxZone('methtempdown', serverCoords.methtempdown, serverCoords.methtempdown.length, serverCoords.methtempdown.width, 354, serverCoords.methtempdown.minZ, serverCoords.methtempdown.maxZ, 'mrf_drugprocess:ChangeTemp2', 'fas fa-temperature-full', 'target.methtempdown')
    addTargetBoxZone('methbagging', serverCoords.methbagging, serverCoords.methbagging.length, serverCoords.methbagging.width, 1, serverCoords.methbagging.minZ, serverCoords.methbagging.maxZ, 'mrf_drugprocess:ProcessProduct', 'fas fa-box', 'target.bagging')
    addTargetBoxZone('thychloride', serverCoords.thychloride, serverCoords.thychloride.length, serverCoords.thychloride.width, 340.0, serverCoords.thychloride.minZ, serverCoords.thychloride.maxZ, 'mrf_drugprocess:processingThiChlo', 'fas fa-biohazard', 'target.process_thionyl_chloride')
    addTargetBoxZone('lsdpro', serverCoords.lsdpro, serverCoords.lsdpro.length, serverCoords.lsdpro.width, 200.56, serverCoords.lsdpro.minZ, serverCoords.lsdpro.maxZ, 'mrf_drugprocess:processingLSD', 'fas fa-biohazard', 'target.process_lsdpro')
    addTargetBoxZone('heroinproc', serverCoords.heroinproc, serverCoords.heroinproc.length, serverCoords.heroinproc.width, 352.15, serverCoords.heroinproc.minZ, serverCoords.heroinproc.maxZ, 'mrf_drugprocess:ProcessPoppy', 'fas fa-leaf', 'target.heroinproc')
    addTargetBoxZone('heroinproces', serverCoords.heroinproces, serverCoords.heroinproces.length, serverCoords.heroinproces.width, 175.06, serverCoords.heroinproces.minZ, serverCoords.heroinproces.maxZ, 'mrf_drugprocess:processHeroin', 'fas fa-chess-board', 'target.heroinproces')
    addTargetBoxZone('chemmenu', serverCoords.chemmenu, serverCoords.chemmenu.length, serverCoords.chemmenu.width, 138.28, serverCoords.chemmenu.minZ, serverCoords.chemmenu.maxZ, 'mrf_drugprocess:chemicalmenu', 'fas fa-bars', 'target.chemmenu')
    addTargetBoxZone('seedproces', serverCoords.seedproces, serverCoords.seedproces.length, serverCoords.seedproces.width, 0, serverCoords.seedproces.minZ, serverCoords.seedproces.maxZ, 'mrf_drugprocess:processWeedSeed', 'fas fa-chess-board', 'target.weedseed')
    addTargetBoxZone('weedproces', serverCoords.weedproces, serverCoords.weedproces.length, serverCoords.weedproces.width, 270, serverCoords.weedproces.minZ, serverCoords.weedproces.maxZ, 'mrf_drugprocess:processWeed', 'fas fa-chess-board', 'target.weedproces')
    addTargetBoxZone('cokeleafproc', serverCoords.cokeleafproc, serverCoords.cokeleafproc.length, serverCoords.cokeleafproc.width, 0, serverCoords.cokeleafproc.minZ, serverCoords.cokeleafproc.maxZ, 'mrf_drugprocess:ProcessCocaFarm', 'fas fa-scissors', 'target.cokeleafproc')
    addTargetBoxZone('cokepowdercut', serverCoords.cokepowdercut, serverCoords.cokepowdercut.length, serverCoords.cokepowdercut.width, 90, serverCoords.cokepowdercut.minZ, serverCoords.cokepowdercut.maxZ, 'mrf_drugprocess:ProcessCocaPowder', 'fas fa-weight-scale', 'target.cokepowdercut')
    addTargetBoxZone('cokebricked', serverCoords.cokebricked, serverCoords.cokebricked.length, serverCoords.cokebricked.width, 90, serverCoords.cokebricked.minZ, serverCoords.cokebricked.maxZ, 'mrf_drugprocess:ProcessBricks', 'fas fa-weight-scale', 'target.cokebagging')

    -- Lab Points

    addLabPoint(serverCoords.MethLab.Enterlab.coords, serverCoords.MethLab.Enterlab.teleport, 'point.entermeth')
    addLabPoint(serverCoords.MethLab.LeaveLab.coords, serverCoords.MethLab.LeaveLab.teleport, 'point.exitmeth')
    addLabPoint(serverCoords.WeedLab.Enterlab.coords, serverCoords.WeedLab.Enterlab.teleport, 'point.enterweed')
    addLabPoint(serverCoords.WeedLab.LeaveLab.coords, serverCoords.WeedLab.LeaveLab.teleport, 'point.exitweed')
    addLabPoint(serverCoords.CokeLab.Enterlab.coords, serverCoords.CokeLab.Enterlab.teleport, 'point.entercoke')
    addLabPoint(serverCoords.CokeLab.LeaveLab.coords, serverCoords.CokeLab.LeaveLab.teleport, 'point.exitcoke')

    -- Target Models

    addTargetModel('prop_plant_01b', 'mrf_drugprocess:pickHeroin', 'fas fa-leaf', 'target.pickHeroin')
    addTargetModel('mw_sodium_barrel', 'mrf_drugprocess:pickSodium', 'fas fa-dna', 'target.pickSodium')
    addTargetModel('mw_sulfuric_barrel', 'mrf_drugprocess:pickSulfuric', 'fas fa-shield-virus', 'target.pickSulfuric')
    addTargetModel('mw_chemical_barrel', 'mrf_drugprocess:pickChemicals', 'fas fa-radiation', 'target.pickChemicals')
    addTargetModel('mw_hydro_barrel', 'mrf_drugprocess:client:hydrochloricacid', 'fas fa-radiation', 'target.hydrochloricacid')
    addTargetModel('mw_weed_plant', 'mrf_drugprocess:pickWeed', 'fas fa-leaf', 'target.pickWeed')
    addTargetModel('h4_prop_bush_cocaplant_01', 'mrf_drugprocess:pickCocaLeaves', 'fas fa-leaf', 'target.pickCoke')

    -- Zones

    addZone(serverCoords.Zones.ChemicalFarm.coords, serverCoords.Zones.ChemicalFarm.radius, 'mrf_chemzone', function()
        inChemicalField = true
        SpawnChemicals(serverCoords)
    end, function()
        inChemicalField = false
    end)

    addZone(serverCoords.Zones.HeroinField.coords, serverCoords.Zones.HeroinField.radius, 'mrf_heroinzone', function()
        inHeroinField = true
        SpawnPoppyPlants(serverCoords)
    end, function()
        inHeroinField = false
    end)

    addZone(serverCoords.Zones.HydrochloricAcidFarm.coords, serverCoords.Zones.HydrochloricAcidFarm.radius, 'mrf_hydrochloriczone', function()
        inhydrochloricField = true
        SpawnHydrochloricAcidBarrels(serverCoords)
    end, function()
        inhydrochloricField = false
    end)

    addZone(serverCoords.Zones.SodiumHydroxideFarm.coords, serverCoords.Zones.SodiumHydroxideFarm.radius, 'mrf_sodiumzone', function()
        inSodiumFarm = true
        SpawnSodiumHydroxideBarrels(serverCoords)
    end, function()
        inSodiumFarm = false
    end)

    addZone(serverCoords.Zones.SulfuricAcidFarm.coords, serverCoords.Zones.SulfuricAcidFarm.radius, 'mrf_sulfuriczone', function()
        inSulfuricFarm = true
        SpawnSulfuricAcidBarrels(serverCoords)
    end, function()
        inSulfuricFarm = false
    end)

    addZone(serverCoords.Zones.WeedField.coords, serverCoords.Zones.WeedField.radius, 'mrf_weedzone', function()
        inWeedField = true
        SpawnWeedPlants(serverCoords)
    end, function()
        inWeedField = false
    end)

    addZone(serverCoords.Zones.CokeField.coords, serverCoords.Zones.CokeField.radius, 'mrf_cokezone', function()
        inCokeField = true
        SpawnCocaPlants(serverCoords)
    end, function()
        inCokeField = false
    end)
end)