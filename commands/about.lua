local discordia = _G.discordia
local client = _G.client 


local comps = discordia.Components()
:button{
    id = 'about',
    label = 'about!',
    style = 'danger',
}

return {
    name = 'about',
    description = 'Hello, this is bot is a work in progress.',
    callback = function(message, args)
        local send_msg = message:reply({
            content = 'Hello, this is bot is a work in progress.',
            components = comps:raw()
        })
        local _, interaction = send_msg:waitComponent("button")
    interaction:reply('Bling!')
    end
}