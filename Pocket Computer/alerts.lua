-- https://raw.githubusercontent.com/WindFreaker/computercraft-tests/master/Pocket%20Computer/alerts.lua

local function setHeader()

	-- remember previous cursor position
	local xPos, yPos = term.getCursorPos()

	-- print the header
	term.setCursorPos(1, 1)
	term.setBackgroundColor(colors.gray)
	term.setTextColor(colors.white)
	print("      Alerts Monitor      ")

	-- restore cursor position and color
	term.setCursorPos(xPos, yPos)
	term.setBackgroundColor(colors.black)

end

-- ONLY FUNCTIONS & DATA FOUND ABOVE
-- PROGRAM RUN ORDER STARTS HERE

local modem = peripheral.wrap("back")
modem.open(1)

term.clear()
term.setCursorPos(1, 2)

-- Christmas colors thing
local colorSwitch = true

while true do

	setHeader()

	local event, side, recFreq, replyFreq, msg, dist = os.pullEvent("modem_message")

	if msg.type == "alert" then

		if colorSwitch then
			term.setTextColor(colors.green)
			colorSwitch = false
		else
			term.setTextColor(colors.red)
			colorSwitch = true
		end

		if msg.computerName == nil then
			msg.computerName = ""
		end

		print("[" .. msg.computerId .. "] " .. msg.computerName)
		term.setTextColor(colors.white)
		print(msg.message)

	end

end
