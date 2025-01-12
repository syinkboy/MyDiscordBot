local discordia = _G.discordia
local client = _G.client 

local comps = discordia.Components()
:button{
    id = 'show',
    label = 'Pressy',
    style = 'danger',
}

return {
    name = 'show',
    description = 'Just a show',
    callback = function(message, args)
        local sent_msg = message:reply{(
            content = 'Just showing you that I can make buttons too',
            components = comps:raw() 
        )}
        local _, interaction = sent_msg:waitComponent('Button')
        interaction:reply('Here it is')
    end
}