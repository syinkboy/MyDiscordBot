local discordia = _G.discordia
local client = _G.client

--[ Authorized User --]
local authorizedUserID = "995664658038005772"


local invalidPermsEmbed = {
    title = "<:WarningRed:1326148101534253107> **Invalid Permission!**",
    description = "<:RightArrow:1320102028848136294> **Only <@445152230132154380> is allowed to execution this command!**",
    color = 0xFF0000,
}

return {
    name = 'embed2',
    description = 'lola',
    callback = function(message, args)
            local embed = {
                title = "Welcome to " .. message.guild.name .. "!",
                description = 'We have an amazing team working day in and day out on ' .. message.guild.name .. '!',
                color = 0x3498db, 
                footer = {
                    text = 'Footer Test',
                },
                author = {
                    name = message.author.username,
                    url = 'https://example.com'
                },
                fields = {
                    {name = 'Filed 1', value = 'This is the first filed.', inline = true},
                }

            }

            message.channel:send({
                embed = embed 

            })
        end
}