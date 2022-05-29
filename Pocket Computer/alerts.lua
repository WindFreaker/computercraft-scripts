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

-- FUNCTIONS & STATIC DATA ABOVE
-- PROGRAM RUN ORDER STARTS HERE

WIRELESS = require("wireless")

term.clear()
term.setCursorPos(1, 2)

while true do

	setHeader()

	local id, name, msg = WIRELESS.pullMsg("alert")

	print("[" .. id .. "] " .. name)
	term.setTextColor(colors.white)
	print(msg)

end
