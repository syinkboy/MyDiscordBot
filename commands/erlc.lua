local discordia = _G.discordia
local client = _G.client
local erlua = _G.erlua

return {
    name = 'erlc',
    description = 'Information about your erlc server.',
    callback = function(message, args)
        local succ, erlcserver = erlua.Server()

        if not succ or not erlcserver or erlcserver.code then
            return message:reply("An error occured trying to get server information: `" .. erlcserver.code .. ":" .. erlcserver.message)
        end

        message:reply("## " .. erlcserver.name .. "\n> - **Code:** " .. erlcserver.JoinKey .. "\n> **Players In-Game:** " .. erlcserver.CurrentPlayers .. "**/**" .. erlcserver.MaxPlayers)
    end

}