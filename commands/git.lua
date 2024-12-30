local discordia = _G.discordia
local client = _G.client 

local comps = discordia.Components()
:button{
  id = "git",
  label = "git!",
  style = "danger",
}

return {
    name = "git",
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