-- @author Example
-- @uid 1
-- Draws a dot on every living player and traces a ray along the view. Does not require Allow Insecure.

local white = color(255, 255, 255, 255)
local red = color(255, 60, 60, 255)
local hit_point = nil

events.createmove:set(function(cmd)
    local me = entity.local_pawn()
    if me == nil or not me:is_alive() then
        hit_point = nil
        return
    end
    -- trace.* works only inside createmove and game event callbacks
    local from = me:origin() + vector(0, 0, 64)
    local to = from + cmd.viewangles:forward() * 4096
    local result = trace.ray(from, to, trace.filter(me, trace.mask.shot))
    hit_point = result.fraction < 1 and result.endpos or nil
end)

events.render:set(function()
    for _, pawn in ipairs(entity.pawns()) do
        if pawn:is_alive() then
            local p = render.world_to_screen(pawn:origin())
            if p then render.circle(p, white, 3) end
        end
    end
    if hit_point then
        local p = render.world_to_screen(hit_point)
        if p then render.circle(p, red, 5) end
    end
end)
