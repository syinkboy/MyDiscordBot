local discordia = _G.discordia
local client = _G.client 


-- Module for the 'joke' command
return {
    name = "joke", -- Command name
    description = "Replies with a random joke!", -- Command description
    callback = function(message, args) -- Callback function for the command
        -- List of jokes
        local jokes = {
            "Why don't scientists trust atoms? Because they make up everything!",
            "Why did the scarecrow win an award? Because he was outstanding in his field!",
            "Why don't skeletons fight each other? They don't have the guts.",
            "Why did the bicycle fall over? It was two-tired!",
            "What do you call fake spaghetti? An impasta!"
        }

        -- Pick a random joke
        local randomJoke = jokes[math.random(#jokes)]

        -- Reply with the random joke
        message:reply(randomJoke)
    end
}
