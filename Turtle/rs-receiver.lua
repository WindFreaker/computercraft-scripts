-- wget https://raw.githubusercontent.com/WindFreaker/computercraft-tests/master/Turtle/rs-receiver.lua



-- FUNCTIONS & STATIC DATA ABOVE
-- PROGRAM RUN ORDER STARTS HERE

WIRELESS = require("wireless")

print("Turning on all sides...")

local sideList = redstone.getSides()
for index, side in ipairs(sideList) do
    redstone.setOutput(side, true)
end

print("Waiting for orders...")

while true do
    id, name, msg = WIRELESS.pullMsg("redstone")
    if msg.state then
        print("Turning on " .. msg.side .. "...")
    else
        print("Turning off " .. msg.side .. "...")
    end
    redstone.setOutput(msg.side, msg.state)
end
