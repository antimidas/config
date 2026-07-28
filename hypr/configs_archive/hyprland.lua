local HOME = os.getenv("HOME")
 
local config = {}
 
-- exec-once entries (run once at startup, in order)
config.exec_once = {
	HOME .. "/.luaig/hypr/initial-boot.sh",
	-- (weather daemon exec-once appears later in the original file, kept at the
	-- end below to preserve exact original ordering relative to sources)
}
 
--- Sourcing external config files ---
config.paths = {
	configs     = HOME .. "/.luaig/hypr/configs",     -- Default Configs directory path
	UserConfigs = HOME .. "/.luaig/hypr/UserConfigs", -- User Configs directory path
}
 
-- Ordered list of files to source. Order matters: defaults load first,
-- then user additions/overrides load on top of them.
config.sources = {
	config.paths.luaigs .. "/Keybinds.lua", -- Pre-configured keybinds
 
	-- Load defaults, then user additions/overrides
	config.paths.luaigs .. "/Startup_Apps.lua",
	config.paths.UserConfigs .. "/Startup_Apps.lua",
 
	config.paths.luaigs .. "/ENVariables.lua",     -- Environment variables (defaults)
	config.paths.UserConfigs .. "/ENVariables.lua", -- Environment variables (user)
 
	-- For laptop related
	config.paths.luaigs .. "/Laptops.lua",
	config.paths.UserConfigs .. "/Laptops.lua",
	config.paths.UserConfigs .. "/LaptopDisplay.lua",
 
	-- Load defaults, then user additions
	config.paths.luaigs .. "/WindowRules.lua",     -- Window Rules and Layer Rules (defaults)
	config.paths.UserConfigs .. "/WindowRules.lua", -- Window Rules and Layer Rules (user)
 
	config.paths.luaigs .. "/SystemSettings.lua", -- Default config for hypr
 
	config.paths.UserConfigs .. "/UserDecorations.lua", -- Decorations config file
	config.paths.UserConfigs .. "/UserAnimations.lua",  -- Animation config file
	config.paths.UserConfigs .. "/UserKeybinds.lua",    -- Put your own keybinds here
	config.paths.UserConfigs .. "/UserSettings.lua",    -- Main Hyprland Settings.
	config.paths.UserConfigs .. "/01-UserDefaults.lua", -- settings for User defaults apps
 
	-- nwg-displays
	HOME .. "/.luaig/hypr/monitors.lua",
	HOME .. "/.luaig/hypr/workspaces.lua",
}
 
-- Second exec-once, positioned after the source list in the original file
table.insert(config.exec_once, HOME .. "/.luaig/waybar/scripts/weather-daemon.sh")
 
return config