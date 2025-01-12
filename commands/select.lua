local discordia = _G.discordia
local client = _G.client
require("discordia-components") -- Required for component handling

local selectMenu = {
    type = 3, -- Type 3 is a select menu
    custom_id = "example_select_menu",
    placeholder = "Choose an option...", -- Placeholder text
    options = { -- Define the options
        {
            label = "Option 1",
            value = "option1",
            description = "This is the first option",
            emoji = {name = ":exclamation:"}
        },
        {
            label = "Option 2",
            value = "option2",
            description = "This is the second option",
            emoji = {name = ":question:"}
        },
        {
            label = "Option 3",
            value = "option3",
            description = "This is the third option",
            emoji = {name = ":balloon:"}
        }
    }
}

return {
    name = "select",
    description = "Select Menu",
    callback = function(interaction, args)
        -- Reply with a message containing the select menu
        interaction:reply({
            content = "Choose an option from the menu below:",
            components = {
                {
                    type = 1, -- Action row
                    components = {selectMenu}
                }
            }
        })

        -- Listen for interactions with the select menu
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
    end
}