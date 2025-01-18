local discordia = _G.discordia
local client = _G.client

local requiredRoleId = "1319390709815578647 " -- Replace with your role ID


return {
    name = 'Rules',
    description = 'The rules.',
    callback = function(message, args)
        local embed = {
            title = 'Rules',
            description = 'Test test',
            color = 0x3498db,
            footer = {
                text = 'Test',
            },
            fields = {
                {name = 'test', value = 'test 1', inline = true},
                {name = 'Test2', value = 'Test2', inline = true}
            }
        }
        message.channel:send({
            embed = embed
        })
    end
      
}