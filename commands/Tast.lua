local discordia = _G.discordia
local client = _G.client 

 
local authorized = {"995664658038005772", "445152230132154380", '782235114858872854'}

local function has_perms(id)
    for i,v in ipairs(authorized) do
        if v == id then
            return true
        end
    end
    return false
end


return {
    name = 'Tast',
    description = 'Test',
    callback = function(message, args)
        if not has_perms(message.author.id) then return end
        local sent_msg = message:reply({
            content = 'Hey this worked and Im super happy for it',
        })
    end
}