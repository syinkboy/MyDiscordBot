local discordia = require('discordia')
local client = discordia.Client()

-- Your bot token
local token = "MTMyMTQyNzk1NTAwNzg4MTI0Ng.GOan20.LoMUXaeYazHi1v8HFc15XrMAK2HVNkZdliWc6w"

-- A function to execute a command and handle errors
local function executeCommand(message, commandFunc, ...)
    local success, err = pcall(commandFunc, ...)
    if not success then
        -- If there's an error, send it to the Discord channel
        message:reply({
            embed = {
                title = "Error Encountered!",
                description = "An error occurred while executing the command.",
                fields = {
                    { name = "Error", value = tostring(err), inline = false }
                },
                color = 0xff0000 -- Red color for error
            }
        })
        print("Error: " .. err)
    end
end

client:on('messageCreate', function(message)
    -- Example: command prefix is "!"
    if message.content:sub(1, 1) == "!" then
        local command = message.content:sub(2):lower()

        -- Example command handler
        if command == "ping" then
            executeCommand(message, function()
                message:reply("Pong!")
            end)
        elseif command == "errorTest" then
            executeCommand(message, function()
                error("This is a test error!") -- Intentional error
            end)
        else
            message:reply("Unknown command!")
        end
    end
end)

