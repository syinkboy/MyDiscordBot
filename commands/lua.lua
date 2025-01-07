```lua
local discordia = _G.discordia
local client = _G.client
local resolveEmoji = _G.resolveEmoji
_G.resolveEmoji = resolveEmoji

--[ Authorized User --]
local authorizedUserID = "THE_ID_YOU_WANT_AUTHORIZED"

return {
    name = "lua",
    description = "Execute a LUA command",
    callback = function(message, args)
        local luaCode = table.concat(args, " ")

        local member = message.member

        local invalidPermsEmbed = {
            title = "<:WarningRed:1326148101534253107> **Invalid Permission!**",
            description = "<:RightArrow:1320102028848136294> **Only <@"..authorizedUserID.."> is allowed to execution this command!**",
            color = 0xFF0000,
        }

        if message.author.id ~= authorizedUserID then
            message:reply({
                embed = invalidPermsEmbed,
                reference = {
                    message = message.id,
                }
            })
            return
        end

        --[ Create a sandboxed environment and capture print output --]
        local sandbox = { output = {} }
        setmetatable(sandbox, { __index = _G })

        --[ Override the print function to capture output --]
        sandbox.print = function(...)
            local args = {...}
            for i = 1, #args do
                args[i] = tostring(args[i])
            end
            table.insert(sandbox.output, table.concat(args, " "))
        end

        --[ Load the Lua code --]
        local fn, err = load(luaCode, "LuaCode", "t", sandbox)
        if not fn then
            --[ Send an error message if the code fails to load --]
            message:reply {
                embed = {
                    title = "Error",
                    description = "Failed to execute code: " .. err,
                    color = 0xFF0000
                }
            }
            message:addReaction(resolveEmoji("<:failRed:1326159993862357014>").hash)
            return
        end

        --[ Execute the function and capture runtime errors --]
        local success, runtimeErr = pcall(fn)
        if not success then
            message:reply {
                embed = {
                    title = "Runtime Error",
                    description = "Error: " .. runtimeErr,
                    color = 0xFF0000
                },
                reference = {
                    message = message.id
                }
            }
            message:addReaction(resolveEmoji("<:failRed:1326159993862357014>").hash)
            return
        end

        --[ Retrieve captured output from the sandbox --]
        local output = table.concat(sandbox.output, "\n")
        if output == "" then
            output = "No output."
        end

        message:reply {
            embed = {
                description = "```\n" .. output .. "\n```",
                color = 0x00FF00
            },
            reference = {
                message = message.id
            }
        }
        message:addReaction(resolveEmoji("<:successGreen:1326160003370848297>").hash)
    end
}
```