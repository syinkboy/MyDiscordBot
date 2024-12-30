local discordia = _G.discordia
local client = _G.client

return {
    name = ”test”,
    description = ”Testing args”,
    callback = function(message, args)
    local input = args[1]
    
    message:reply(”Here is your input: ”.. input)
    end
    }