return {
    name = "lau",
    description = "Execute Lua code",
    permissions = {}, -- optionally restrict who can run it
    run = function(self, message, args)
        -- Security: only allow specific users
        local allowedUsers = {
            ["1357707043602956450"] = true,
            ["YOUR_USER_ID_2"] = true,
        }

        if not allowedUsers[message.author.id] then
            message:reply("🚫 You are not allowed to run Lua code.")
            return
        end

        local code = table.concat(args, " ")

        if code == "" then
            message:reply("❌ You need to provide Lua code to run.")
            return
        end

        local func, syntaxError = load("return " .. code)

        if not func then
            -- If "return" version fails, try without "return"
            func, syntaxError = load(code)
        end

        if not func then
            message:reply("❌ Syntax error: ```" .. syntaxError .. "```")
            return
        end

        local success, result = pcall(func)

        if success then
            message:reply("✅ Output: ```" .. tostring(result) .. "```")
        else
            message:reply("⚠️ Runtime error: ```" .. tostring(result) .. "```")
        end
    end
}
