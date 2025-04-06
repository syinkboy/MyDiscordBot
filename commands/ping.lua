-- ping.lua
local discordia = _G.discordia
local client = _G.client

-- local slashtools = _G.slashtools
-- local slashCommand = slashtools.slashCommand("ping", "Replies with pong!")

return {
  name = "ping",
  description = "Pong!",
  -- slashCommand = slashCommand, -- make it a slashcommand
  aliases = {"pingpong"}, -- this is other names for the ping command, so if you have for example a command called "robloxgroup.lua", if you make an alias called "rg" in your aliases that will work as well.
  callback = function(interaction, args)
    interaction:reply("Pong!")
  end
}