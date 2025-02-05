local discordia = _G.discordia
local client = _G.client

-- Define the select menu using a plain Lua table
local compsMenu = {
    type = 1, -- Action Row
    components = {
        {
            type = 3, -- Select Menu
            custom_id = "example_select_menu",
            placeholder = "testingsigma...",
            min_values = 1,
            max_values = 1,
            options = {
                {
                    label = "Option 1",
                    value = "option_1",
                    emoji = { id = "1327300914700091393", name = "Discord" }
                },
                {
                    label = "Option 2",
                    value = "option_2",
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

-- Return the command
return {
    name = "select",
    description = "Select Menu",
    callback = function(interaction, args)
        -- Reply with a message containing the select menu
        interaction:reply({
            content = "Please chose one of the options:",
            components = {compsMenu} -- Use the plain Lua table here
        })
    end
}

