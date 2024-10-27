local M = {}

local window = require("hs.window")
local hotkey = require("hs.hotkey")
local application = require("hs.application")

function M.zoom()
  window.focusedWindow():moveToUnit({0, 0, 1, 1})
end

function M.slideLeft()
  window.focusedWindow():moveToUnit({0, 0, 0.5, 1})
end

function M.slideBottom()
  window.focusedWindow():moveToUnit({0, 0.5, 1, 0.5})
end

function M.slideTop()
  window.focusedWindow():moveToUnit({0, 0, 1, 0.5})
end

function M.slideRight()
  window.focusedWindow():moveToUnit({0.5, 0, 0.5, 1})
end

local function _openApp(name); application.launchOrFocus(name); end

function M.openFirefox(); _openApp("firefox"); end
function M.openChrome(); _openApp("/Applications/Google Chrome.app/contents/MacOS/Google Chrome"); end
function M.openTerminal(); _openApp("kitty"); end
-- function M.openMusic(); _openApp("kitty music"); end
-- function M.openEditor(); _openApp("kitty nvim"); end

local function _moveWinToSpace(sp)
  hs.execute("/opt/homebrew/bin/yabai -m window --space " .. sp
)
end

function M.moveWinToSpace1(); _moveWinToSpace(1); end
function M.moveWinToSpace2(); _moveWinToSpace(2); end
function M.moveWinToSpace3(); _moveWinToSpace(3); end
function M.moveWinToSpace4(); _moveWinToSpace(4); end
function M.moveWinToSpace5(); _moveWinToSpace(5); end

function M.mapKeys(mappings)
	for i in pairs(mappings) do
		local modifiers = mappings[i]["modifiers"]
		local key = mappings[i]["key"]
		local fn = mappings[i]["fn"]
		hotkey.bind(modifiers, key, fn)
	end
end

-- local function _goToSpace(number)
--   local cmd = "/opt/homebrew/bin/yabai -m space --focus " .. number
--   hs.execute(cmd)
-- end

-- function M.goToSpace1(); _goToSpace(1); end
-- function M.goToSpace2(); _goToSpace(2); end
-- function M.goToSpace3(); _goToSpace(3); end
-- function M.goToSpace4(); _goToSpace(4); end
-- function M.goToSpace5(); _goToSpace(5); end

return M
