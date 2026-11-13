-- @author Example
-- @uid 1
-- Reads the command and the local player state every tick. Does not change the command.

local group = ui.tab("Lua Examples"):group("Createmove")
local log_jumps = group:toggle("Log jumps", true)
local log_grenade = group:toggle("Log grenade pin", false)

events.createmove:set(function(cmd, player)
    if log_jumps:get() and cmd.in_jump.pressed then
        local a = cmd.viewangles
        print(("jump: tick %d, pitch %.1f, yaw %.1f"):format(globals.tickcount, a.x, a.y))
    end

    if log_grenade:get() and player ~= nil then
        local weapon = player.weapon
        -- grenade fields can be read only while a grenade is held; with another weapon the read raises
        local ok, pulled = pcall(function() return weapon.m_bPinPulled end)
        if ok and pulled then
            print(("pin pulled, strength %.2f"):format(weapon.m_flThrowStrength))
        end
    end
end)
