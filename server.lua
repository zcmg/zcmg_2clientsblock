ESX = nil

TriggerEvent(Config.ESXTrigger, function(obj) ESX = obj end)

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
		zcmg_log('**'..GetPlayerName(source)..' ('..source..')** tentou entrar com a mesma conta de steam no servidor', Config.LogWebhook, Config.LogCor)
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

function zcmg_log(msg, canal, cor)
	local corfinal = tonumber(cor:gsub("#",""),16)
	PerformHttpRequest(canal, function(err, text, headers) end, 'POST', json.encode({username = 'ESX Developer Scripts', embeds = {{["color"] = corfinal, ["author"] = {["name"] = 'Esx Developer Portugal', ["icon_url"] = 'https://cdn.discordapp.com/attachments/878328503148355584/880839161924448256/FiveM-Logo2.png'}, ["description"] = msg, ["footer"] = {["text"] = "Esx Developer Portugal - "..os.date("%x %X %p"),["icon_url"] = "https://media.discordapp.net/attachments/878328503148355584/918644161018728528/FiveM-Logo2_tools.png",},}}, avatar_url = 'https://cdn.discordapp.com/attachments/878328503148355584/880839161924448256/FiveM-Logo2.png'}), { ['Content-Type'] = 'application/json' })
end
