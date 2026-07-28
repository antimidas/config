-- /* ---- 💫 https://github.com/JaKooLit 💫 ---- */ --
-- This is where you put your own keybinds. Be Mindful to check as well ~/.config/hypr/configs/Keybinds.conf to avoid conflict
-- if you think I should replace the Pre-defined Keybinds in ~/.config/hypr/configs/Keybinds.conf , submit an issue or let me know in DC and present me a valid reason as to why, such as conflicting with global shortcuts, etc etc

-- See https://wiki.hyprland.org/Configuring/Keywords/ for more settings and variables
-- See also Laptops.conf for laptops keybinds

local HOME = os.getenv("HOME")

-- /* ---- ✴️ Variables ✴️ ---- */ --
local mainMod     = "SUPER"
local scriptsDir  = HOME .. "/.config/hypr/scripts"
local UserScripts = HOME .. "/.config/hypr/UserScripts"
local UserConfigs = HOME .. "/.config/hypr/UserConfigs"

local M = {}

--  IMPORTANT: If you want to remap and existing keybind you MUST unbindd it first

-- The bindings are CASE SENSITIVE. We suggest you copy the exisitng binding here
--  Then change `bindd` to `unbind`

-- E.g.
-- M.binds[#M.binds+1] = { bindtype = "unbind", mods = mainMod, key = "Return", description = "Open terminal", dispatcher = "exec", args = "$term" }
-- M.binds[#M.binds+1] = { bindtype = "bindd", mods = mainMod, key = "Return", description = "Open terminal", dispatcher = "exec", args = "ghostty" }
--
-- M.binds[#M.binds+1] = { bindtype = "unbind", mods = mainMod, key = "E", description = "file manager", dispatcher = "exec", args = "$files" }
-- M.binds[#M.binds+1] = { bindtype = "bindd", mods = mainMod, key = "T", description = "file manager", dispatcher = "exec", args = "$files" }

-- If you are ADDING a bindd, make sure you include the description
-- Other the keybind search menu might not show it properly

-- E.g.
-- M.binds[#M.binds+1] = { bindtype = "bindd", mods = mainMod, key = "Z", description = "My z app", dispatcher = "exec", args = "APPNAME" }

-- User binds go here (empty by default in the source file)
M.binds = {}

-- For passthrough keyboard into a VM
-- M.binds[#M.binds+1] = { bindtype = "bind", mods = mainMod .. " ALT", key = "P", dispatcher = "submap", args = "passthru", enabled = false }
-- M.submaps = { { name = "passthru", enabled = false } }
-- to unbind
-- M.binds[#M.binds+1] = { bindtype = "bind", mods = mainMod .. " ALT", key = "P", dispatcher = "submap", args = "reset", enabled = false }
-- table.insert(M.submaps, { name = "reset", enabled = false })

return M
