local discordia = require('discordia')
_G.discordia = discordia 
require("discordia-components")
-- local dslash = require("discordia-slash")
-- local slashtools = dslash.util.tools()
-- _G.slashtools = slashtools

local client = discordia.Client {
  cacheAllMembers = true,
}

local timer = require("timer")
_G.timer = timer

client:enableAllIntents()
_G.client = client 

local erlua = require("erlua")
erlua:SetServerKey("sbGKCSkqRP-SBfPJXodUXYhyVyJVCHUxlpWcvhIEfjHbYLAZouQ")
_G.erlua = erlua

local fs = require('fs')
_G.fs = fs

local function loadCommands()
  local dir = "./commands"
  local commands = {}

  local files = fs.readdirSync(dir)
  for _, file in ipairs(files) do
    file = file:gsub(".lua", "")
    commands[file] = true
  end
  
  _G.commands = commands
end

_G.loadCommands = loadCommands

loadCommands()

------------------------------------------------------------------------------------------------------------------------

local assets = require("assets")
_G.emojis = assets.emojis
_G.banners = assets.banners
_G.colors = assets.colors
_G.images = assets.images

------------------------------------------------------------------------------------------------------------------------

local permsTable = {
  ["BOT_DEVELOPER"] = function(member)
    return member.id == "995664658038005772" or member.id == "782235114858872854"
  end
}

local function hasPermissions(member, permType)
  return permsTable[permType](member)
end

_G.hasPermissions = hasPermissions

------------------------------------------------------------------------------------------------------------------------

local function getArgs(inputString)
  local args = {}

  for word in string.gmatch(inputString, "%S+") do
      table.insert(args, word)
  end

  return args
end

local prefix = "b!"

client:on('ready', function()
  print('Logged in as '.. client.user.username)
end)

client:on('messageCreate', function(message)
    if message and message.content and message.guild and message.author and (not message.author.bot) and message.content:sub(1, prefix:len()) == prefix then
      local rawArgs = message.content:gsub(prefix, "")

      local args = getArgs(rawArgs)
      local cmd = args[1]
      table.remove(args, 1)
      
      if commands[cmd] then
          local success, module = pcall(require, "./commands/" .. cmd)
          if success and module and module.callback then
              local success, err = pcall(function()
                module.callback(message, args)
              end)

              if not success then
                print(cmd .. " encountered an error: " .. err)
              end
          else
              print("Error loading module for command: " .. cmd .. " error: ")
              print(module)
          end
      end

    end
end)

client:on("memberJoin", function(member)
      local guild = member.guild
      if not guild then
        return print("no guild")
      end

      local welcomeChannel = guild:getChannel("1331484303531442262")

      welcomeChannel:send("👋 Welcome " .. member.user.mentionString .. " to **" .. guild.name .. "!**")
  end)

local token = require("token")
client:run("Bot " .. token)