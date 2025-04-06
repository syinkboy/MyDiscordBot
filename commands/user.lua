-- user.lua
local discordia = _G.discordia
local client = _G.client
local sqldb = _G.sqldb

return {
    name = "user",
    description = "Manage users in the database",
    callback = function(message, args)
        print("User command run")
        if not args or not args[1] then
            print("Invalid command usage")
            return message:reply("Invalid command. Use: `!user add | get | remove <userId>`")
        end

        local command = args[1]
        local userId = args[2]

        print("Command:", command, " UserID:", userId)

        if not userId then
            print("User ID missing")
            return message:reply("Please provide a valid user ID.")
        end

        local user = client:getUser(userId)
        if not user then
            print("User not found in Discord")
            return message:reply("Invalid or unknown user ID.")
        end

        local username = user.username
        print("Successfully fetched user, " .. username)

        if command == "add" then
            local success, err = sqldb:saveUser(userId, username)
            print("Attempting to add user to database")
            if success then
                print("User added successfully")
                message:reply("**" .. username .. "** has been saved in the database.")
            else
                print("Error adding user:", err)
                message:reply("Error saving user: " .. (err or "Unknown error"))
            end

        elseif command == "get" then
            print("Fetching user from database")
            local success, storedUser = sqldb:getUser(userId)
            if success and storedUser then
                print("User retrieved successfully")
                message:reply("**Username:** " .. storedUser.username .. "\n**User ID:** `" .. storedUser.userId .. "`")
            else
                print("User not found in database")
                message:reply("User not found in the database.")
            end

        elseif command == "remove" then
            print("Attempting to remove user from database")
            local success, err = sqldb:removeUser(userId)
            if success then
                print("User removed successfully")
                message:reply("**" .. username .. "** has been removed from the database.")
            else
                print("Error removing user:", err)
                message:reply("Error removing user: " .. (err or "Unknown error"))
            end

        else
            print("Invalid command received")
            message:reply("Invalid command. Use: `!user add | get | remove <userId>`")
        end
    end
}