-- https://raw.githubusercontent.com/WindFreaker/computercraft-tests/master/General/wireless.lua

local function formatMessage(type, message)
	local formatted = {
		["type"] = type,
		["computerId"] = os.getComputerID(),
		["computerName"] = os.getComputerLabel(),
		["message"] = message
	}
	return formatted
end

local function broadcastMessage(type, message)
	if MODEM_CHECK then
		local formattedMsg = formatMessage(type, message)
		MODEM.transmit(1, 1, formattedMsg)
	end
end

local function receiveMessage(type)
	if MODEM_CHECK then
		while true do
			local event, side, recFreq, replyFreq, resp, dist = os.pullEvent("modem_message")
			if resp.type == type then
				return resp.message
			end
		end
	end
end

-- FUNCTIONS & STATIC DATA ABOVE
-- PROGRAM RUN ORDER STARTS HERE

MODEM_CHECK = false

local pList = peripheral.getNames()
for index, p in ipairs(peripheralList) do
	if peripheral.getType(p) == "modem" then
		MODEM = peripheral.wrap(p)
		MODEM.open(1)
		MODEM_CHECK = true
	end
end

return {
	sendMsg = broadcastMessage,
	pullMsg = receiveMessage,
}
