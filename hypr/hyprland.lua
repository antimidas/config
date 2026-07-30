local HOME = os.getenv("HOME")

hl.env("WEBKIT_DISABLE_DMABUF_RENDERER", "1")

hl.curve("linear", {
    type = "bezier",
    points = { {0.0, 0.0}, {1.0, 1.0} }
})

hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 10,
        border_size = 2,
        col = {
            active_border = {
                colors = {
                    "rgba(1e3a8aee)", -- Deep Navy Blue
                    "rgba(3b82f6ee)", -- Bright Blue
                    "rgba(6366f1ee)", -- Indigo
                    "rgba(8b5cf6ee)", -- Vibrant Purple
                    "rgba(d946efee)", -- Magenta / Purple-Pink
                    "rgba(ec4899ee)", -- Hot Pink
                    "rgba(f472b6ee)", -- Soft Light Pink
                },
                angle = 0,
            },
            inactive_border = "rgba(5f07e0aa)",
        },
    },
    decoration = {
        rounding = 10,
    },
    animations = {
        enabled = true,
        animation = {
            { "specialWorkspace", 1, 5, "default", "slidevert" },
        },
    },
})

hl.animation({
    leaf = "borderangle",
    enabled = true,
    speed = 50,
    bezier = "linear",
    style = "loop",
})




-- Startup apps and daemons
hl.on("hyprland.start", function()
    hl.exec_cmd("waybar")
    hl.exec_cmd("swww-daemon") -- Change this to your wallpaper daemon if different
    hl.exec_cmd(HOME .. "/.config/hypr/initial-boot.sh")
    hl.exec_cmd("pypr")
end)

-- Essential manual keybinds to verify bindings work natively
hl.bind("SUPER + Return", hl.dsp.exec_cmd("kitty"))
hl.bind("SUPER + E", hl.dsp.exec_cmd("thunar"))
hl.bind("SUPER + Q", hl.dsp.window.close())

-- Safely load modular files if they exist, catching errors so they don't kill the session
local function safe_require(name)
    local ok, err = pcall(require, name)
    if not ok then
        io.stderr:write("Skipping broken module " .. name .. ": " .. tostring(err) .. "\n")
    end
end

-- Load your configs safely, in the same order the original hyprland.conf sourced them
safe_require("configs.Keybinds")            -- Pre-configured keybinds

-- Load defaults, then user additions/overrides
safe_require("configs.Startup_Apps")
safe_require("UserConfigs.Startup_Apps")

safe_require("configs.ENVariables")         -- Environment variables (defaults)
safe_require("UserConfigs.ENVariables")     -- Environment variables (user)

-- Laptop related
safe_require("configs.Laptops")
safe_require("UserConfigs.Laptops")
safe_require("UserConfigs.LaptopDisplay")

-- Load defaults, then user additions
safe_require("configs.WindowRules")         -- Window Rules and Layer Rules (defaults)
safe_require("UserConfigs.WindowRules")     -- Window Rules and Layer Rules (user)

safe_require("configs.SystemSettings")      -- Default config for hypr
safe_require("UserConfigs.UserDecorations") -- Decorations config file
safe_require("UserConfigs.UserAnimations")  -- Animation config file
safe_require("UserConfigs.UserKeybinds")    -- Put your own keybinds here
safe_require("UserConfigs.UserSettings")    -- Main Hyprland Settings
safe_require("UserConfigs.WorkSpaceRules")  -- (new in your Lua set, wasn't a separate file before)
safe_require("UserConfigs.01-UserDefaults") -- settings for User defaults apps

-- nwg-displays
safe_require("monitors")
safe_require("workspaces")

-- Extra module you have that wasn't in the original conf structure
safe_require("dropdown")

-- Force Pyprland dropdowns to inherit decorations, borders, and animations
-- Force Pyprland scratchpads to take the active border color/gradient
hl.window_rule({
    match = { initial_class = "kitty-dropterm" },
    border_color = {
        colors = {
            "rgba(1e3a8aee)",
            "rgba(3b82f6ee)",
            "rgba(6366f1ee)",
            "rgba(8b5cf6ee)",
            "rgba(d946efee)",
            "rgba(ec4899ee)",
            "rgba(f472b6ee)",
        },
        angle = 0,
    },
})

hl.window_rule({
    match = { initial_class = "kitty-ranger" },
    border_color = {
        colors = {
            "rgba(1e3a8aee)",
            "rgba(3b82f6ee)",
            "rgba(6366f1ee)",
            "rgba(8b5cf6ee)",
            "rgba(d946efee)",
            "rgba(ec4899ee)",
            "rgba(f472b6ee)",
        },
        angle = 0,
    },
})
