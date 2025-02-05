local discordia = require('discordia')
local client = discordia.Client()
local timers = require('timer') -- Required for setting timeouts

-- Reminder Command as a module
local remindmeCommand = {
    name = 'remindme',
    description = 'Set a reminder for yourself.',
    callback = function(message, args)
        -- Ensure the user has provided enough arguments
        if not args or #args < 2 then
            message:reply("Invalid format! Use `!remindme <time> <reminder>` (e.g., `!remindme 10m Take a break!`)")
            return
        end

        -- Extract duration and reminder text
        local duration = args[1] -- First argument is the time (e.g., "10m")
        local reminderText = table.concat(args, " ", 2) -- The rest of the arguments are the reminder text

        -- Validate and convert the time duration
        local timeMultiplier = { s = 1, m = 60, h = 3600 }
        local unit = duration:sub(-1) -- Last character: s, m, or h
        local timeValue = tonumber(duration:sub(1, -2)) -- Numeric part of the duration

        -- Check if the duration is valid
        if not timeValue or not timeMultiplier[unit] then
            message:reply("Invalid time format! Use `s` for seconds, `m` for minutes, and `h` for hours.")
            return
        end

        -- Calculate the time in seconds
        local delayInSeconds = timeValue * timeMultiplier[unit]

        -- Confirm the reminder with the user
        message:reply(string.format("Got it! I'll remind you in %d seconds: `%s`", delayInSeconds, reminderText))

        -- Set the reminder using a timer
        timers.setTimeout(delayInSeconds * 1000, function()
            -- Send the reminder back to the user after the delay
            message:reply(string.format("⏰ Reminder: %s", reminderText))
        end)
    end
}

client:on('messageCreate', function(message)
    if message.author.bot then return end

    -- Check if the message starts with "!" and extract the command
    local prefix = "!"
    if message.content:startswith(prefix) then
        local args = message.content:sub(#prefix + 1):split(" ")
        local commandName = table.remove(args, 1)

        -- If the command matches, call the command's callback
        if commandName == remindmeCommand.name then
            remindmeCommand.callback(message, args)
        end
    end
end)