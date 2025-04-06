local discordia = _G.discordia

local allowedRoleId = "1331790180121841664"


return {
    name = "approve",
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

        if not args or type(args) ~= "table" or #args < 2 then
            return message:reply("Usage: !approve @user [reason] ")
        end

        local user = message.mentionedUsers and message.mentionedUsers.first
        if not user then
            return message:reply("Please mention a valid user.")
        end

        -- Remove the mention from args
        table.remove(args, 1)

        -- Extract rank (last word), and then reason (everything else)
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
