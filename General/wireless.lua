local function openChannel(channel, type)
	MODEM.open(channel)
	-- this function is still WIP
end

local function formatMessage (type, message)
	local formatted = {
		["type"] = type,
		["computerId"] = os.getComputerId(),
		["computerName"] = os.getComputerLabel(),
		["message"] = message
	}
	return formatted
end

local function broadcastAlert (message)
	local formattedMsg = formatMessage("alert", message)
	MODEM.transmit(1, 1, formattedMsg)
end

MODEM = peripheral.wrap(side)

return {
	sendAlert = broadcastAlert,
	open = openChannel
}
