-- /* ---- 💫 https://github.com/JaKooLit 💫 ---- */ --
-- Commands and Apps to be executed at launch (vendor defaults)

local HOME = os.getenv("HOME")

local scriptsDir  = HOME .. "/.config/hypr/scripts"
local UserScripts = HOME .. "/.config/hypr/UserScripts"
local lock        = scriptsDir .. "/LockScreen.sh"
local SwwwRandom  = UserScripts .. "/WallpaperAutoChange.sh"
local livewallpaper = ""
local wallDIR = HOME .. "/Pictures/wallpapers" -- change path manually here if needed

local M = {}

--- wallpaper stuff ---
M.exec_once = {
	{ cmd = "swww-daemon --format xrgb", enabled = true },
	{ cmd = 'mpvpaper \'*\' -o "load-scripts=no no-audio --loop" ' .. livewallpaper, enabled = false },
	-- wallpaper random
	{ cmd = SwwwRandom .. " " .. wallDIR, enabled = false, comment = "random wallpaper switcher every 30 minutes" },

	--- Startup ---
	{ cmd = "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP", enabled = true },
	{ cmd = "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP", enabled = true },
	{ cmd = HOME .. "/.config/hypr/scripts/Dropterminal.sh kitty &", enabled = true },
	{ cmd = scriptsDir .. "/Polkit.sh", enabled = true },
	{ cmd = "nm-applet --indicator", enabled = true },
	{ cmd = "nm-tray", enabled = true, comment = "For ubuntu" },
	{ cmd = "swaync", enabled = true },
	{ cmd = "ags", enabled = false },
	{ cmd = "blueman-applet", enabled = false },
	{ cmd = "rog-control-center", enabled = false },
	{ cmd = "waybar", enabled = true },
	{ cmd = "qs -c overview", enabled = true, comment = "Quickshell Overview" },
	{ cmd = "hypridle", enabled = true },
	{ cmd = scriptsDir .. "/Hyprsunset.sh init", enabled = true },

	-- Clipboard manager
	{ cmd = "wl-paste --type text --watch cliphist store", enabled = true },
	{ cmd = "wl-paste --type image --watch cliphist store", enabled = true },

	-- Rainbow borders (disabled by default; use quick settings menu)
	{ cmd = UserScripts .. "/RainbowBorders.sh", enabled = false },

	-- Here are list of features available but disabled by default
	-- Persistent wallpaper
	{ cmd = "swww-daemon --format xrgb && swww img " .. wallDIR .. "/mecha-nostalgia.png", enabled = false },

	-- Gnome polkit for NixOS
	{ cmd = scriptsDir .. "/Polkit-NixOS.sh", enabled = false },

	-- xdg-desktop-portal-hyprland (should be auto starting. However, you can force to start)
	{ cmd = scriptsDir .. "/PortalHyprland.sh", enabled = false },

	{ cmd = "blueman-applet", enabled = true },
	{ cmd = "qs -c overview", enabled = true, comment = "Quickshell Overview" },
	{ cmd = scriptsDir .. "/KeybindsLayoutInit.sh", enabled = true },
}

return M