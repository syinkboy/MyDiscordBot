local discordia = _G.discordia
local client = _G.client 

local jokes = {
    "Why don't scientists trust atoms? Because they make up everything!",
    "Why did the scarecrow win an award? Because he was outstanding in his field!",
    "Why don't skeletons fight each other? They don't have the guts.",
    "Why did the bicycle fall over? It was two-tired!",
    "What do you call fake spaghetti? An impasta!"
}

client:on('messageCreate', function(message)
    if message.author.bot then return end


    if message.content == '!joke' then
        local randomJoke = jokes[math.random(#jokes)]
        message.channel:send(randomJoke)
    end

end)
   