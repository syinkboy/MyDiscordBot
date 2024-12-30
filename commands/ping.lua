local discordia = _G.discordia
local client = _G.client 

local comps = discordia.Components()
:button{
  id = "ping",
  label = "Ping!",
  style = "danger",
}

return {
    name = "ping",
    description = "Replies with Pong!",
    callback = function(message, args)
        local sent_msg = message:reply({
            content = "I dare you to ping me!",
            components = comps:raw()
        })
        local _, interaction = sent_msg:waitComponent("button")
        interaction:reply("Pong!", true)
    end
}



local discordia = _G.discordia
local client = _G.client 

local comps = discordia.Components()
:button{
    id = 'Troptop',
    label = 'Troptop!',
    style = 'danger',
}

return {
    name = ' Troptop',
    description = 'Poptart',
    callback = function(message, args)
        local sent_msg = message:reply({
            content = 'Troptop',
            components = comps:raw()
        })
        local _, interaction = sent_msg:waitComponent('button')
        interaction:reply('This Is troptop Im a poptar eat me!')
    end
}