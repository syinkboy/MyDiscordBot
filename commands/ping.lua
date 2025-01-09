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
            content = "Ping ping ping ping",
            components = comps:raw()
        })
        local _, interaction = sent_msg:waitComponent("button")
        interaction:reply("Pong!", true)
    end
}
