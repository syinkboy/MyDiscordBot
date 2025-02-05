local discordia = _G.discordia
local client = _G.client

return {
    name = 'embed1',
    description = 'Discord bot',
    callback = function(message, args)
    local embed = {
        title = 'About the bot',
        description = 'I will talk a bit about what this bot is and what it can do',
            color = 0x87CEEB,
            timestamp = os.date('!%Y-%m-%dT%H:%M:%S'),
            footer = {
                text = 'Test1',
            },
            author = {
                name = '',
            },
            fields = {
                {name = 'What is this all about?', value = 'Hello, this bot is all about me learning discordia.', inline = true},
                {name = 'Some commands not answering?', value = 'I am still learning, so some commands may not work. Some commands may also not work for you becuse you lack the right permissions to use them.', inline = true},
            }
    }
    message.channel:send({
        embed = embed
    })
end
}

