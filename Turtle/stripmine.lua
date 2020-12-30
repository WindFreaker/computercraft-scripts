-- https://raw.githubusercontent.com/WindFreaker/computercraft-tests/master/Turtle/stripmine.lua

otherBlocks = {
	"minecraft:glass"
}

local function oreCheck (data)
	if data.tags["forge:ores"] then
		return true
	else
		-- this code block is useless right now, but could be useful in the future
		-- it can stay for now but might be wise to remove if performance gets bad
		for index, value in ipairs(otherBlocks) do
			if value == data.name then
				return true
			end
		end
	end
	return false
end

local function selectCobblestone ()
	for a = 1, 16, 1 do
		local data = turtle.getItemDetail(a)
		if data ~= nil and data.name == "minecraft:cobblestone" then
			turtle.select(a)
			return true
		end
	end
	return false
end

local function checkFuel (limit)
	if turtle.getFuelLevel() < limit then
		if turtle.refuel() then
			return turtle.getFuelLevel() <= limit
		end
		return false
	end
	return true
end

local function mineNearbyBlocks (up, down, left, right)
	if up then
		local existUp, dataUp = turtle.inspectUp()
		if existUp and oreCheck(dataUp) then
			turtle.digUp()
		end
	end
	if down then
		local existDown, dataDown = turtle.inspectDown()
		if existDown and oreCheck(dataDown) then
			turtle.digDown()
			if selectCobblestone() then
				turtle.placeDown()
			end
		end
	end
	if left then
		turtle.turnLeft()
		local existLeft, dataLeft = turtle.inspect()
		if existLeft and oreCheck(dataLeft) then
			turtle.dig()
		end
		turtle.turnRight()
	end
	if right then
		turtle.turnRight()
		local existRight, dataRight = turtle.inspect()
		if existRight and oreCheck(dataRight) then
			turtle.dig()
		end
		turtle.turnLeft()
	end
end

local function returnToStart (dist)
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

local function broadcastMessage (msg)
	print(msg)
	local modem = peripheral.wrap("right")
	formattedMsg = {
		["computerName"] = os.getComputerLabel(),
		["message"] = msg 
	}
	modem.transmit(1, 1, formattedMsg)
end

local tunnelOffset = 0 

-- returns to where last left off
print("Beginning tunnel traversal...")
local loop1 = true
while loop1 do

	-- checks that the turtle isn't going too far (AKA leaving loaded chunks)
	if tunnelOffset > 100 then
		broadcastMessage("Tunnel finished.")
		returnToStart(tunnelOffset)
		return  -- terminate the program?
	end

	-- checks fuel level every step of the way
	if not checkFuel(tunnelOffset + 2) then
		broadcastMessage("Not enough fuel.")
		returnToStart(tunnelOffset)
		return  -- terminate the program?
	end

	-- keeps moving forward until it can't anymore
	if turtle.forward() then
		tunnelOffset = tunnelOffset + 1
	else
		loop1 = false
		print("Obstruction detected. Beginning mining...")
	end

end

-- begins mining operation
local loop2 = true
while loop2 do

	-- checks that the turtle isn't going too far (AKA leaving loaded chunks)
	if tunnelOffset > 100 then
		broadcastMessage("Tunnel finished.")
		returnToStart(tunnelOffset)
		return  -- terminate the program?
	end

	-- checks fuel level on every loop
	if not checkFuel(tunnelOffset + 5) then
		broadcastMessage("Not enough fuel.")
		returnToStart(tunnelOffset)
		return  -- terminate the program?
	end

	-- breaks the block in front and then takes its place
	while not turtle.forward() do
		turtle.dig()
	end
	tunnelOffset = tunnelOffset + 1

	-- mines all blocks except for the one above
	mineNearbyBlocks(false, true, true, true)

	-- breaks the block above and then takes its place
	turtle.digUp()
	turtle.up()

	-- mines all the blocks except for the one below
	mineNearbyBlocks(true, false, true, true)

	-- breaks the block in front and then takes its place
	while not turtle.forward() do
		turtle.dig()
	end
	tunnelOffset = tunnelOffset + 1
	
	-- mines all the blocks except for the one below
	mineNearbyBlocks(true, false, true, true)

	-- breaks the block below and then takes its place
	turtle.digDown()
	turtle.down()

	-- mines all the blocks except for the one above
	mineNearbyBlocks(false, true, true, true)

end
