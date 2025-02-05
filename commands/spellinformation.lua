local discordia = require('discordia')
local client = discordia.Client()

local compsMenu = {
    type = 1, -- Action row type
    components = {
        {
            type = 3, -- Select menu type
            custom_id = 'Test1',
            placeholder = 'Testing2', -- Corrected typo
            min_values = 1,
            max_values = 1,
            options = {
                {
                    label = 'spellinfo',
                    value = 'Test3',
                },
                {
                    label = 'spellcommand',
                    value = 'Test4',
                },
            },
        },
    },
}

-- Listen for message interactions
client:on('messageCreate', function(message)
    if message.content == '!menu' then
        message:reply({
            content = "Please choose one of the options:",
            components = {compsMenu},
        })
    end
end)

-- Component interaction listener (if supported)
client:on('interactionCreate', function(selectInteraction)
    if selectInteraction.type == discordia.enums.InteractionType.APPLICATION_COMMAND and selectInteraction.data.custom_id == "Test1" then
        local selectedValue = selectInteraction.data.values and selectInteraction.data.values[1] or "None"

        selectInteraction:reply({
            content = "You selected: " .. selectedValue,
            ephemeral = true, -- Visible only to the user
        })
    end
end)

return {
    name = "spellinformation",  -- Set a valid command name
    description = "Select Menu",
    callback = function(interaction, args)
        -- Reply with a message containing the select menu
        interaction:reply({
            content = "Please choose one of the options:",
            components = {compsMenu} -- Use the plain Lua table here
        })
    end
}