local discordia = _G.discordia
local client = _G.client 

local comps = discordia.Components()
:button{
  id = 'ping',
  label = 'l!ove!',
  style  = 'danger',
}

return {
  name = 'ema',
  description = 'Replies with Hey good looking',
  callback = function(message, args)
    local send_msg = message:reply({
      content = 'Hey bobbi look how pro I am',
      components = comps:raw()
    })
    local _, interaction = send_msg:waitComponent("button")
    interaction:reply('Bling!')
  end
}



