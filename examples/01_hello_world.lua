-- @author Example
-- @uid 1
-- Messages on load and unload. Does not require Allow Insecure.

print("Hello from Neverlose Lua!")

events.shutdown:set(function()
    print("Script unloaded")
end)
