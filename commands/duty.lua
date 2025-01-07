local discordia = _G.discordia
local client = _G.client 

local comps = discord.Components()
:button{
    id = 'duty',
    label = 'Start youre duty',
    style = 'success'
}

return {
    name = 'duty',
    description = 'Trun shift on or off',
    callback = function(message, args)
        local sent_msg = message:reply{(
            embed = {description = 'Press the Duty button to go on duty'},
            components = comps:raw
        )}
        local _, interaction = sent_msg:waitComponent('Duty')
        interaction:reply('You are now on duty')
    end
}