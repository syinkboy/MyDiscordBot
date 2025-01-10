local discordia = require('discordia')
local client = discordia.Client()

client:on('messageCreate', function(message)
  if message.author.bot then return end
  if not message.guild then return end

  if message.content:sub(1, 4) == '!ban' then
    local author = message.guild:getMember(message.author.id)
    local mentionedUser = message.mentionedUsers.first
    local member = mentionedUser and message.guild:getMember(mentionedUser.id)

    if not member then
      message:reply("Please mention someone to ban!")
      return
    elseif not author:hasPermission(message.channel, "banMembers") then
      message:reply("You do not have the `banMembers` permissions!")
      return
    end

    for user in message.mentionedUsers:iter() do
      if message.content:find("<@!?" .. user.id .. ">") then
        local memberToBan = message.guild:getMember(user.id)
        if memberToBan and author.highestRole.position > memberToBan.highestRole.position then
          local success, err = pcall(function()
            memberToBan:ban()
          end)

          if success then
            message:reply(user.username .. " has been banned!")
          else
            message:reply("Failed to ban " .. user.username .. ": " .. tostring(err))
          end
        else
          message:reply("You cannot ban this member!")
        end
      end
    end
  end
end)