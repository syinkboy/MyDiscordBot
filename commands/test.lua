local discordia = _G.discordia
local client = _G.client'

local comps = discordia.Components()
:button{
  id = "Test",
  label = "Button!",
  style = "success",
}

     return {
        name = 'Test',
        description = 'Testing the buttons',
        callback = function(message, args)
            local sent_msg = message:reply({
                content = 'DO NOT PRESS',
                components = comps:raw()
            })
            local _, interaction = sent_msg:waitComponent('Buton')
            interaction:reply('You just pressed the button of death, good job!')
        end
    }