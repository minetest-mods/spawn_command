spawn_command = {}
spawn_command.pos = { x = 0, y = 3, z = 0 }
local cursed_world_exists = core.get_modpath("cursed_world")

if core.setting_get_pos("static_spawnpoint") then
	spawn_command.pos = core.setting_get_pos("static_spawnpoint")
end

function spawn_command.teleport_to_spawn(name)
	local player = core.get_player_by_name(name)
	if player == nil then
		-- just a check to prevent the server crashing
		return false
	end
	local pos = player:get_pos()
	if math.abs(spawn_command.pos.x - pos.x) < 20 and math.abs(spawn_command.pos.z - pos.z) < 20 then
		core.chat_send_player(name, "Already close to spawn!")
	elseif
		cursed_world_exists
		and _G["cursed_world"] ~= nil --check global table for cursed_world mod
		and cursed_world.location_y
		and cursed_world.dimension_y
		and pos.y < (cursed_world.location_y + cursed_world.dimension_y) --if player is in cursed world, stay in cursed world
		and pos.y > (cursed_world.location_y - cursed_world.dimension_y)
	then --check global table for cursed_world mod
		--[[
        core.chat_send_player(name, "T"..(cursed_world.location_y + cursed_world.dimension_y).." "..
        (cursed_world.location_y - cursed_world.dimension_y))
        ]]
		local spawn_pos = vector.round(spawn_command.pos)
		spawn_pos.y = spawn_pos.y + cursed_world.location_y
		player:set_pos(spawn_pos)
		core.chat_send_player(name, "Teleported to spawn!")
	else
		player:set_pos(spawn_command.pos)
		core.chat_send_player(name, "Teleported to spawn!")
	end
end

core.register_chatcommand("spawn", {
	description = "Teleport you to spawn point.",
	func = spawn_command.teleport_to_spawn,
})
