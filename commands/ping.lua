local discordia = require('discordia')
local client = _G.client
require("discordia-components")

local client = discordia.Client()

local ping_button = discordia.Button {
  id = "ping",
  label = "Ping!",
  style = "danger",
}

client:on("messageCreate", function(message)
  if message.content:lower() == "!pingpong" then
    local sent_msg = message:replyComponents("I dare you to ping me!", ping_button)
    local _, interaction = sent_msg:waitComponent("button")
    interaction:reply("Pong!")
  end
end)