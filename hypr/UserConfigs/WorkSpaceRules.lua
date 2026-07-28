-- /* ---- 💫 https://github.com/JaKooLit 💫 ---- */ --

-- NOTE: THIS IS NOT BEING SOURCED by hyprland
-- It is only here as a guide if you want to do it manually
-- The file you should edit is ~/.config/hypr/workspaces.conf
-- Since that is the work space rules being sourced by hyprland
-- use nwg-displays to handle your workspace rules.

-- You can set workspace rules to achieve workspace-specific behaviors.
-- For instance, you can define a workspace where all windows are drawn without borders or gaps.

-- https://wiki.hyprland.org/Configuring/Workspace-Rules/

local M = {}

-- Assigning workspace to a certain monitor. Below are just examples (all disabled)
M.workspace_monitor_examples = {
	{ rule = "1, monitor:eDP-1", enabled = false },
	{ rule = "2, monitor:eDP-1", enabled = false },
	{ rule = "3, monitor:eDP-1", enabled = false },
	{ rule = "4, monitor:eDP-1", enabled = false },
	{ rule = "5, monitor:DP-2", enabled = false },
	{ rule = "6, monitor:DP-2", enabled = false },
	{ rule = "7, monitor:DP-2", enabled = false },
	{ rule = "8, monitor:DP-2", enabled = false },
}

-- example rules (from wiki), all disabled
M.example_rules = {
	{ rule = "3, rounding:false, decorate:false", enabled = false },
	{ rule = "name:coding, rounding:false, decorate:false, gapsin:0, gapsout:0, border:false, decorate:false, monitor:DP-1", enabled = false },
	{ rule = "8,bordersize:8", enabled = false },
	{ rule = "name:Hello, monitor:DP-1, default:true", enabled = false },
	{ rule = "name:gaming, monitor:desc:Chimei Innolux Corporation 0x150C, default:true", enabled = false },
	{ rule = "5, on-created-empty:[float] firefox", enabled = false },
	{ rule = "special:scratchpad, on-created-empty:foot", enabled = false },
}

return M
