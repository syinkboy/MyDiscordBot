
local discordia = _G.discordia
local client = _G.client 

local comps = discordia.Components()
:button{
    id = 'Bobbi you suck',
    label = 'Bobbi!',
    style = 'danger',
}

return {
    name = 'bobbi',
    description = 'Replies with commands!',
    callback = function(message, args)
        local sent_msg = message:reply({
            embed = {description = 'Press this and bobbi will kill you'},
            components = comps:raw()
        })
        local _, interaction = sent_msg:waitComponent('button')
        interaction:reply('BANNED')
    end

}

