local discordia = _G.discordia
local client = _G.client 


return {
    name = 'Tast',
    description = 'Test',
    callback = function(message, args)
        local sent_msg = message:reply({
            content = 'Hey this worked and Im super happy for it',
        })
    end
}