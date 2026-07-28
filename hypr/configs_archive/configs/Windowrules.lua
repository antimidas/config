-- /* ---- 💫 https://github.com/JaKooLit 💫 ---- */ --
-- Vendor defaults for window rules and layerrules
-- See https://wiki.hyprland.org/Configuring/Window-Rules/ for more

-- NOTES: This is only for Hyprland >= 0.53

local M = {}

-- Some samples on how to start apps on specific workspaces (all disabled by default)
M.workspace_samples = {
	-- { match = "match:tag email*", action = "workspace 1" },
	-- { match = "match:tag browser*", action = "workspace 2" },
	-- { match = "match:tag projects*", action = "workspace 3" },
	-- { match = "match:tag screenshare*", action = "workspace 4 silent" },
	-- { match = "match:tag gamestore*", action = "workspace 5" },
	-- { match = "match:class ^(virt-manager)$", action = "workspace 6 silent" },
	-- { match = "match:class ^(.virt-manager-wrapped)$", action = "workspace 6 silent" },
	-- { match = "match:tag im*", action = "workspace 7" },
	-- { match = "match:class obsidian", action = "workspace 8" },
	-- { match = "match:tag games*", action = "workspace 8" },
	-- { match = "match:tag multimedia*", action = "workspace 9 silent" },
}

-- Each windowrule entry mirrors: windowrule = <match>, <action>
-- match  = the match:... clause(s), exactly as written (may contain multiple match: clauses)
-- action = the remaining comma-joined actions/args, exactly as written
-- comment = trailing "# ..." comment, if any
M.windowrules = {

	-- TAGS - add apps under appropriate tag to use the same settings
	-- browser tags
	{ match = "match:class ^([Ff]irefox|org.mozilla.firefox|[Ff]irefox-esr|[Ff]irefox-bin)$", action = "tag +browser" },
	{ match = "match:class ^([Gg]oogle-chrome(-beta|-dev|-unstable)?)$", action = "tag +browser" },
	{ match = "match:class ^(chrome-.+-Default)$", action = "tag +browser" },
	{ match = "match:class ^([Cc]hromium)$", action = "tag +browser" },
	{ match = "match:class ^([Mm]icrosoft-edge(-stable|-beta|-dev|-unstable))$", action = "tag +browser" },
	{ match = "match:class ^(Brave-browser(-beta|-dev|-unstable)?)$", action = "tag +browser" },
	{ match = "match:class ^([Tt]horium-browser|[Cc]achy-browser)$", action = "tag +browser" },
	{ match = "match:class ^(zen-alpha|zen)$", action = "tag +browser" },

	-- notif tags
	{ match = "match:class ^(swaync-control-center|swaync-notification-window|swaync-client|class)$", action = "tag +notif" },

	-- KooL settings tag
	{ match = "match:title ^(KooL Quick Cheat Sheet)$", action = "tag +KooL_Cheat" },
	{ match = "match:title ^(KooL Hyprland Settings)$", action = "tag +KooL_Settings" },
	{ match = "match:class ^(nwg-displays|nwg-look)$", action = "tag +KooL-Settings" },

	-- terminal tags
	{ match = "match:class ^(Alacritty|kitty|kitty-dropterm)$", action = "tag +terminal" },

	-- email tags
	{ match = "match:class ^([Tt]hunderbird|org.mozilla.Thunderbird)$", action = "tag +email" },
	{ match = "match:class ^(eu.betterbird.Betterbird)$", action = "tag +email" },
	{ match = "match:class ^(org.gnome.Evolution)$", action = "tag +email" },

	-- project tags
	{ match = "match:class ^(codium|codium-url-handler|VSCodium)$", action = "tag +projects" },
	{ match = "match:class ^(VSCode|code|code-url-handler)$", action = "tag +projects" },
	{ match = "match:class ^(jetbrains-.+)$", action = "tag +projects" },
	{ match = "match:class ^(dev.zed.Zed|antigravity)$", action = "tag +projects" },

	-- screenshare tags
	{ match = "match:class ^(com.obsproject.Studio)$", action = "tag +screenshare" },

	-- IM tags
	{ match = "match:class ^([Dd]iscord|[Ww]ebCord|[Vv]esktop)$", action = "tag +im" },
	{ match = "match:class ^([Ff]erdium)$", action = "tag +im" },
	{ match = "match:class ^([Ww]hatsapp-for-linux)$", action = "tag +im" },
	{ match = "match:class ^(org.telegram.desktop|io.github.tdesktop_x64.TDesktop)$", action = "tag +im" },
	{ match = "match:class ^(teams-for-linux)$", action = "tag +im" },
	{ match = "match:class ^(im.riot.Riot|Element)$", action = "tag +im" },

	-- game tags
	{ match = "match:class ^(gamescope)$", action = "tag +games" },
	{ match = [[match:class ^(steam_app_\d+)$]], action = "tag +games" },

	-- gamestore tags
	{ match = "match:class ^([Ss]team)$", action = "tag +gamestore" },
	{ match = "match:title ^([Ll]utris)$", action = "tag +gamestore" },
	{ match = "match:class ^(com.heroicgameslauncher.hgl)$", action = "tag +gamestore" },

	-- file-manager tags
	{ match = "match:class ^([Tt]hunar|org.gnome.Nautilus|[Pp]cmanfm-qt)$", action = "tag +file-manager" },
	{ match = "match:class ^(app.drey.Warp)$", action = "tag +file-manager" },

	-- wallpaper tags
	{ match = "match:class ^([Ww]aytrogen)$", action = "tag +wallpaper" },

	-- multimedia tags
	{ match = "match:class ^([Aa]udacious)$", action = "tag +multimedia" },

	-- multimedia-video tags
	{ match = "match:class ^([Mm]pv|vlc)$", action = "tag +multimedia_video" },

	-- settings tags
	{ match = "match:title ^(ROG Control)$", action = "tag +settings" },
	{ match = "match:class ^(wihotspot(-gui)?)$", action = "tag +settings" },
	{ match = "match:class ^([Bb]aobab|org.gnome.[Bb]aobab)$", action = "tag +settings" },
	{ match = "match:class ^(gnome-disks|wihotspot(-gui)?)$", action = "tag +settings" },
	{ match = "match:title (Kvantum Manager)", action = "tag +settings" },
	{ match = "match:class ^(file-roller|org.gnome.FileRoller)$", action = "tag +settings" },
	{ match = "match:class ^(nm-applet|nm-connection-editor|blueman-manager)$", action = "tag +settings" },
	{ match = "match:class ^(pavucontrol|org.pulseaudio.pavucontrol|com.saivert.pwvucontrol)$", action = "tag +settings" },
	{ match = "match:class ^(qt5ct|qt6ct)$", action = "tag +settings" },
	{ match = "match:class (xdg-desktop-portal-gtk)", action = "tag +settings" },
	{ match = "match:class ^(org.kde.polkit-kde-authentication-agent-1)$", action = "tag +settings" },
	{ match = "match:class ^([Rr]ofi)$", action = "tag +settings" },
	{ match = "match:class ^(btrfs-assistant)$", action = "tag +settings" },
	{ match = "match:class ^(timeshift-gtk)$", action = "tag +settings" },

	-- viewer tags
	{ match = "match:class ^(gnome-system-monitor|org.gnome.SystemMonitor|io.missioncenter.MissionCenter)$", action = "tag +viewer" },
	{ match = "match:class ^(evince)$", action = "tag +viewer" },
	{ match = "match:class ^(eog|org.gnome.Loupe)$", action = "tag +viewer" },

	-- Some special override rules
	{ match = "match:tag multimedia_video", action = "no_blur on" },
	{ match = "match:tag multimedia_video", action = "opacity 1.0" },
	{ match = "match:tag multimedia", action = "no_blur on" },
	{ match = "match:tag multimedia", action = "opacity 1.0" },

	-- POSITION
	{ match = "match:tag KooL_Cheat", action = "center on" },
	{ match = "match:tag KooL-Settings", action = "center on" },
	{ match = "match:title ^(ROG Control)$", action = "center on" },
	{ match = "match:title ^(Keybindings)$", action = "center on" },
	{ match = "match:class ^(pavucontrol|org.pulseaudio.pavucontrol|com.saivert.pwvucontrol)$", action = "center on" },
	{ match = "match:class ^([Ff]erdium)$", action = "center on" },

	-- windowrule to avoid idle for fullscreen apps
	{ match = "match:fullscreen true", action = "idle_inhibit fullscreen" },
	{ match = "idle_inhibit fullscreen", action = "match:fullscreen 1" },
	{ match = "idle_inhibit fullscreen", action = "match:class ^(*)$" },
	{ match = "idle_inhibit fullscreen", action = "match:title ^(*)$" },

	-- FLOAT
	{ match = "match:tag KooL_Cheat", action = "float on" },
	{ match = "match:tag wallpaper", action = "float on, center on" },
	{ match = "match:tag settings", action = "float on, center on" },
	{ match = "match:tag viewer", action = "float on, center on" },
	{ match = "match:tag KooL-Settings", action = "float on, center on" },
	{ match = "match:class ([Zz]oom|onedriver|onedriver-launcher)", action = "float on" },
	{ match = "match:class (org.gnome.Calculator|qalculate-gtk)", action = "float on" },
	{ match = "match:class ^(mpv|com.github.rafostar.Clapper)$", action = "float on" },
	{ match = "match:class ^([Qq]alculate-gtk)$", action = "float on" },
	{ match = "match:class ^([Ff]erdium)$", action = "float on" },

	-- popups and dialogue
	{ match = "match:title ^(Authentication Required)$", action = "float on, center on" },
	{ match = "match:class (codium|codium-url-handler|VSCodium) match:title negative:(.*codium.*|.*VSCodium.*)", action = "float on" },
	{ match = "match:class ^(com.heroicgameslauncher.hgl)$ match:title negative:(Heroic Games Launcher)", action = "float on" },
	{ match = "match:class ^([Ss]team)$ match:title negative:^([Ss]team)$", action = "float on" },
	{ match = "match:title ^(Add Folder to Workspace)$", action = "float on, size (monitor_w*0.7) (monitor_h*0.6), center on" },
	{ match = "match:title ^(Save As)$", action = "float on, size (monitor_w*0.7) (monitor_h*0.6), center on" },
	{ match = "match:initial_title (Open Files)", action = "float on, size (monitor_w*0.7) (monitor_h*0.6)" },
	{ match = "match:title ^(SDDM Background)$", action = "float on, center on, size (monitor_w*0.16) (monitor_h*0.12)" },
	{ match = "match:class ^(yad)$", action = "float on, center on, size (monitor_w*0.2) (monitor_h*0.2)" },
	{ match = "match:class ^(hyprland-donate-screen)$", action = "float on, center on" },

	-- OPACITY
	{ match = "match:tag browser", action = "opacity 0.99 0.8" },
	{ match = "match:tag projects", action = "opacity 0.9 0.8" },
	{ match = "match:tag im", action = "opacity 0.94 0.86" },
	{ match = "match:tag multimedia", action = "opacity 0.94 0.86" },
	{ match = "match:tag file-manager", action = "opacity 0.9 0.8" },
	{ match = "match:tag terminal", action = "opacity 0.9 0.7" },
	{ match = "match:tag settings", action = "opacity 0.8 0.7" },
	{ match = "match:tag viewer", action = "opacity 0.82 0.75" },
	{ match = "match:tag wallpaper", action = "opacity 0.9 0.7" },
	{ match = "match:class ^(gedit|org.gnome.TextEditor|mousepad)$", action = "opacity 0.8 0.7" },
	{ match = "match:class ^(deluge)$", action = "opacity 0.9 0.8" },
	{ match = "match:class ^(seahorse)$", action = "opacity 0.9 0.8" },
	{ match = "match:title ^(Picture-in-Picture)$", action = "opacity 0.95 0.75" },

	-- SIZE
	{ match = "match:tag KooL_Cheat", action = "size (monitor_w*0.65) (monitor_h*0.9)" },
	{ match = "match:tag wallpaper", action = "size (monitor_w*0.7) (monitor_h*0.7)" },
	{ match = "match:tag settings", action = "size (monitor_w*0.7) (monitor_h*0.7)" },
	{ match = "match:class ^([Ff]erdium)$", action = "size (monitor_w*0.6) (monitor_h*0.7)" },

	-- BLUR & FULLSCREEN
	{ match = "match:tag games", action = "no_blur on, fullscreen 0" },
	{ match = "match:tag games", action = "fullscreen 0" },

	-- This not gonna take the focus to the window that appears when
	-- hovering over some of the parts of the IntelliJ Products
	{ match = "match:class ^(jetbrains-*)", action = "no_initial_focus on" },
	{ match = "match:title ^(wind.*)$", action = "no_initial_focus on" },
}

-- LAYER RULES
-- layerrule = <match>, <action>
M.layerrules = {
	{ match = "match:namespace rofi", action = "blur on" },
	{ match = "match:namespace notifications", action = "blur on" },
	{ match = "match:namespace quickshell:overview", action = "blur on" },
	{ match = "match:namespace quickshell:overview", action = "ignore_alpha 0.5" },
}

-- Named rules for special cases
-- (these map 1:1 to the `windowrule { name = ...; match:...= ...; property = value; }` blocks)
M.named_windowrules = {
	{
		name = "Whatsapp-zapzap",
		["match:class"] = "^([Ww]hatsapp-for-linux|ZapZap|com.rtosta.zapzap)$",
		size = "(monitor_w*0.6) (monitor_h*0.7)",
		center = "on",
	},
	{
		name = "Picture-in-Picture",
		["match:title"] = "^(Picture-in-Picture)$",
		float = "on",
		move = "72% 7%",
		opacity = "0.95 0.75",
		pin = "on",
		keep_aspect_ratio = "on",
		size = "(monitor_w*0.3) (monitor_h*0.3)",
	},
	-- Thunar copy progress dialog
	{
		name = "Thunar-Progress-bar",
		["match:class"] = "^(thunar)$",
		["match:title"] = "^(File Operation Progress)$",
		float = "on",
		center = "on",
		size = "(monitor_w*0.26) (monitor_h*0.18)",
	},
}

return M