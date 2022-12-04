local QBCore = exports['qb-core']:GetCoreObject()

-- Evento para cortar os troncos das arvores
RegisterNetEvent('mt-lumberjack:client:CortarTroncos')
AddEventHandler("mt-lumberjack:client:CortarTroncos", function()
        local playerPed = PlayerPedId()
        exports['ps-ui']:Circle(function(success)
            if success then
                ExecuteCommand( "e mechanic4" ) 
                Wait(math.random(4000,9000))
                TriggerServerEvent("mt-lumberjack:server:DarTroncos")
                ExecuteCommand( "e c" ) 
                exports["mz-skills"]:UpdateSkill("LOGGING", 1) ---skills add xp
                exports['okokNotify']:Alert("SKILLS", "[XP] +1 ", 2000, 'success')

                        -----ADDING SKILL REWARDS
                        exports["mz-skills"]:CheckSkill("LOGGING", 25, function(hasskill)
							if hasskill then
								exports['okokNotify']:Alert("SKILLS", "EXTRA LOOT!", 2000, 'success')
								TriggerServerEvent('mt-weed:server:Apanhar')
							else
							end
							end)
	
							exports["mz-skills"]:CheckSkill("LOGGING", 50, function(hasskill)
							if hasskill then
								exports['okokNotify']:Alert("SKILLS", "EXTRA LOOT!", 2000, 'success')
								TriggerServerEvent('mt-weed:server:Apanhar')
							else
							end
							end)
	
							exports["mz-skills"]:CheckSkill("LOGGING", 100, function(hasskill)
							if hasskill then
								exports['okokNotify']:Alert("SKILLS", "EXTRA LOOT!", 2000, 'success')
								TriggerServerEvent('mt-weed:server:Apanhar')
							else
							end
							end)
	
							exports["mz-skills"]:CheckSkill("LOGGING", 200, function(hasskill)
							if hasskill then
								exports['okokNotify']:Alert("SKILLS", "EXTRA LOOT!", 2000, 'success')
								TriggerServerEvent('mt-weed:server:Apanhar')
							else
							end
							end)
	
							exports["mz-skills"]:CheckSkill("LOGGING", 400, function(hasskill)
							if hasskill then
								exports['okokNotify']:Alert("SKILLS", "EXTRA LOOT!", 2000, 'success')
								TriggerServerEvent('mt-weed:server:Apanhar')
							else
							end
							end)
	
							exports["mz-skills"]:CheckSkill("LOGGING", 600, function(hasskill)
							if hasskill then
								exports['okokNotify']:Alert("SKILLS", "EXTRA LOOT!", 2000, 'success')
								TriggerServerEvent('mt-weed:server:Apanhar')
							else
							end
							end)
	
							exports["mz-skills"]:CheckSkill("LOGGING", 800, function(hasskill)
							if hasskill then
								exports['okokNotify']:Alert("SKILLS", "EXTRA LOOT!", 2000, 'success')
								TriggerServerEvent('mt-weed:server:Apanhar')
							else
							end
							end)
	
							exports["mz-skills"]:CheckSkill("LOGGING", 1000, function(hasskill)
							if hasskill then
								exports['okokNotify']:Alert("SKILLS", "EXTRA LOOT!", 2000, 'success')
								TriggerServerEvent('mt-weed:server:Apanhar')
							else
							end
							end)
							-----ENDING SKILL REWARDS
            else
                exports["mz-skills"]:UpdateSkill("LOGGING", -2) ---skills remove xp
                exports['okokNotify']:Alert("SKILLS", "[XP] -2 ", 2000, 'error')
            end
        end, math.random(4,8), math.random(8,12)) -- NumberOfCircles, MS
end)

-- Target para cortar os troncos
Citizen.CreateThread(function ()
    exports['qb-target']:AddBoxZone("troncos", vector3(-540.75, 5382.32, 71.43), 4, 4, {
        name = "troncos",
        heading = 0,
        debugPoly = false,
    }, {
        options = {
            {
                type = "Client",
                event = "mt-lumberjack:client:CortarTroncos",
                icon = "fas fa-axe",
                label = " CHOP TREE ",
            },
        },
        distance = 4.0
    })
end)

-- Target para processar tabuas
Citizen.CreateThread(function ()
    exports['qb-target']:AddBoxZone("tabuas", vector3(-551.69, 5330.04, 74.97), 4, 4, {
        name = "tabuas",
        heading = 0,
        debugPoly = false,
    }, {
        options = {
            {
                type = "Client",
                event = "mt-lumberjack:client:ProcessarTabuas",
                icon = "fas fa-axe",
                label = " CHOP WOOD",
            },
        },
        distance = 4.0
    })
end)

-- Evento para processar madeira
RegisterNetEvent('mt-lumberjack:client:ProcessarTabuas')
AddEventHandler("mt-lumberjack:client:ProcessarTabuas", function()
    ExecuteCommand( "e mechanic4" ) 
    Wait(math.random(4000,9000))
    TriggerServerEvent("mt-lumberjack:server:DarTroncos")
    ExecuteCommand( "e c" ) 
end)

-- spawn ped vendas
local vendasPed = {
	{-483.82, 5277.45, 85.86,"Zé Das Coves",68.34,0x039677BD,"cs_jimmyboston"}, -- trocar aqui o ped e a sua loc
  }
  Citizen.CreateThread(function()
	  for _,v in pairs(vendasPed) do
		  RequestModel(GetHashKey(v[7]))
		  while not HasModelLoaded(GetHashKey(v[7])) do
			  Wait(1)
		  end
		  VendaProcPed =  CreatePed(4, v[6],v[1],v[2],v[3], 3374176, false, true)
		  SetEntityHeading(VendaProcPed, v[5])
		  FreezeEntityPosition(VendaProcPed, true)
		  SetEntityInvincible(VendaProcPed, true)
		  SetBlockingOfNonTemporaryEvents(VendaProcPed, true)
		  TaskStartScenarioInPlace(VendaProcPed, "WORLD_HUMAN_AA_SMOKE", 0, true) 
	  end
  end)

-- Target para venda das tabuas
Citizen.CreateThread(function ()
    exports['qb-target']:AddBoxZone("VendaTabuas", vector3(-483.82, 5277.45, 86.86), 1, 1, {
        name = "VendaTabuas",
        heading = 0,
        debugPoly = false,
    }, {
        options = {
            {
                type = "Client",
                event = "mt-lumberjack:client:VenderTabuas",
                icon = "fas fa-axe",
                label = " SELL WOOD",
            },
        },
        distance = 4.0
    })
end)

-- Menu de vendas
RegisterNetEvent('mt-lumberjack:client:VenderTabuas')
AddEventHandler('mt-lumberjack:client:VenderTabuas', function()
    exports['qb-menu']:openMenu({
		{
            header = "Board Employee",
            isMenuHeader = true
        },
        { -- copiar daqui
            header = "BOARDS",
            txt = "Price: $2",
            params = {
				isServer = true,
                event = "mt-lumberjack:server:VenderTabuas",
				args = 1 -- mudar aqui os args
            }
        },		-- até aqui, colar logo aqui em baixo		
        {
            header = "EXIT",
            txt = "",
            params = {
                event = "qb-menu:closeMenu"
            }
        },
    })
end)
