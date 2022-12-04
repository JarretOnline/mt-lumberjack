local QBCore = exports['qb-core']:GetCoreObject()

-- Evento para dar os troncos
RegisterServerEvent("mt-lumberjack:server:DarTroncos")
AddEventHandler("mt-lumberjack:server:DarTroncos", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
        Player.Functions.AddItem("tronco", 1)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["tronco"], "add")
end)
    
-- Evento para processar tronco
RegisterServerEvent("mt-lumberjack:server:DarTabuas")
AddEventHandler("mt-lumberjack:server:DarTabuas", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local tronco = Player.Functions.GetItemByName("tronco")
    if tronco ~= nil then

        if tronco.amount >= 1 then
            Player.Functions.RemoveItem("tronco", 1)
            Player.Functions.AddItem("tabuas", 1)
            TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["tabuas"], "add")
        else
            TriggerClientEvent('okokNotify:Alert', src, "LOGGING", "MISSING: TREE TRUNK", 2000, 'error')
        end
    else
        TriggerClientEvent('okokNotify:Alert', src, "LOGGING", "MISSING: TREE TRUNK", 2000, 'error')
    end
end)

-- Evento para Venda items
RegisterNetEvent('mt-lumberjack:server:VenderTabuas', function(args) 
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local args = tonumber(args)
	if args == 1 then 
		local tabuas = Player.Functions.GetItemByName("tabuas")
		if tabuas ~= nil then
			local payment = math.random(3,9) -- trocar aqui o preço que deseja para o próximo item
			Player.Functions.RemoveItem("tabuas", 1, k)
			Player.Functions.AddMoney('bank', payment , "LOGGING")
			TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["tabuas"], "remove", 1)
            TriggerClientEvent('okokNotify:Alert', src, "LOGGING", "1x "..source.." SOLD at $"..payment, 2000, 'success')
			TriggerClientEvent("mt-drugdealer:client:venda", source)
		else
		    TriggerClientEvent('okokNotify:Alert', src, "LOGGING", "MISSING: WOODEN PLANK", 2000, 'error')
        end 
    end
end)
