local discordia = _G.discordia

return {
    name = "promote",
    description = "Direct Message",
    callback = function(message, args)
        if message.author.bot then return end

        print("Received args:", args and table.concat(args, ", ") or "nil")

        if not args or type(args) ~= "table" or #args < 3 then
            return message:reply("Usage: !promote @user [reason] [Rank]")
        end

        local user = message.mentionedUsers and message.mentionedUsers.first
        if not user then
            return message:reply("Please mention a valid user.")
        end

        table.remove(args, 1)

        local punishment = args[1] or "No rank specified"

        table.remove(args, 1)

        local reason = table.concat(args, " ")

        print("User:", user.username)
        print("Reason:", reason)
        print("Rank:", punishment)

        local emb = {
            title = "Promotion Issued",
            fields = {
                { name = "User", value = "<@" .. user.id .. ">", inline = true }, -- Mention user inside embed
                { name = "Reason", value = reason, inline = true },
                { name = "Rank", value = punishment, inline = false }
            },
            color = 0xFF0000,
            timestamp = discordia.Date():toISO()
        }

        local success, err = message.channel:send {
            content = "<@" .. user.id .. ">", -- Ensures the mention actually triggers
            embed = emb,
            allowed_mentions = { users = { user.id } } -- Allows the mention to trigger
        }

        if not success then
            print("[ERROR] Failed to send message:", err)
        end
    end
}
