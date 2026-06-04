local alert = require("hs.alert")
local timer = require("hs.timer")
local caffeinate = require("hs.caffeinate")
local hotkey = require("hs.hotkey")

local f = require("./functions")

f.mapKeys({
	{ modifiers = { "cmd" }, key = "b", fn = f.openFirefox },
	-- { modifiers = { "cmd", "shift" }, key = "p", fn = f.openFirefoxPrivate },
	{ modifiers = { "cmd" }, key = "g", fn = f.openChrome },
	{ modifiers = { "cmd" }, key = "return", fn = f.openKitty },

	{ modifiers = { "alt" }, key = "m", fn = f.zoom },
	{ modifiers = { "alt" }, key = "h", fn = f.slideLeft },
	{ modifiers = { "alt" }, key = "j", fn = f.slideBottom },
	{ modifiers = { "alt" }, key = "k", fn = f.slideTop },
	{ modifiers = { "alt" }, key = "l", fn = f.slideRight },

	{ modifiers = { "alt", "shift" }, key = "1", fn = f.moveWinToSpace1 },
	{ modifiers = { "alt", "shift" }, key = "2", fn = f.moveWinToSpace2 },
	{ modifiers = { "alt", "shift" }, key = "3", fn = f.moveWinToSpace3 },
	{ modifiers = { "alt", "shift" }, key = "4", fn = f.moveWinToSpace4 },
	{ modifiers = { "alt", "shift" }, key = "5", fn = f.moveWinToSpace5 },
})

--------------------------
--- Media Key Handling ---
--------------------------
local tap = hs.eventtap.new({ hs.eventtap.event.types.systemDefined }, function(event)
	local data = event:systemKey()

	if data["key"] == "PLAY" and data["down"] then
		f.mediaToggle()
		return true, nil
	end

	if data["key"] == "REWIND" and data["down"] then
		f.mediaPrev()
		return true, nil
	end

	if data["key"] == "FAST" and data["down"] then
		f.mediaNext()
		return true, nil
	end

	return false, nil
end)

if tap then
	tap:start()
end

------------
-- Spoons --
------------

hs.loadSpoon("Shade")

-----------------
-- Login Items --
-----------------

f.openKitty()
f.openFirefox()

-----------------
-- Break Timer --
-----------------

local breakTimer = timer.doEvery(60 * 50, function()
	alert.show("Take a break!")
	timer.doAfter(5, function()
		caffeinate.lockScreen()
	end)
end)

hotkey.bind({ "alt" }, "t", function()
	if breakTimer:running() then
		alert.show("Breaktimer stopped!")
		breakTimer:stop()
	else
		alert.show("Breaktimer started!")
		breakTimer:start()
	end
end)

------------------
-- Quick reload --
------------------

-- hotkey.bind({ "alt" }, "r", function()
-- 	reload()
-- end)
