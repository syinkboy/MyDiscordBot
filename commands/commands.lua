local discordia = _G.discordia
local client = _G.client 

local comps = discordia.Components()
:button{
    id = 'commands',
    label = 'commands!',
    style = 'danger',
}


return {
    name = 'commands',
    description = 'Replies with commands!',
    callback = function(message, args)
        local sent_msg = message:reply({
            embed = {description = "Press this and you will see all the commands this bot has to offer"},
            components = comps:raw()
        })
        local _, interaction = sent_msg:waitComponent('button')
        interaction:reply('!embed1, !ema, !ping. more coming soon')
    end
}


local discordia = _G.discordia
local client = _G.client 

local comps = discordia.Components()
:button{
    id = 'botinfo',
    label = 'info!'
    style = 'danger',
}

return {
    name = 'bot',
    description = 'idk',
    callback = function(message, args)
        local sent_msg = message:reply({
            embed = {description = 'This bot Is all about getting better at lua/discordia, both lilkid and bobbiones has helped me but troptop is a nobb'},
            components = comps:raw()
        })
        local _, interaction = sent_msg:waitComponent('buttons')
        interaction:reply('Idk what to put here tbh')
    end
}