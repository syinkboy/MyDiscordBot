local discordia = _G.discordia
local client = _G.client 

return {
    name = 'spellcommand',
    description = 'Tells what the spell command does and how many lives you got',
    callback = function(message, args)
        local sent_msg = message:reply({
            content = 'The spell command is a command that allows you to cast random spells that the bot choses, the you can find out what each spell does by typing !spellinfo and see how many lives you got by typing !lives',

        })
    end
}