ESX = nil

TriggerEvent(Config.Trigger, function(obj) ESX = obj end)

local version = GetResourceMetadata(GetCurrentResourceName(), 'description')
if version ~= "V1.0" then
    print(([[^1--------------------------------------------------------------------------
^1-- ESX DEVELOPER PORTUGAL (^0https://discord.gg/Qt5WraEMxf^1)
^1-- Precisa de actualizar a sua versão de (^0%s^1)
^1-- ^0Por favor contactar ESX DEVELOPER PORTUGAL para mais informações^1
^1--------------------------------------------------------------------------^0]]):format(GetCurrentResourceName()))
end

AddEventHandler('es:playerLoaded', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local players = ESX.GetPlayers()
    local count = 0

    for i=1, #players do
        local xPlayers = ESX.GetPlayerFromId(players[i])
        if xPlayers.identifier == xPlayer.identifier then
            count = count + 1
        end
    end

    if count >= 2 then
        DropPlayer(_source, 'Apenas pode entrar com uma steam!')
    end
end)

PerformHttpRequest('https://raw.githubusercontent.com/zcmg/'..GetCurrentResourceName()..'/main/fxmanifest.lua', function(code, res, headers)
	local version = GetResourceMetadata(GetCurrentResourceName(), 'description')
	local versao = ''
	local update = ''

	if res ~= nil then
		local t = {}
		for i = 1, #res do
			t[i] = res:sub(i, i)
		end
		versao = t[73]..t[74]..t[75]..t[76]

		if versao == version then
			update = "Ultima Versão"
		else
			update = "^2Precisa de atualizar^1"
		end

	else
		update = "Impossivel verificar a versão"
	end

	

	print(([[^1--------------------------------------------------------------------------
	███████╗ ██████╗███╗   ███╗ ██████╗      ██████╗ ██████╗ ██████╗ ███████╗
	╚══███╔╝██╔════╝████╗ ████║██╔════╝     ██╔════╝██╔═══██╗██╔══██╗██╔════╝
	  ███╔╝ ██║     ██╔████╔██║██║  ███╗    ██║     ██║   ██║██████╔╝█████╗  
	 ███╔╝  ██║     ██║╚██╔╝██║██║   ██║    ██║     ██║   ██║██╔══██╗██╔══╝  
	███████╗╚██████╗██║ ╚═╝ ██║╚██████╔╝    ╚██████╗╚██████╔╝██║  ██║███████╗
	╚══════╝ ╚═════╝╚═╝     ╚═╝ ╚═════╝      ╚═════╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝ 
	-----------------------^0https://www.github.com/zcmg/^1----------------------- 
	
	--------------------------------------------------------------------------
	-- ESX DEVELOPER PORTUGAL (^0https://discord.gg/Qt5WraEMxf^1)
	-- Versão: %s (%s)
	--------------------------------------------------------------------------^0]]):format(versao, update))

end,'GET')
