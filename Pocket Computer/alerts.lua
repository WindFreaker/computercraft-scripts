-- https://raw.githubusercontent.com/WindFreaker/computercraft-tests/master/Pocket%20Computer/alerts.lua

function setHeader()
	local xPos, yPos = term.getCursorPos()
	term.setCursorPos(1, 1)
	term.setBackgroundColor(colors.gray)
	term.setTextColor(colors.white)
	print("Alerts Monitor            ")
	term.setCursorPos(xPos, yPos)
	term.setBackgroundColor(colors.black)
end

local modem = peripheral.wrap("back")
modem.open(1)

term.clear()
term.setCursorPos(1, 1)
print()

-- Christmas colors thing
local colorSwitch = true

while true do

	setHeader()

	event, side, recFreq, replyFreq, msg, dist = os.pullEvent("modem_message")
	
	if colorSwitch then
		term.setTextColor(colors.green)
		colorSwitch = false
	else
		term.setTextColor(colors.red)
		colorSwitch = true
	end

	print(msg.computerName)
	term.setTextColor(colors.white)
	print(msg.message)

end