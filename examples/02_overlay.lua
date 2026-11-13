-- @author Example
-- @uid 1
-- A toggle and a small overlay. Does not require Allow Insecure.

local tab = ui.tab("Lua Examples")
local group = tab:group("Overlay")
local enabled = group:toggle("Show example", true)
local font = render.load_font("verdana.ttf", 14)
local tint = color(220, 230, 255, 255)

events.render:set(function()
    if not enabled:get() then
        return
    end

    render.rect(vector2(20, 80), vector2(190, 35), color(15, 18, 25, 210), 6)
    render.text(font, vector2(30, 90), tint, "", "Neverlose Lua example")
end)
