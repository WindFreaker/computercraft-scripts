-- https://raw.githubusercontent.com/WindFreaker/computercraft-tests/master/Turtle/safety.lua

local dangerousBlocks = {
	"forbidden_arcanus:stella_arcanum"
}

local function checkDigSafety(data)
	for index, value in ipairs(dangerousBlocks) do
		if value == data.name then
			return false
		end
	end
	return true
end

local function throwError(data)
	local text = "Unsafe block detected: " .. data.name
	WIRELESS.sendMsg(text)
	error(text)
end

local function safeDig()
	local exist, data = turtle.inspect()
	if exist then
		if checkDigSafety(data) then
			turtle.dig()
		else
			throwError(data)
		end
	end
end

local function safeDigUp()
	local exist, data = turtle.inspectUp()
	if exist then
		if checkDigSafety(data) then
			turtle.digUp()
		else
			throwError(data)
		end
	end
end

local function safeDigDown()
	local exist, data = turtle.inspectDown()
	if exist then
		if checkDigSafety(data) then
			turtle.digDown()
		else
			throwError(data)
		end
	end
end

-- FUNCTIONS & STATIC DATA ABOVE
-- PROGRAM RUN ORDER STARTS HERE

WIRELESS = require("wireless")

return {
	dig = safeDig,
	digUp = safeDigUp,
	digDown = safeDigDown
}
