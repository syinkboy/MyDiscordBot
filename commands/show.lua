local discordia = _G.discordia
local client = _G.client 

local comps = discordia.Components()
:button{
  id = "show",
  label = "Ping!",
  style = "danger",
}

return {
    name = "show",
    description = "Replies with Pong!",
    callback = function(message, args)
        local sent_msg = message:reply({
            content = "Ping ping ping ping",
            components = comps:raw()
        })
        local _, interaction = sent_msg:waitComponent("button")
        interaction:reply("Pong!", true)
    end
}

