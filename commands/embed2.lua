local discordia = _G.discordia
local client = _G.client


return {
    name = 'embed2',
    description = function = 'lola',
        callback = function(message, args)
            local embed = {
                title = "Welcome to " .. message.guild.name .. "!",
                description = 'We got an amazing team for our amazing server here, we are proud to have you all here.',
                color = 0x3498db, 
                footer = {
                    text = 'Footer Test',
                },
                author = {
                    name = 'Author name',
                    url = 'https://example.com'
                },
                fields = {
                    {name = 'Filed 1', value = 'This is the first filed.', inline = true},
                }

            }

            message.channel:send({

            })
        end
}