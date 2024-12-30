local discordia = _G.discordia
local client = _G.client

return {
    name = 'em',
    description = 'sends an embed',
    callback = function(message, args)
        local embed = {
            title = 'This is my second embed wihc i hope works tbh',
            description = 'This is an exampel of an embed.',
            color = 0x3498db, 
            timestamp = os.date('!%Y-%m-%dT%H:%M:%S'),
            footer = {
                Text = 'Footer Text',
            },
            author = {
                name = 'Author Name',
                url = 'https://www.youtube.com/',
            },
            fields = {
                {name = 'Sever name', value = 'Florida State RolePlay', inline = false},
                {name = 'About', value = 'This Is an RP server where you can RP as police and a lot more, the WL teams are, FBI, SWAT and FHP ghost.'}
            }
        }
        message.channel:send({
            embed = embed
        })
    end
}