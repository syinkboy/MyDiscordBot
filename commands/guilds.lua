local discordia = require('discordia')
local client = discordia.Client()


client:on('ready', function()
    print("Logged in as " .. client.user.username)
end)

client:on('messageCreate', function(message)
    if message.author.bot then return end

    print("Received message: " .. message.content)

    if message.content == prefix .. "guilds" then
        local guilds = client.guilds
        print("Guilds count: " .. #guilds)

        if #guilds == 0 then
            message:reply("This bot is not part of any guilds.")
            return
        end

        local response = "Here are the guilds this bot is in:\n"
        for _, guild in pairs(guilds) do
            response = response .. string.format("• %s (ID: %s)\n", guild.name, guild.id)
        end

        message:reply(response)
    end
end)