local discordia = _G.discordia

return {
    name = "promote",
    description = "Direct Message",
    callback = function(message, args)
        if message.author.bot then return end

        if not args or type(args) ~= "table" or #args < 3 then
            return message:reply("Usage: !promote @user [reason] [Rank]")
        end

        -- Get first mentioned user
        local user = message.mentionedUsers:iter()()
        if not user then
            return message:reply("Please mention a valid user.")
        end

        -- Remove the mention from args
        table.remove(args, 1)

        local rank = args[#args]
        table.remove(args, #args)

        local reason = table.concat(args, " ")

        local emb = {
            title = "Promotion Issued",
            fields = {
                { name = "User", value = "<@" .. user.id .. ">", inline = true },
                { name = "Reason", value = reason or "No reason provided", inline = true },
                { name = "Rank", value = rank or "No rank specified", inline = false }
            },
            color = 0xFF0000,
            timestamp = discordia.Date():toISO()
        }

        local success, err = message.channel:send {
            content = "<@" .. user.id .. ">",
            embed = emb,
            allowed_mentions = { users = { user.id } }
        }

        if not success then
            print("[ERROR] Failed to send message:", err)
        end
    end
}
