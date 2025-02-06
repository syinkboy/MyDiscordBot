local discordia = _G.discordia
local client = _G.client

local authorized = {"995664658038005772", "939213968143183962"}

local function has_perms(id)
    for _, v in ipairs(authorized) do
        if v == id then
            return true
        end
    end
    return false
end

return {
    name = "DM",
    description = "Direct Message a user",
    callback = function(message, args)
        if not has_perms(message.author.id) then
            return
        end

        if args and args[1] and args[2] then
            local user_id = args[1]
            table.remove(args, 1)
            
            local msg_content = table.concat(args, " ")
            
            print("Extracted User ID:", user_id)
            print("Message to Send:", msg_content)

            if user_id and msg_content then
                local user = client:getUser(user_id)
                print("User Object:", user)

                if user then
                    user:send(msg_content)
                    message.channel:send("✅ Successfully sent a DM to <@" .. user_id .. ">")
                    print("✅ Message Sent!")
                else
                    message.channel:send("❌ User not found. Make sure the ID is correct.")
                    print("❌ User not found.")
                end
            else
                message.channel:send("❌ Invalid format. Use: `!DM [UserID] (message)`")
                print("❌ Invalid format.")
            end
        else
            message.channel:send("❌ Invalid format. Use: `!DM [UserID] (message)`")
            print("❌ Invalid format.")
        end
    end
}
