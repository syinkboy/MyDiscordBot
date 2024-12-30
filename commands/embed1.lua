local discordia = _G.discordia
local client = _G.client

return {
    name = "embed",
    description = "Sends an embed",
    callback = function(message, args)
        local embed = {
            title = "I will prob add an componment tbh as it seems easy ngl",
            description = "This is an example of an embed.",
            color = 0x3498db, 
            timestamp = os.date('!%Y-%m-%dT%H:%M:%S'),
            footer = {
                text = "Footer Text",
            },
            author = {
                name = "Author Name",
                url = "https://example.com"
            },
            fields = {
                {name = "Field 1", value = "This is the first field.", inline = true},
                {name = "Field 2", value = "This is the second field.", inline = true}
            }
        }

        message.channel:send({
            embed = embed
        })
    end
}