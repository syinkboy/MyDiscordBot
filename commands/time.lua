local discordia = _G.discordia
local client = _G.client


local timezones = {
    UTC = 0,
    EST = -5,
    PST = -8,
    CST = -6,
    MST = -7,
    GMT = 0,
    CET = 1,   
    IST = 5.5, 
}

return {
    name = 'time',
    description = 'Replies with the current time in the specified timezone',
    callback = function(message, args)
        local timezone = args[1] 
        if not timezone then
            message:reply("Please specify a timezone! Example: `!time EST`")
            return
        end

        
        timezone = timezone:upper()

        
        local offset = timezones[timezone]
        if not offset then
            message:reply("Invalid timezone! Please use a valid code like `EST`, `PST`, or `UTC`.")
            return
        end

        
        local utcTime = os.time(os.date("!*t")) 

        
        local localTime = utcTime + (offset * 3600) 

        
        local formattedTime = os.date("%I:%M %p", localTime)

        message:reply("The current time in " .. timezone .. " is " .. formattedTime)
    end
}
