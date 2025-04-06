local discordia = _G.discordia

local allowedRoleId = '1331790180121841664'

return {
    name = 'approve',
    description = 'Apprrove a user',
    callback = function(message, args)
        if message.author.bot then return end

        local member = message.guild:getMember(message.author.id)
        if not member then
            return message:reply('I could not fetch your member data.')
        end

        local hasROle = falsefor role in member.roles:iter() do
            if role.id == allowedRoleID then
                hasRole = true
                break
            end

            if not hasROle then
                return message:reply('You do not have permission to use this command.')
                end

                print('Recieved args:', args and table.concat(args, ',') or 'nil')

                if not args or type(args) ~= 'table' or #args < 3 then
                    return message:reply('Usage: b!approve @user [Reason]')
                end

                local user = message.mentionedUsers and message.mentionedUser.first
                if not user then
                    return message:reply('Please mention a valid user.')
                end 

                table.remove(args, 1)

                local reason = table.concat(args, '')

                print('User:', user.username)
                print('Reason:', reason)

                local emb = {
                    title = 'Staff Application Results',
                    description = 'Hello,' .. user.username .. '!',
                    field = {
                        {name = 'Result', value = 'We are pleased to inform you that you have passed your application. Head to ⁠training-chat for further instructions.', inline = false},
'}
                    },
                    color = 0x50C878,
                    timestamp = discordia.Date():toISO()

                }

                local success, err = message.channel:send {
                    content = '<@' .. user.id .. '>',
                    embed = emb,
                    allowed_mentions = { allowedRoleID = { Role.id }}
                }

                if not success then
                    print('[ERROR] failed to send message:', err)
                end
            end
}