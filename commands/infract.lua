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

        local punishment = args[1] or "No punishment specified"

        table.remove(args, 1)

        local reason = table.concat(args, " ")

        print("User:", user.username)
        print("Reason:", reason)
        print("Punishment:", punishment)

        local emb = {
            title = "The Los Angeles High Ranking Team has decided to take action against you!",
            description = "**Please revise our rules and don't do this again.**",
            fields = {
                { name = "Punishment", value = punishment, inline = false },
                { name = "Reason", value = reason, inline = false }
            },
            color = 0xFF4500, -- Adjusted color to match the image style
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
