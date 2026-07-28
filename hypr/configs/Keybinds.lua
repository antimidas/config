local mainMod = "SUPER"
local terminal = "kitty"
local fileManager = "thunar"
local scriptsDir = os.getenv("HOME") .. "/.config/hypr/scripts"
local UserConfigs = os.getenv("HOME") .. "/.config/hypr/UserConfigs"
local UserScripts = os.getenv("HOME") .. "/.config/hypr/UserScripts"

-- Common shortcuts
hl.bind(mainMod .. " + Super_L", hl.dsp.exec_cmd("pkill rofi || " .. os.getenv("HOME") .. "/.config/rofi/launchers/type-2/launcher.sh"))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("xdg-open 'https://'"))
hl.bind(mainMod .. " + Tab", hl.dsp.exec_cmd(scriptsDir .. "/OverviewToggle.sh"))
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))

-- Features / Extras
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(scriptsDir .. "/ThemeChanger.sh"))
hl.bind(mainMod .. " + H", hl.dsp.exec_cmd(scriptsDir .. "/KeyHints.sh"))
hl.bind(mainMod .. " + ALT + R", hl.dsp.exec_cmd(scriptsDir .. "/Refresh.sh"))
hl.bind(mainMod .. " + ALT + E", hl.dsp.exec_cmd(scriptsDir .. "/RofiEmoji.sh"))
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd(scriptsDir .. "/RofiSearch.sh"))
hl.bind(mainMod .. " + CTRL + S", hl.dsp.exec_cmd("rofi -show window"))
hl.bind(mainMod .. " + ALT + O", hl.dsp.exec_cmd(scriptsDir .. "/ChangeBlur.sh"))
hl.bind(mainMod .. " + SHIFT + G", hl.dsp.exec_cmd(scriptsDir .. "/GameMode.sh"))
hl.bind(mainMod .. " + ALT + L", hl.dsp.exec_cmd(scriptsDir .. "/ChangeLayout.sh"))
hl.bind(mainMod .. " + ALT + V", hl.dsp.exec_cmd(scriptsDir .. "/ClipManager.sh"))
hl.bind(mainMod .. " + CTRL + R", hl.dsp.exec_cmd(scriptsDir .. "/RofiThemeSelector.sh"))
hl.bind(mainMod .. " + CTRL + SHIFT + R", hl.dsp.exec_cmd("pkill rofi || true && " .. scriptsDir .. "/RofiThemeSelector-modified.sh"))

hl.bind(mainMod .. " + SHIFT + F", hl.dsp.exec_cmd("hyprctl dispatch fullscreen 0"))
hl.bind(mainMod .. " + CTRL + F", hl.dsp.exec_cmd("hyprctl dispatch fullscreen 1"))
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd("hyprctl dispatch togglefloating"))
hl.bind(mainMod .. " + ALT + SPACE", hl.dsp.exec_cmd("hyprctl dispatch workspaceopt allfloat"))

-- 2. Dropdown terminal
-- hl.bind(mainMod .. " + SHIFT + Return", hl.dsp.exec_cmd(scriptsDir .. "/Dropterminal.sh " .. terminal))
hl.bind(mainMod ..  " + SHIFT + Return", hl.dsp.exec_cmd("pypr toggle term"))
hl.bind(mainMod ..  " + R", hl.dsp.exec_cmd("pypr toggle ranger"))


-- Zoom / Magnifier
hl.bind(mainMod .. " + ALT + mouse_down", hl.dsp.exec_cmd("hyprctl keyword cursor:zoom_factor \"$(hyprctl getoption cursor:zoom_factor | awk 'NR==1 {factor = $2; if (factor < 1) {factor = 1}; print factor * 2.0}')\""))
hl.bind(mainMod .. " + ALT + mouse_up", hl.dsp.exec_cmd("hyprctl keyword cursor:zoom_factor \"$(hyprctl getoption cursor:zoom_factor | awk 'NR==1 {factor = $2; if (factor < 1) {factor = 1}; print factor / 2.0}')\""))

-- Waybar / Bar related
hl.bind(mainMod .. " + CTRL + ALT + B", hl.dsp.exec_cmd("pkill -SIGUSR1 waybar"))
hl.bind(mainMod .. " + CTRL + B", hl.dsp.exec_cmd(scriptsDir .. "/WaybarStyles.sh"))
hl.bind(mainMod .. " + ALT + B", hl.dsp.exec_cmd(scriptsDir .. "/WaybarLayout.sh"))

-- Night light toggle
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd(scriptsDir .. "/Hyprsunset.sh toggle"))

-- UserScripts
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.exec_cmd(UserScripts .. "/RofiBeats.sh"))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd(UserScripts .. "/WallpaperSelect.sh"))
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd(UserScripts .. "/WallpaperEffects.sh"))
hl.bind("CTRL + ALT + W", hl.dsp.exec_cmd(UserScripts .. "/WallpaperRandom.sh"))
hl.bind(mainMod .. " + CTRL + O", hl.dsp.exec_cmd("hyprctl dispatch setprop active opaque toggle"))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.exec_cmd(scriptsDir .. "/KeyBinds.sh"))
hl.bind(mainMod .. " + SHIFT + A", hl.dsp.exec_cmd(scriptsDir .. "/Animations.sh"))
hl.bind(mainMod .. " + SHIFT + O", hl.dsp.exec_cmd(UserScripts .. "/ZshChangeTheme.sh"))
hl.bind("ALT_L + SHIFT_L", hl.dsp.exec_cmd(scriptsDir .. "/KeyboardLayout.sh switch"))
hl.bind("SHIFT_L + ALT_L", hl.dsp.exec_cmd(scriptsDir .. "/Tak0-Per-Window-Switch.sh"))
hl.bind(mainMod .. " + ALT + C", hl.dsp.exec_cmd(UserScripts .. "/RofiCalc.sh"))

-- Move workspaces to monitors
hl.bind(mainMod .. " + CTRL + F9", hl.dsp.exec_cmd("hyprctl dispatch movecurrentworkspacetomonitor l"))
hl.bind(mainMod .. " + CTRL + F10", hl.dsp.exec_cmd("hyprctl dispatch movecurrentworkspacetomonitor r"))
hl.bind(mainMod .. " + CTRL + F11", hl.dsp.exec_cmd("hyprctl dispatch movecurrentworkspacetomonitor u"))
hl.bind(mainMod .. " + CTRL + F12", hl.dsp.exec_cmd("hyprctl dispatch movecurrentworkspacetomonitor d"))

-- System
hl.bind("CTRL + ALT + Delete", hl.dsp.exec_cmd("hyprctl dispatch exit 0"))
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd("hyprctl dispatch killactive"))
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.exec_cmd(scriptsDir .. "/KillActiveProcess.sh"))
hl.bind("CTRL + ALT + L", hl.dsp.exec_cmd(scriptsDir .. "/LockScreen.sh"))
hl.bind("CTRL + ALT + Backspace", hl.dsp.exec_cmd("nwg-bar -i 81"))
hl.bind(mainMod .. " + SHIFT + N", hl.dsp.exec_cmd("swaync-client -t -sw"))
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exec_cmd(scriptsDir .. "/Kool_Quick_Settings.sh"))

-- Master Layout
hl.bind(mainMod .. " + CTRL + D", hl.dsp.exec_cmd("hyprctl dispatch layoutmsg removemaster"))
hl.bind(mainMod .. " + I", hl.dsp.exec_cmd("hyprctl dispatch layoutmsg addmaster"))
hl.bind(mainMod .. " + CTRL + Return", hl.dsp.exec_cmd("hyprctl dispatch layoutmsg swapwithmaster"))
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("hyprctl dispatch splitratio 0.3"))

-- Cycle Windows & Groups
hl.bind("ALT + Tab", hl.dsp.exec_cmd("hyprctl dispatch cyclenext"))
hl.bind(mainMod .. " + G", hl.dsp.exec_cmd("hyprctl dispatch togglegroup"))
hl.bind(mainMod .. " + Tab", hl.dsp.exec_cmd("hyprctl dispatch changegroupactive f"))
hl.bind(mainMod .. " + CTRL + Tab", hl.dsp.exec_cmd("hyprctl dispatch changegroupactive"))
hl.bind(mainMod .. " + SHIFT + Tab", hl.dsp.exec_cmd("hyprctl dispatch changegroupactive b"))
hl.bind(mainMod .. " + CTRL + K", hl.dsp.exec_cmd("hyprctl dispatch moveintogroup l"))
hl.bind(mainMod .. " + CTRL + L", hl.dsp.exec_cmd("hyprctl dispatch moveintogroup r"))
hl.bind(mainMod .. " + CTRL + H", hl.dsp.exec_cmd("hyprctl dispatch moveoutofgroup"))

-- Focus / Move / Resize
hl.bind(mainMod .. " + left", hl.dsp.exec_cmd("hyprctl dispatch movefocus l"))
hl.bind(mainMod .. " + right", hl.dsp.exec_cmd("hyprctl dispatch movefocus r"))
hl.bind(mainMod .. " + up", hl.dsp.exec_cmd("hyprctl dispatch movefocus u"))
hl.bind(mainMod .. " + down", hl.dsp.exec_cmd("hyprctl dispatch movefocus d"))

hl.bind(mainMod .. " + SHIFT + left", hl.dsp.exec_cmd("hyprctl dispatch resizeactive -50 0"))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.exec_cmd("hyprctl dispatch resizeactive 50 0"))
hl.bind(mainMod .. " + SHIFT + up", hl.dsp.exec_cmd("hyprctl dispatch resizeactive 0 -50"))
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.exec_cmd("hyprctl dispatch resizeactive 0 50"))

hl.bind("ALT + CTRL + left", hl.dsp.exec_cmd("hyprctl dispatch movewindow l"))
hl.bind("ALT + CTRL + right", hl.dsp.exec_cmd("hyprctl dispatch movewindow r"))
hl.bind("ALT + CTRL + up", hl.dsp.exec_cmd("hyprctl dispatch movewindow u"))
hl.bind("ALT + CTRL + down", hl.dsp.exec_cmd("hyprctl dispatch movewindow d"))

-- Workspaces
hl.bind(mainMod .. " + ALT + right", hl.dsp.exec_cmd("hyprctl dispatch workspace m+1"))
hl.bind(mainMod .. " + ALT + left", hl.dsp.exec_cmd("hyprctl dispatch workspace m-1"))

-- 1. Correct native syntax for special workspaces
hl.bind("CTRL + ALT + SHIFT + S", hl.dsp.window.move({ workspace = "special" }))
hl.bind("CTRL + ALT + S", hl.dsp.workspace.toggle_special("magic"))

for i = 1, 9 do
    local key = tostring(i)
    hl.bind(mainMod .. " + code:" .. (i + 9), hl.dsp.exec_cmd("hyprctl dispatch workspace " .. key))
    hl.bind(mainMod .. " + SHIFT + code:" .. (i + 9), hl.dsp.exec_cmd("hyprctl dispatch movetoworkspace " .. key))
    hl.bind(mainMod .. " + CTRL + code:" .. (i + 9), hl.dsp.exec_cmd("hyprctl dispatch movetoworkspacesilent " .. key))
end
hl.bind(mainMod .. " + code:19", hl.dsp.exec_cmd("hyprctl dispatch workspace 10"))
hl.bind(mainMod .. " + SHIFT + code:19", hl.dsp.exec_cmd("hyprctl dispatch movetoworkspace 10"))
hl.bind(mainMod .. " + CTRL + code:19", hl.dsp.exec_cmd("hyprctl dispatch movetoworkspacesilent 10"))

hl.bind(mainMod .. " + SHIFT + bracketleft", hl.dsp.exec_cmd("hyprctl dispatch workspace -1"))
hl.bind(mainMod .. " + SHIFT + bracketright", hl.dsp.exec_cmd("hyprctl dispatch workspace +1"))
hl.bind(mainMod .. " + CTRL + bracketleft", hl.dsp.exec_cmd("hyprctl dispatch movetoworkspace -1"))
hl.bind(mainMod .. " + CTRL + bracketright", hl.dsp.exec_cmd("hyprctl dispatch movetoworkspace +1"))

hl.bind(mainMod .. " + CTRL + right", hl.dsp.exec_cmd("hyprctl dispatch workspace e+1"))
hl.bind(mainMod .. " + CTRL + left", hl.dsp.exec_cmd("hyprctl dispatch workspace e-1"))
hl.bind(mainMod .. " + period", hl.dsp.exec_cmd("hyprctl dispatch workspace e+1"))
hl.bind(mainMod .. " + comma", hl.dsp.exec_cmd("hyprctl dispatch workspace e-1"))

-- Special Keys / Media / Screenshots
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(scriptsDir .. "/Volume.sh --inc"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(scriptsDir .. "/Volume.sh --dec"), { locked = true, repeating = true })
hl.bind("ALT + XF86AudioRaiseVolume", hl.dsp.exec_cmd(scriptsDir .. "/Volume.sh --inc-precise"), { locked = true, repeating = true })
hl.bind("ALT + XF86AudioLowerVolume", hl.dsp.exec_cmd(scriptsDir .. "/Volume.sh --dec-precise"), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd(scriptsDir .. "/Volume.sh --toggle-mic"), { locked = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(scriptsDir .. "/Volume.sh --toggle"), { locked = true })
hl.bind("", hl.dsp.exec_cmd("systemctl suspend"), { xf86keysym = "XF86Sleep" })
hl.bind("", hl.dsp.exec_cmd(scriptsDir .. "/AirplaneMode.sh"), { xf86keysym = "XF86Rfkill" })

hl.bind("", hl.dsp.exec_cmd(scriptsDir .. "/MediaCtrl.sh --pause"), { xf86keysym = "XF86AudioPlay" })
hl.bind("", hl.dsp.exec_cmd(scriptsDir .. "/MediaCtrl.sh --pause"), { xf86keysym = "XF86AudioPause" })
hl.bind("", hl.dsp.exec_cmd(scriptsDir .. "/MediaCtrl.sh --nxt"), { xf86keysym = "XF86AudioNext" })
hl.bind("", hl.dsp.exec_cmd(scriptsDir .. "/MediaCtrl.sh --prv"), { xf86keysym = "XF86AudioPrev" })
hl.bind("", hl.dsp.exec_cmd(scriptsDir .. "/MediaCtrl.sh --stop"), { xf86keysym = "XF86AudioStop" })

hl.bind(mainMod .. " + Print", hl.dsp.exec_cmd(scriptsDir .. "/ScreenShot.sh --now"))
hl.bind(mainMod .. " + SHIFT + Print", hl.dsp.exec_cmd(scriptsDir .. "/ScreenShot.sh --area"))
hl.bind(mainMod .. " + CTRL + Print", hl.dsp.exec_cmd(scriptsDir .. "/ScreenShot.sh --in5"))
hl.bind(mainMod .. " + CTRL + SHIFT + Print", hl.dsp.exec_cmd(scriptsDir .. "/ScreenShot.sh --in10"))
hl.bind("ALT + Print", hl.dsp.exec_cmd(scriptsDir .. "/ScreenShot.sh --active"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd(scriptsDir .. "/ScreenShot.sh --swappy"))
