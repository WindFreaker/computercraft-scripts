-- wget https://raw.githubusercontent.com/WindFreaker/computercraft-tests/master/General/data.lua

local function getCaller()
	local fileName = debug.getinfo(3).source
	fileName = string.sub(fileName, 2, -5)
	fileName = string.lower(fileName)
	return fileName
end

local function saveVariable(varName, value)
	settings.load()
	local varLocation = getCaller() .. "." .. varName
	settings.set(varLocation, value)
	settings.save()
end

local function loadVariable(varName)
	settings.load()
	local varLocation = getCaller() .. "." .. varName
	local value = settings.get(varLocation)
	return value
end

-- FUNCTIONS & STATIC DATA ABOVE
-- PROGRAM RUN ORDER STARTS HERE

return {
	save = saveVariable,
	load = loadVariable,
}
