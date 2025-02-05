local discordia = _G.discordia
local client = _G.client

return {
    name = 'say',
    description = 'Repeats what the user says',
    callback = function(message, args)
        if #args == 0 then
            message:reply("You need to specify something for me to say! Example: `!say Hello World!`")
            return
        end

       
        local sayText = table.concat(args, " ")

        
        message:reply(sayText)
    end
}
