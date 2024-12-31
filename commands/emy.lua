local discordia = _G.discordia
local client = _G.client 

local comps = discordia.Components()
:button{
    id = 'emy',
    label = 'emy!',
    style = 'danger',
}

return {
    name = 'emy',
    description = 'Idk',
    callback = function(message, args)
        local sent_msg = message:reply({
            embed = {description = 'Press this'},
            components = comps:raw()

        })
        local _, interaction = sent_msg:waitComponent('Button')
        interaction:reply('Hey hey')
    end
}