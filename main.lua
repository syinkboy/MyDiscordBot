-- We start by defining our variables

local discordia = require('discordia') -- discordia
_G.discordia = discordia -- and we make them GLOBAL
require("discordia-components")

local client = discordia.Client { -- the client
  cacheAllMembers = true,
}

client:enableAllIntents()
_G.client = client -- so that all the commands can use them
-- You define a global command with _G.{varname}
-- You can get it anywhere you want with local {varname} = _G.{varname}

local fs = require('fs') -- This module allows us to get information about files, we will use it to get all the files in the commands folder
_G.fs = fs

local function loadCommands() -- This function will create a table of all the commands
  local dir = "./commands" -- this references the commands folder, the dot stands for root folder
  local commands = {}

  local files = fs.readdirSync(dir) -- this function will get the table of commands, but we have to modify it a bit
  for _, file in ipairs(files) do -- We loop through it
    file = file:gsub(".lua", "") -- and remove the .lua from the command name, because require() does not expect this
    commands[file] = true -- then we turn it into a dictonary, you will see how we can use this below
  end
  
  return commands
end

local commands = loadCommands()
_G.commands = commands -- This is also put on a global variable if you ever need it

local function getArgs(inputString) -- Here we have the args function, but I won't go over that right now
  local args = {}

  for word in string.gmatch(inputString, "%S+") do
      table.insert(args, word)
  end

  return args
end

local prefix = "!"

client:on('ready', function()
  print('Logged in as '.. client.user.username)
end)

client:on('messageCreate', function(message) -- Now we go to handling the command and executing it
    if message and message.content and message.guild and message.author and (not message.author.bot) and message.content:sub(1, prefix:len()) == prefix then
      -- This long if statement will ensure that everything we need is there before continueing, otherwise it might break
      -- it checks if the message has content
      -- it checks if it is in a server
      -- it checks if there is an author
      -- it checks if it is not a bot
      -- and lastly it checks the prefix
      -- by checking from the 1 to the lenght of the prefix

      local rawArgs = message.content:gsub(prefix, "") -- This just removes the prefix from the message content

      local args = getArgs(rawArgs) -- Here we split the message by spaces, so if there is a space it gets but separate in this table
      local cmd = args[1] -- The command is the first argument
      table.remove(args, 1) -- We remove it because we have it on a variable already
      
      if commands[cmd] then -- This is where we use the dictonary, it's a special table that makes looking up something very fast.
          local success, module = pcall(require, "./commands/" .. cmd) -- Now we load the command with require(), require allows you to run script in another file
          -- pcall makes sure the bot doesn't crash when something goes wrong
          -- success is true or false, so we can just do if success then
          if success and module and module.callback then -- it also checks if the module exists (the command) and if it has a callback function
              -- Now, if the ping command has an error, we can use pcall here to prevent it from crashing
              local success, err = pcall(function() -- if the pcall fails, the second variable will be the error
                module.callback(message, args)
              end)

              if not success then
                print(cmd .. " encountered an error: " .. err)
              end
          else
              print("Error loading module for command: " .. cmd .. " error: ") -- so we can print module here to get the error
              p(module)
          end -- That is everything, for questions, ping me in chat
      end

    end
end)

client:on("memberJoin", function(member) -- Whenever someone joins any server the bot is in, this event is called
  -- It's just like messageCreate
      local guild = member.guild -- Let's look at the wiki page
      -- Here we can see that the object member includes the guild (the server) that this member stands for
      -- A member object is different from a user object
      -- A user object is the global information about a user
      -- But a member object is for a specific server, so it includes information such as their roles in that server
      if not guild then -- Always make sure all information we need is there, otherwise it might crash your bot
        return print("no guild")
      end
  
      local systemChannel = guild.systemChannel -- The system channel is the channel where built-in discord join messages are send
      -- Let me show you in the server settings
      if not systemChannel then
        return print("no systemchannel")
      end
  
      systemChannel:send("👋 Welcome " .. member.user.mentionString .. " to **" .. guild.name .. "!**") -- And here we send a simple message
      -- We can access the user which has quick access to pinging the user
      -- Let's try adding it to your bot
      -- Screenshare and open visual studio code
  end)

  local token = require("token")
client:run("Bot " .. token)