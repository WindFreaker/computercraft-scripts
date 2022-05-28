-- https://raw.githubusercontent.com/WindFreaker/computercraft-tests/master/General/redstone.lua

local function enableRedstone(side)
	redstone.setOutput(side, true)
end

local function disableRedstone(side)
	redstone.setOutput(side, false)
end

local function toggleRedstone(side)
	local currentState = redstone.getOutput(side)
	if currentState then
		disableRedstone(side)
	else
		enableRedstone(side)
	end
end

-- FUNCTIONS & STATIC DATA ABOVE
-- PROGRAM RUN ORDER STARTS HERE

return {
	toggle = toggleRedstone,
	enable = enableRedstone,
	disable = disableRedstone
}
