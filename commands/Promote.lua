
local discorida = _G.discordia 

return {
    name = 'Promote',
    description = 'Promote a user',
    callback = function(message, args)
        if message.author.bot then return end

        print('Received args:', args and table.concat(args, ',') or 'nil')

        if not args or type(args)  ~= 'table' or #args < 2 then
            return message:reply('Usage: b!promote @user [Reason] [Rank]')
        end

        loca user = message.mentionedUsers and message.mentionedUsers.first 
        if not user then 
            return message:reply('Please mention a valid user.')
        end

        table.remove(args, 1)

        local rank = args[1] or 'No rank specified'
        table.remove(args, 1)

        local reason = table.concat(args, '')

        print('User:', user.mentionedUsers)
        print('Reason:', Reason)
        print('Rank:', rank)

        local emb = {
            title = '**Staff Promotion**',
            description = 'The high-ranking team has decided to grant you a promotion! Congratulations!',
            fields = {
                {name = 'Staff Member:', value = message.author.mentionedUsers, inline = false},
                {name = 'New Rank:', value = rank, inline = false},
                {name = 'Reason:', value = reason, inline = false},
            }
            color = 0xFF4500,
            timestamp = discordia.Date():toISO()
        }

        local success, err = message.channel:send {
            content = '<@' .. user.id .. '>',
            embed = emb,
            allowed_mentions = { users = { user.id}}
        }

        if not success then
            print('[ERROR] Failed to send message:', err)
        end


}