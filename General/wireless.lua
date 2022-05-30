-- wget https://raw.githubusercontent.com/WindFreaker/computercraft-tests/master/General/wireless.lua

local function formatMessage(type, message)
	local computerName = os.getComputerLabel()
	if computerName == nil then
		computerName = ""
	end

	local formatted = {
		["type"] = type,
		["computerId"] = os.getComputerID(),
		["computerName"] = computerName,
		["message"] = message
	}

	return formatted
end

local function broadcastMessage(type, message)
	local formattedMsg = formatMessage(type, message)
	MODEM.transmit(1, 1, formattedMsg)
end

local function receiveMessage(type)
	while true do
		local event, side, recFreq, replyFreq, resp, dist = os.pullEvent("modem_message")
		if resp.type == type then
			return resp.computerId, resp.computerName, resp.message
		end
	end
end

-- FUNCTIONS & STATIC DATA ABOVE
-- PROGRAM RUN ORDER STARTS HERE

local pList = peripheral.getNames()
for index, p in ipairs(pList) do
	if peripheral.getType(p) == "modem" then
		MODEM = peripheral.wrap(p)
		MODEM.open(1)
	end
end

return {
	sendMsg = broadcastMessage,
	pullMsg = receiveMessage,
}
