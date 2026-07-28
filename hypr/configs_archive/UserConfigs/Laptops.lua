-- /* ---- 💫 https://github.com/JaKooLit 💫 ---- */ --
-- See https://wiki.hyprland.org/Configuring/Keywords/ for more variable settings
-- These configs are mostly for laptops. This is addemdum to Keybinds.conf

local HOME = os.getenv("HOME")

local mainMod     = "SUPER"
local scriptsDir  = HOME .. "/.config/hypr/scripts"
local UserConfigs = HOME .. "/.config/hypr/UserConfigs"

local M = {}

-- Below are useful when you are connecting your laptop in external display
-- Suggest you edit below for your laptop display
-- From WIKI This is to disable laptop monitor when lid is closed.
-- consult https://wiki.hyprland.org/hyprland-wiki/pages/Configuring/Binds/#switches
M.binds = {
	{ bindtype = "bindl", mods = "", key = "switch:off:Lid Switch", dispatcher = "exec",
	  args = 'hyprctl keyword monitor "eDP-1, preferred, auto, 1"', enabled = false },
	{ bindtype = "bindl", mods = "", key = "switch:on:Lid Switch", dispatcher = "exec",
	  args = 'hyprctl keyword monitor "eDP-1, disable"', enabled = false },

	-- WARNING! Using this method has some caveats!! USE THIS PART WITH SOME CAUTION!
	-- CONS of doing this, is that you need to set up your wallpaper (SUPER W) and choose wallpaper.
	-- CAVEATS! Sometimes the Main Laptop Monitor DOES NOT have display that it needs to re-connect your external monitor
	-- One work around is to ensure that before shutting down laptop, MAKE SURE your laptop lid is OPEN!!
	-- Make sure to comment (put # on the both the bindl = , switch ......) above
	-- NOTE: Display for laptop are being generated into LaptopDisplay.conf
	-- This part is to be use if you do not want your main laptop monitor to wake up during say wallpaper change etc
	{ bindtype = "bindl", mods = "", key = "switch:off:Lid Switch", dispatcher = "exec",
	  args = 'echo "monitor = eDP-1, preferred, auto, 1" > ' .. UserConfigs .. "/LaptopDisplay.conf", enabled = false },
	{ bindtype = "bindl", mods = "", key = "switch:on:Lid Switch", dispatcher = "exec",
	  args = 'echo "monitor = eDP-1, disable" > ' .. UserConfigs .. "/LaptopDisplay.conf", enabled = false },
}

-- for laptop-lid action (to erase the last entry)
M.exec_once = {
	{ cmd = 'echo "monitor = eDP-1, preferred, auto, 1" > ' .. HOME .. "/.config/hypr/UserConfigs/LaptopDisplay.conf",
	  enabled = false },
}

return M
