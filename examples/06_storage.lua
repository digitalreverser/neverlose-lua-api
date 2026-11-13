-- @author Example
-- @uid 1
-- Counts script loads in the persistent storage and shows json / msgpack. Does not require Allow Insecure.

local runs = (database.example_runs or 0) + 1
database.example_runs = runs
print("this script was loaded " .. runs .. " time(s)")

local text = json.encode({ runs = runs, tags = { "a", "b" } })
local value = json.decode(text)
print(text, value.runs)

local packed = msgpack.pack({ runs = runs })
print(#packed .. " bytes of msgpack", msgpack.unpack(packed).runs)

utils.schedule(2, function(n) print("two seconds later, run " .. n) end, runs)
