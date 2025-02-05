local discordia = require('discordia')
local client = discordia.Client()

return {
    name = 'ping',
    description = 'ping!',
    callback = function(message, args)
        message:reply('Png!')
    end
}