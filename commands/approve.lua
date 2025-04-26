local discordia = _G.discordia

local allowedRoleId = '1357707043602956450' -- <<< your allowed role ID here

return {
    name = "approve",
    description = "Approve a staff application and send a nice embed.",
    run = function(self, message, args)
        if message.author.bot then return end

        -- Fetch the member from the guild
        local member = message.guild:getMember(message.author.id)
        if not member then
            return message:reply('❌ I could not fetch your member data.')
        end

        -- Check if member has the allowed role
        local hasRole = false
        for role in member.roles:iter() do
            if role.id == allowedRoleId then
                hasRole = true
                break
            end
        end

        if not hasRole then
            return message:reply('🚫 You do not have the right permissions to use this command.')
        end

        -- Check if a user is mentioned
        local mentionedUser = message.mentionedUsers[1]  -- Fixed line: accessing the first mentioned user
        if not mentionedUser then
            return message:reply("❌ You need to mention the user you are approving!\nExample: `b!approve @user Good application`")
        end

        -- Remove the mention from args to get the reason
        table.remove(args, 1)
        local reason = table.concat(args, " ")

        if reason == "" then
            message:reply("❌ You need to provide a reason!\nExample: `b!approve @user Good application`")
            return
        end

        -- Build the embed
        local embed = {
            title = "Staff Application Results",
            description = string.format("Hello, <@%s>\n\nWe are pleased to inform you that you have passed your application. Head to <#1331484304584347699> for further instructions. :)", mentionedUser.id),
            fields = {
                {
                    name = "Reason:",
                    value = reason
                }
            },
            image = {
                url = "https://pixabay.com/photos/automobile-defect-broken-car-wreck-62827/" -- <<< your image link
            },
            footer = {
                text = string.format("Reviewed by %s • %s", message.author.username, os.date("%m/%d/%Y %I:%M %p"))
            },
            color = 0x00ff00 -- Green
        }

        -- Send the embed safely
        local success, err = pcall(function()
            message.channel:send {
                embed = embed
            }
        end)

        if success then
            print("[Approve] ✅ Sent approval embed for " .. mentionedUser.username)
        else
            print("[Approve] ❌ Failed to send approval embed:", err)
            message:reply("❌ Failed to send approval embed:\n```" .. tostring(err) .. "```")
        end
    end
}
