local discordia = _G.discordia

local authorized = { "995664658038005772", "939213968143183962" }

local function has_perms(id)
    for _, v in ipairs(authorized) do
        if tostring(v) == tostring(id) then
            return true
        end
    end
    return false
end

return {
    name = "Promote",
    description = "Promote a user",
    callback = function(message, args)
        if message.author.bot then return end
        if not has_perms(message.author.id) then
            return message:reply("You do not have permission to use this command.")
        end

        print("Received args:", args and table.concat(args, ", ") or "nil")

        if not args or type(args) ~= "table" or #args < 3 then
            return message:reply("Usage: !promote @user [role] [reason]")
        end

        local user = message.mentionedUsers and message.mentionedUsers.first
        if not user then
            return message:reply("Please mention a valid user.")
        end

        table.remove(args, 1) -- Remove user mention from args
        local role = args[1] or "No role specified"
        table.remove(args, 1) -- Remove role from args
        local reason = table.concat(args, " ") -- Everything else is the reason

        print("User:", user.username)
        print("Role:", role)
        print("Reason:", reason)

        local emb = {
            title = "Promotion Issued",
            fields = {
                { name = "User", value = user.mentionString, inline = true },
                { name = "Role", value = role, inline = true },
                { name = "Reason", value = reason, inline = false }
            },
            color = 0x00FF00, -- Green color for success
            timestamp = discordia.Date():toISO() or discordia.Date():toString()
        }

        local sentMessage, err = message.channel:send {
            content = user.mentionString, -- Pings the user
            embed = emb
        }

        if err then
            print("[ERROR] Failed to send message:", err)
        else
            print("[SUCCESS] Promotion message sent.")
        end
    end
}