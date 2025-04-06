local discordia = _G.discordia

local allowedRoleId = "1331790180121841664"

return {
    name = "infract",
    description = "Direct Message",
    callback = function(message, args)
        if message.author.bot then return end

        local member = message.guild:getMember(message.author.id)
        if not member then
            return message:reply("Could not fetch your member data.")
        end

        local hasRole = false
        for role in member.roles:iter() do
            if role.id == allowedRoleId then
                hasRole = true
                break
            end
        end

        if not hasRole then
            return message:reply("You do not have permission to use this command.")
        end

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
            color = 0xFF4500,
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