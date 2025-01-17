local discordia = _G.discordia
local client = _G.client 

local comps = discordia.Components()
:button{
    id = 'Test',
    label = 'Ping!',
    style = 'danger',
}

return {
    name = 'Test',
    description = 'Replies with pong',
    callback = function(message, args)
        local sent_msg = message:reply({
            content = 'Hell nah',
            components = comps:raw()

        })
        local _, interaction = sent_msg:waitComponent('Button')
        interaction:reply('Ping!')
    end

        
}
