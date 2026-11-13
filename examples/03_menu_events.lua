-- @author Example
-- @uid 1
-- Messages when the menu opens and closes, when a map loads and when a player is hurt.

events.menu_toggled:set(function(open)
    print(open and "Menu opened" or "Menu closed")
end)

events.level_init:set(function(map)
    print("Map loaded: " .. tostring(map))
end)

events.player_hurt:set(function(e)
    print(("%d damage with %s"):format(e:get_int("dmg_health"), e:get_string("weapon")))
end)
