local discordia = _G.discordia
local client = _G.client

return {
    name = 'spellinfo',
    description = 'Names all the spells and how many lives they take',
    callback = function(message, args)
        local embed = {
            title = 'Spells',
            description = 'Here are all the spells and how many lives they take',
            color = 0x87CEEB,
            fields = {
                {name = 'Spell 1', value = 'This spell takes 1 life', inline = false},
                {name = 'Spell 2', value = 'This spell takes 3 lives', inline = false},
                {name = 'Spell 3', value = 'This spell takes 77 lives', inline = false},
                {name = 'Spell 4', value = 'This spell takes 0 lives and gives you 10 lives', inline = false},

            }
        }
        message.channel:send({
            embed = embed
        })
    end
}