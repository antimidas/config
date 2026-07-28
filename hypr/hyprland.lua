local HOME = os.getenv("HOME")

-- Basic window and layout settings to fix square/ugly windows
hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 10,
        border_size = 2,
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
    leaf = "workspaces",
    enabled = true,
    speed = 5,
    bezier = "default",
    style = "slidevert"
})

-- Startup apps and daemons
hl.on("hyprland.start", function()
    hl.exec_cmd("waybar")
    hl.exec_cmd("swww-daemon") -- Change this to your wallpaper daemon if different
    hl.exec_cmd(HOME .. "/.config/hypr/initial-boot.sh")
    hl.exec_once("pypr")
end)

-- Essential manual keybinds to verify bindings work nativelyhl.bind("SUPER + Return", hl.dsp.exec_cmd("kitty"))
hl.bind("SUPER + E", hl.dsp.exec_cmd("thunar"))
hl.bind("SUPER + Q", hl.dsp.window.close())

-- Safely load modular files if they exist, catching errors so they don't kill the session
local function safe_require(name)
    local ok, err = pcall(require, name)
    if not ok then
        io.stderr:write("Skipping broken module " .. name .. ": " .. tostring(err) .. "\n")
    end
end

-- Load your configs safely
safe_require("configs.Keybinds")
safe_require("UserConfigs.UserKeybinds")
