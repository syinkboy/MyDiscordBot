local discordia = _G.discordia
local client = _G.client

local compsMenu = {
    type = 1, 
    components = {
        {
            type = 3,
            custom_id = 'xample_select_menu',
            placeholder = 'testingsagma...',
            min_values = 1,
            max_values = 1, 
            options = {
                {
                    label = 'Opetion sigma',
                    value = 'option_1',
                    emoji = { id = "1320083954275057805", name = "KSRP" }
                }
            }
        }
    }
}

-- Event listener for interactionCreate
client:on("interactionCreate", function(selectInteraction)
    if selectInteraction.type == 3 and selectInteraction.data.custom_id == "example_select_menu" then
        -- Get the selected value
        local selectedValue = selectInteraction.data.values[1]

        -- Reply to the user with their selection
        selectInteraction:reply({
            content = "You selected: " .. selectedValue,
            ephemeral = true -- Reply is only visible to the user
        })
    end
end)

return {
    name = 'store',
    description = 'Store Menu',
    callback = function(interaction, args)
        interaction:reply({
            content = 'Please chose one of the options',
            components = {compsMenu}

        })
    end
}
