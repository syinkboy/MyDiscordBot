local discordia = require('discordia')
local client = _G.client

return {
    name = 'userinfo',
    description = 'Shows information about the user',
    callback = function(message, args)
        local user = message.author

        local embed = {
            title = "User Info",
            color = 0x00ffcc,
            fields = {
                { name = "Username", value = user.username, inline = true },
                
                { name = "User ID", value = user.id, inline = false },
                
            },
            thumbnail = { url = user.avatarURL },
            footer = { text = "Requested by " .. message.author.tag },
            timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
        }

        message.channel:send({embed = embed})
    end
}
