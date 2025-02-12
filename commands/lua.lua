local discordia = _G.discordia
local emojis = _G.emojis
local colors = _G.colors

local function prettyLine(...)
    local ret = {}
    for i = 1, select('#', ...) do
        local arg = tostring(select(i, ...))
        table.insert(ret, arg)
    end
    return table.concat(ret, '\t')
end

local function printLine(...)
    local ret = {}
    for i = 1, select('#', ...) do
        local arg = tostring(select(i, ...))
        table.insert(ret, arg)
    end
    return table.concat(ret, '\t')
end

local function code(str)
    return "```\n" .. str .. "```"
end

return {
    name = "lua",
    description = "Execute lua code.",
    callback = function(message, args)

        if not (message.member.id == "445152230132154380") then
            return message:reply({
                embed = {
                    description = emojis.fail.." You don't have permission to use this command!",
                    color = colors.red
                }
            })
        end
        
        local Client = _G.client
        local toexec = table.concat(args, " ")
        local msg = message
        if toexec == "" or toexec == " " then return print("No toexec") end

        toexec = toexec:gsub('```\n?', '')
        toexec = toexec:gsub("“", '"')
        toexec = toexec:gsub("”", '"')

        local lines = {}
        local sandbox = {}

	    sandbox.print = function(...)
            table.insert(lines, printLine(...))
        end

        sandbox.p = function(...)
            table.insert(lines, prettyLine(...))
        end

        sandbox.message = msg
        sandbox.msg = msg
        sandbox.client = Client
        sandbox.me = message.member
		sandbox.keystone = message.guild.me
        sandbox.guild = message.guild
        sandbox.channel = message.channel
        sandbox._G = _G
        sandbox.args = args
        sandbox.dia = _G.discordia
        sandbox.discordia = _G.discordia
        sandbox.os = os
        sandbox.io = io
        sandbox.timer = _G.timer
        sandbox.coroutine = coroutine
        sandbox.math = math
        sandbox.string = string
        sandbox.table = table
        sandbox.tostring = tostring
        sandbox.tonumber = tonumber
        sandbox.pairs = pairs
        sandbox.type = type
        sandbox.require = require
		sandbox.emojis = _G.emojis
		sandbox.colors = _G.colors
		sandbox.you = message.referencedMessage and message.referencedMessage.member
		sandbox.ref = message.referencedMessage
        sandbox.allemojis = function()
            local emojistrings = {}
            local emojistr = ""
            local c = 0
        
            if not _G.emojis or type(_G.emojis) ~= "table" then
                sandbox.msg:reply("⚠️ **Error:** No emojis found in `_G.emojis`.")
                return
            end
        
            local emojiNames = {}
            for k in pairs(_G.emojis) do
                table.insert(emojiNames, k)
            end
        
            -- Sort alphabetically, case-insensitive
            table.sort(emojiNames, function(a, b)
                return a:lower() < b:lower()
            end)
        
            for _, emojiName in ipairs(emojiNames) do
                c = c + 1
                local emoji = _G.emojis[emojiName]
        
                -- Extract emoji ID if it's a custom emoji
                local emojiID = "Unicode"
                local matchedID = emoji:match("<a?:[%w_]+:(%d+)>") -- Match emoji ID if present
                if matchedID then
                    emojiID = matchedID
                end
        
                -- Append emoji with markdown formatting
                emojistr = emojistr .. "`" .. emojiName .. "` - `" .. emojiID .. "` - " .. emoji .. "\n"
        
                -- Send in chunks to avoid exceeding Discord's character limit
                if emojistr:len() >= 1500 or c >= #emojiNames then
                    table.insert(emojistrings, emojistr)
                    emojistr = ""
                end
            end
        
            -- Send messages
            for _, emj in pairs(emojistrings) do
                sandbox.msg:reply(emj)
            end
        end
        
        sandbox.deepreply = function(content)
            local ref = message.referencedMessage

            if ref then
                msg:delete()
                ref:reply(content, true, true)
            end
        end

        local response = message:reply({
            embed = {
                description = emojis.loading .. " The following code is being executed...\n```lua\n" .. toexec .. "```",
                color = colors.lightBlue,
                author = {
                    name = message.channel.guild.name,
                    icon_url = message.channel.guild.iconURL
                }
            }
        })

        local startExecution = os.clock()

        local fn, syntaxError = load(toexec, 'Keystone', 't', sandbox)
        if not fn then
            return response:update({
                embed = {
                    description = emojis.warning .. " A syntax error occurred while running this code.",
                    fields = {
                        {
                            name = "Code:",
                            value = ">>> ```lua\n" .. toexec .. "```"
                        },
                        {
                            name = "Runtime Error:",
                            value = ">>> ```" .. syntaxError .. "```"
                        }
                    },
                    color = colors.orange,
                    author = {
                        name = message.channel.guild.name,
                        icon_url = message.channel.guild.iconURL
                    }
                }
            })
        end

        local success, runtimeError = pcall(fn)
        if not success then
            return response:update({
                embed = {
                    description = emojis.error .. " A runtime error occurred while running this code.",
                    fields = {
                        {
                            name = "Code:",
                            value = ">>> ```lua\n" .. toexec .. "```"
                        },
                        {
                            name = "Runtime Error:",
                            value = ">>> ```" .. runtimeError .. "```"
                        }
                    },
                    color = colors.red,
                    author = {
                        name = message.channel.guild.name,
                        icon_url = message.channel.guild.iconURL
                    }
                }
            })
        end

        local executedIn = os.clock() - startExecution

        local tosendlines = table.concat(lines, '\n')
		local sendasfile = tosendlines:len() > 1900

        if not (message and message.content) then return end

        if #lines ~= 0 then
			if sendasfile then
                response:update({
                    embed = {
                        description = emojis.success .. " This code has been successfully executed in **" .. math.round(executedIn, 3) .. "s**.\n-# " .. emojis.document .. " Output (" .. #lines .. " lines, " .. tosendlines:len() .. " characters):",
                        color = colors.green,
                        author = {
                            name = message.channel.guild.name,
                            icon_url = message.channel.guild.iconURL
                        }
                    }
                })

                return response.channel:send({
                    files = {
                        {
                            "output.txt",
                            tosendlines
                        }
                    }
                })
			else
				return response:update({
                    embed = {
                        description = emojis.success .. " This code was successfully executed! \n-# " .. emojis.document .. " Output " .. #lines .. " lines, " .. tosendlines:len() .. " characters:\n```\n" .. tosendlines .. "```",
                        color = colors.green,
                        author = {
                            name = message.channel.guild.name,
                            icon_url = message.channel.guild.iconURL
                        }
                    }
                })
			end
        else
            return response:update({
                embed = {
                    description = emojis.success .. " This code has been successfully executed.",
                    color = colors.green,
                    author = {
                        name = message.channel.guild.name,
                        icon_url = message.channel.guild.iconURL
                    }
                }
            })
        end
    end
}