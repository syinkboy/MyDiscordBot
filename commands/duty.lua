local discordia = _G.discordia
local client = _G.client

local comps = discordia.Components()
    :button{
        id = 'duty',  -- Keep the ID consistent
        label = 'Start your duty',  -- Fixed spelling error
        style = 'success',
    }

return {
    name = 'duty',
    description = 'Turn shift on or off',  -- Fixed spelling error
    callback = function(message, args)
        local sent_msg = message:reply{
            content = 'Press the Duty button to go on duty',
            components = comps:raw()
        }

        local _, interaction = sent_msg:waitComponent('duty')  -- Use the same ID as defined earlier

        if interaction then
            interaction:reply('You are now on duty!')
        else
            message:reply('No response received.')
        end
    end
}
