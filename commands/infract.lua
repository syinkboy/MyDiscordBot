local discordia = _G.discordia

return {
    name = "infract",
    description = "Direct Message",
    callback = function(message, args)
        if message.author.bot then return end

        print("Received args:", args and table.concat(args, ", ") or "nil")

        if not args or type(args) ~= "table" or #args < 3 then
            return message:reply("Usage: !infract @user [reason] [punishment]")
        end

        local user = message.mentionedUsers and message.mentionedUsers.first
        if not user then
            return message:reply("Please mention a valid user.")
        end

        table.remove(args, 1)

        local punishment =  args[1] or "No punishment specified" -- Punishment is the second arguement

        table.remove(args, 1)

        local reason = table.concat(args, " ") -- Everything else is the reason

        print("User:", user.username)
        print("Reason:", reason)
        print("Punishment:", punishment)

        local emb = {
            title = "Infraction Issued",
            fields = {
                { name = "User", value = user.username or "Unknown", inline = true },
                { name = "Reason", value = reason, inline = true },
                { name = "Punishment", value = punishment, inline = false }
            },
            color = 0xFF0000,
            timestamp = discordia.Date():toISO()
        }

        local success, err = message.channel:send({embed = emb}) -- Keep using your brain
        
        if not success then
            print("[ERROR] Failed to send message:", err)
        end
    end
}