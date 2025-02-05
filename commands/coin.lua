local discordia = _G.discordia
local client = _G.client 

return {
    name = 'coin',
    description = 'Replies with either heads or tails',
    callback = function(message, args)
        local coin = {
            'heads',
            'tails',
        
        }



        local randomCoin = coin[math.random(#coin)]

        message:reply(randomCoin)
    end


}