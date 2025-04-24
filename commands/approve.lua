local discordia = _G.discordia

local allowedRoleId = '1357707043602956450'

return {
    name = 'approve',
    description = 'Approve a user',
    callback = function(message, args)
        if message.author.bot then return end

        local member = message.guild:getMember(message.author.id)
        if not member then
            return message:reply('I could not fetch your member data.')
        end

        local hasRole = false
        for role in member.roles:iter() do
            if role.id == allowedRoleId then
                hasRole = true
                break
            end
        end

        if not hasRole then
            return message:reply('You do not have the right permissions to use this command.')
        end

        print('Received args:', args and table.concat(args, ',') or 'nil')

        if not args or type(args) ~= 'table' or #args < 2 then
            return message:reply('Usage: b!approve @user [Reason]')
        end

        local user = message.mentionedUsers and message.mentionedUsers:first()
        if not user then
            return message:reply('Please mention a valid user.')
        end

        table.remove(args, 1) -- remove mention
        local reason = table.concat(args, ' ')

        local emb = {
            title = 'Staff Application Results',
            description = 'Hello, ' .. user.username .. '!',
            color = 0x50C878,
            fields = {
                {
                    name = 'Reason',
                    value = reason ~= "" and reason or 'You have passed your application! Please head to ⁠#training-chat for further instructions.',
                    inline = false
                }
            },
            image = {
                url = 'https://cdn.discordapp.com/attachments/1357798123312779365/1359893450983608413/image.png'
            },
            timestamp = discordia.Date():toISO()
        }

        local success, err = message.channel:send {
            content = '<@' .. user.id .. '>',
            embed = emb,
            allowed_mentions = {
                users = { user.id }
            }
        }

        if not success then
            print('[ERROR] Failed to send message:', err)
        end
    end
}
