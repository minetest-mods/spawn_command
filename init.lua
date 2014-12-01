
minetest.register_chatcommand("spawn", {
    description = "Teleport you to spawn point at (0,3,0)",
    func = function(name)
        local player = minetest.env:get_player_by_name(name)
        if player == nil then
            -- just a check to prevent the server crashing
            return false
        end
        local pos = player:getpos()
        if pos.x>-20 and pos.x<20 and pos.y>-20 and pos.z>-20 and pos.z<20 then
        
        else
            player:setpos({x=0, y=3, z=0})
            minetest.chat_send_player(name, "Teleported to spawn!")
        end
    end,
})
