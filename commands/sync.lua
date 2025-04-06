-- sync.lua

return {
  name = "sync",
  description = "Sync commands",
  aliases = {"pingpong"},
  callback = function(interaction, args)
    if not hasPermissions(interaction.member, "BOT_DEVELOPER") then
        return
    end

    loadCommands()

    return interaction:reply("Reloaded commands.")
  end
}