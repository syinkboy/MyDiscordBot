local discordia = _G.discordia
local client = _G.client 

return {
    name = 'about',
    description = 'About!',
    callback = function(message, args)
        local send_msg = message:reply({
            content = 'Hello, this bot is all about me learning discordia, if you try to do something with the bot and it does not answer on some commands you may not have the right perms for that command. Everyone will have perms to the ping command but some commands may be restricted to certain users. If you have any questions or concerns please feel free to reach out to me on discord.'
        })
    end
}
