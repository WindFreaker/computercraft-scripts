-- wget https://raw.githubusercontent.com/WindFreaker/computercraft-tests/main/Turtle/stripmine.lua

local function printAlert(msg)
    print(msg)
    WIRELESS.sendAlert(msg)
end

local oreWhitelist = {
    "nothing:here"
}

local oreBlacklist = {
    "nothing:here"
}

local function oreCheck(data)
    if data.tags["forge:ores"] then
        for index, value in ipairs(oreBlacklist) do
            if value == data.name then
                return false
            end
        end
        return true
    else
        for index, value in ipairs(oreWhitelist) do
            if value == data.name then
                return true
            end
        end
        return false
    end
end

local function selectCobblestone()
    for a = 1, 16, 1 do
        local data = turtle.getItemDetail(a)
        if data ~= nil and data.name == "minecraft:cobblestone" then
            turtle.select(a)
            return true
        end
    end
    return false
end

local function fuelCheck(limit)
    if turtle.getFuelLevel() < limit then
        if turtle.refuel() then
            return turtle.getFuelLevel() >= limit
        end
        return false
    end
    return true
end

local function inventoryCheck()

end

local function mineNearbyBlocks(up, down, left, right)
    if up then
        local existUp, dataUp = turtle.inspectUp()
        if existUp and oreCheck(dataUp) then
            SAFETY.digUp()
        end
    end
    if down then
        local existDown, dataDown = turtle.inspectDown()
        if existDown and oreCheck(dataDown) then
            SAFETY.digDown()
        end
        if selectCobblestone() then
            turtle.placeDown()
        end
    end
    if left then
        turtle.turnLeft()
        local existLeft, dataLeft = turtle.inspect()
        if existLeft and oreCheck(dataLeft) then
            SAFETY.dig()
        end
        turtle.turnRight()
    end
    if right then
        turtle.turnRight()
        local existRight, dataRight = turtle.inspect()
        if existRight and oreCheck(dataRight) then
            SAFETY.dig()
        end
        turtle.turnLeft()
    end
end

local function returnToStart(dist)
    print("Returning to starting position...")
    turtle.turnLeft()
    turtle.turnLeft()
    local a = 0
    while a ~= dist do
        if turtle.forward() then
            a = a + 1
        end
    end
    turtle.turnLeft()
    turtle.turnLeft()
end

-- FUNCTIONS & STATIC DATA ABOVE
-- PROGRAM RUN ORDER STARTS HERE

WIRELESS = require("wireless")
SAFETY = require("safety")

local args = { ... }
if #args ~= 1 then
    print("Missing command line argument for length of tunnel")
    return
end
local tunnelLength = tonumber(args[1])

local tunnelOffset = 0

-- returns to where last left off
print("Beginning tunnel traversal...")
while true do
    -- checks that the turtle isn't going too far (IE leaving loaded chunks)
    if tunnelOffset > tunnelLength then
        printAlert("Tunnel length goal reached")
        returnToStart(tunnelOffset)
        return
    end

    -- checks fuel level every step of the way
    if not fuelCheck(tunnelOffset + 2) then
        printAlert("Not enough fuel")
        returnToStart(tunnelOffset)
        return
    end

    -- keeps moving forward until it can't anymore
    if turtle.forward() then
        tunnelOffset = tunnelOffset + 1
    else
        print("Obstruction detected. Beginning mining...")
        break
    end
end

-- begins mining operation
while true do
    -- checks that the turtle isn't going too far (AKA leaving loaded chunks)
    if tunnelOffset > tunnelLength then
        printAlert("Tunnel length goal reached")
        returnToStart(tunnelOffset)
        return
    end

    -- checks fuel level on every loop
    if not fuelCheck(tunnelOffset + 5) then
        printAlert("Not enough fuel")
        returnToStart(tunnelOffset)
        return
    end

    -- breaks the block in front and then takes its place
    -- using while loop to properly handle gravity blocks such as gravel
    while not turtle.forward() do
        SAFETY.dig()
    end
    tunnelOffset = tunnelOffset + 1

    -- mines all blocks except for the one above
    mineNearbyBlocks(false, true, true, true)

    -- breaks the block above and then takes its place
    -- while loop not needed as gravity blocks are not an issue
    SAFETY.digUp()
    turtle.up()

    -- mines all the blocks except for the one below
    mineNearbyBlocks(true, false, true, true)

    -- breaks the block in front and then takes its place
    -- using while loop to properly handle gravity blocks such as gravel
    while not turtle.forward() do
        SAFETY.dig()
    end
    tunnelOffset = tunnelOffset + 1

    -- mines all the blocks except for the one below
    mineNearbyBlocks(true, false, true, true)

    -- breaks the block below and then takes its place
    -- while loop not needed as gravity blocks are not an issue
    SAFETY.digDown()
    turtle.down()

    -- mines all the blocks except for the one above
    mineNearbyBlocks(false, true, true, true)
end
