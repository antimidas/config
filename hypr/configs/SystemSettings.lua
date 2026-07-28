-- /* ---- 💫 https://github.com/JaKooLit 💫 ---- */ --
-- Default settings
-- This is where you put your own settings as this will not be touched during update
-- if the upgrade.sh is used.

-- refer to Hyprland wiki for more info https://wiki.hyprland.org/Configuring/Variables/
-- NOTE: some settings are in ~/.config/hypr/UserConfigs/UserDecorAnimations.conf

local HOME = os.getenv("HOME")
local scriptsDir = HOME .. "/.config/hypr/scripts"

local M = {}

M.dwindle = {
	-- pseudotile = true, -- (disabled)
	preserve_split = true,
	-- smart_split = true, -- (disabled)
	special_scale_factor = 0.8,
}

M.master = {
	new_status = "master",
	new_on_top = 1,
	mfact = 0.5,
}

M.general = {
	resize_on_border = true,
	layout = "dwindle",
}

M.input = {
	kb_layout = "us",
	kb_variant = "",
	kb_model = "",
	kb_options = "",
	kb_rules = "",
	repeat_rate = 50,
	repeat_delay = 300,

	sensitivity = 0, -- mouse sensitivity
	-- accel_profile = "", -- flat or adaptive or blank or EMPTY means libinput's default mode (disabled)
	numlock_by_default = true,
	left_handed = false,
	follow_mouse = 1,
	float_switch_override_focus = false,

	touchpad = {
		disable_while_typing = true,
		natural_scroll = true,
		clickfinger_behavior = false,
		middle_button_emulation = false,
		["tap-to-click"] = true,
		drag_lock = false,
	},

	-- below for devices with touchdevice ie. touchscreen
	touchdevice = {
		enabled = true,
	},

	-- below is for tablet see link above for proper variables
	tablet = {
		transform = 0,
		left_handed = 0,
	},
}

M.gestures = {
	gesture = { "3, horizontal, workspace" },
	workspace_swipe_distance = 500,
	workspace_swipe_invert = true,
	workspace_swipe_min_speed_to_force = 30,
	workspace_swipe_cancel_ratio = 0.5,
	workspace_swipe_create_new = true,
	workspace_swipe_forever = true,
	-- workspace_swipe_use_r = true, -- uncomment if wanted a forever create a new workspace with swipe right (disabled)
}

-- additional repeatable "gesture" keyword entries (kept separate since the
-- hyprlang `gesture` keyword can repeat; mirror that with a list)
table.insert(M.gestures.gesture,
	[[4, up, dispatcher, exec, hyprctl keyword cursor:zoom_factor "$(hyprctl getoption cursor:zoom_factor | awk 'NR==1 {factor = $2; if (factor < 1) {factor = 1}; print factor * 1.5}')"]])
table.insert(M.gestures.gesture,
	[[4, down, dispatcher, exec, hyprctl keyword cursor:zoom_factor "$(hyprctl getoption cursor:zoom_factor | awk 'NR==1 {factor = $2; if (factor < 1) {factor = 1}; print factor / 1.5}')"]])
table.insert(M.gestures.gesture,
	"3, up, dispatcher, exec, " .. scriptsDir .. "/OverviewToggle.sh")

M.misc = {
	disable_hyprland_logo = true,
	disable_splash_rendering = true,
	-- vfr = true, -- (disabled)
	vrr = 2,
	mouse_move_enables_dpms = true,
	enable_swallow = false, -- "off"
	swallow_regex = "^(kitty)$",
	focus_on_activate = false,
	initial_workspace_tracking = 0,
	middle_click_paste = false,
	enable_anr_dialog = true,   -- Application not Responding (ANR)
	anr_missed_pings = 15,      -- ANR Threshold default 1 is too low
	allow_session_lock_restore = true, -- Prevent lockscreen crash when resume from suspend
	-- This only works with HL v0.53+
	on_focus_under_fullscreen = 1,
	-- 0 - Default, no change
	-- 1 - New focused window takes over fullscreen (Windows-like Alt-Tab)
	-- 2 - New focused window stays behind the fullscreen one
}

-- M.opengl = {
-- 	nvidia_anti_flicker = true,
-- } -- (disabled)

M.binds = {
	workspace_back_and_forth = true,
	allow_workspace_cycles = true,
	pass_mouse_when_bound = false,
}

-- Could help when scaling and not pixelating
M.xwayland = {
	enabled = true,
	force_zero_scaling = true,
}

M.render = {
	direct_scanout = 0,
}

M.cursor = {
	sync_gsettings_theme = true,
	no_hardware_cursors = 1, -- change to 1 if want to disable
	enable_hyprcursor = true,
	warp_on_change_workspace = 2,
	no_warps = true,
}

M["plugin:dynamic-cursors"] = {

	-- enables the plugin
	enabled = true,

	-- sets the cursor behaviour, supports these values:
	-- tilt    - tilt the cursor based on x-velocity
	-- rotate  - rotate the cursor based on movement direction
	-- stretch - stretch the cursor shape based on direction and velocity
	-- none    - do not change the cursor's behaviour
	mode = "tilt",

	-- minimum angle difference in degrees after which the shape is changed
	-- smaller values are smoother, but more expensive for hw cursors
	threshold = 2,

	-- override the mode behaviour per shape
	-- this is a keyword and can be repeated many times
	-- by default, there are no rules added
	-- see the dedicated `shape rules` section below!
	-- shaperule = "<shape-name>, <mode> (optional), <property>: <value>, ...",
	shaperule = {},

	-- for mode = rotate
	rotate = {
		-- length in px of the simulated stick used to rotate the cursor
		-- most realistic if this is your actual cursor size
		length = 20,

		-- clockwise offset applied to the angle in degrees
		-- this will apply to ALL shapes
		offset = 0.0,
	},

	-- for mode = tilt
	tilt = {
		-- controls how powerful the tilt is, the lower, the more power
		-- this value controls at which speed (px/s) the full tilt is reached
		limit = 5000,

		-- relationship between speed and tilt, supports these values:
		-- linear             - a linear function is used
		-- quadratic          - a quadratic function is used (most realistic to actual air drag)
		-- negative_quadratic - negative version of the quadratic one, feels more aggressive
		-- see `activation` in `src/mode/utils.cpp` for how exactly the calculation is done
		activation = "negative_quadratic",

		-- time window (ms) over which the speed is calculated
		-- higher values will make slow motions smoother but more delayed
		window = 100,

		-- full tilt for each side (°)
		full = 60,
	},

	-- for mode = stretch
	stretch = {
		-- controls how much the cursor is stretched
		-- this value controls at which speed (px/s) the full stretch is reached
		-- the full stretch being twice the original length
		limit = 3000,

		-- relationship between speed and stretch amount, supports these values:
		-- linear             - a linear function is used
		-- quadratic          - a quadratic function is used
		-- negative_quadratic - negative version of the quadratic one, feels more aggressive
		-- see `activation` in `src/mode/utils.cpp` for how exactly the calculation is done
		activation = "quadratic",

		-- time window (ms) over which the speed is calculated
		-- higher values will make slow motions smoother but more delayed
		window = 100,
	},

	-- configure shake to find
	-- magnifies the cursor if its is being shaken
	shake = {
		-- enables shake to find
		enabled = true,

		-- controls how soon a shake is detected
		-- lower values mean sooner
		threshold = 6.0,

		-- magnification level immediately after shake start
		base = 4.0,
		-- magnification increase per second when continuing to shake
		speed = 4.0,
		-- how much the speed is influenced by the current shake intensity
		influence = 0.0,

		-- maximal magnification the cursor can reach
		-- values below 1 disable the limit (e.g. 0)
		limit = 0.0,

		-- time in milliseconds the cursor will stay magnified after a shake has ended
		timeout = 2000,

		-- show cursor behaviour `tilt`, `rotate`, etc. while shaking
		effects = false,

		-- enable ipc events for shake
		-- see the `ipc` section below
		ipc = false,
	},

	-- use hyprcursor to get a higher resolution texture when the cursor is magnified
	-- see the `hyprcursor` section below
	hyprcursor = {
		-- use nearest-neighbour (pixelated) scaling when magnifying beyond texture size
		-- this will also have effect without hyprcursor support being enabled
		-- 0 / false - never use pixelated scaling
		-- 1 / true  - use pixelated when no highres image
		-- 2         - always use pixelated scaling
		nearest = true,

		-- enable dedicated hyprcursor support
		enabled = true,

		-- resolution in pixels to load the magnified shapes at
		-- be warned that loading a very high-resolution image will take a long time and might impact memory consumption
		-- -1 means we use [normal cursor size] * [shake:base option]
		resolution = -1,

		-- shape to use when clientside cursors are being magnified
		-- see the shape-name property of shape rules for possible names
		-- specifying clientside will use the actual shape, but will be pixelated
		fallback = "clientside",
	},
}

return M