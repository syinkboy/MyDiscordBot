local discordia = _G.discordia
local client = _G.client
local erlua = _G.erlua

return {
    name = 'kills',
    description = 'View all recent kills.',
    callback = function(message, args)
        local succ, kills = erlua.KillLogs()

        if not succ or not kills or kills.code then
            return message:reply("An error occured trying to get server information: `" .. kills.code .. ":" .. kills.message)
        end

        local tosend = "## Kills [" .. #kills .. "]"

        for _, kill in pairs(kills) do
            if kill and kill.Killed and kill.Killer and kill.Timestamp then
                tosend = tosend .. "\n[<t:" .. kill.Timestamp .. ":T>] `" .. kill.Killed .. "` got killed by `" .. kill.Killer .. "`."
            end
        end

        message:reply(tosend)
    end
}