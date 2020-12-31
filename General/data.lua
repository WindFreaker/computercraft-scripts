local function getCaller ()
	local fileName = debug.getinfo(2).source
	fileName = string.sub(fileName, 2, -5)
	fileName = string.lower(fileName)
	return fileName
end

local function saveVariable (varName, value)
	settings.load()
	local varLocation = getCaller() .. "." .. varName
	settings.set(varLocation, value)
	settings.save()
end

local function loadVariable (varName)
	settings.load()
	local varLocation = getCaller() .. "." .. varName
	local value = settings.get(varLocation)
	return value
end

return {
	save = saveVariable
	load = loadVariable
}