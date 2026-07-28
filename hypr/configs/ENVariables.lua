-- /* ---- 💫 https://github.com/JaKooLit 💫 ---- */ --
-- Environment variables. See https://wiki.hyprland.org/Configuring/Environment-variables/

-- Set your defaults editor through ENV in ~/.config/hypr/UserConfigs/01-UserDefaults.conf

-- This is the USER overrides file: every entry below is disabled by default,
-- exactly as in the source .conf. Set enabled = true (or add new entries)
-- to override the vendor defaults in ~/.config/hypr/configs/ENVariables.conf

local env = {}

--- QT Variables ---
env[#env + 1] = { key = "QT_AUTO_SCREEN_SCALE_FACTOR", value = "1", enabled = false }
env[#env + 1] = { key = "QT_WAYLAND_DISABLE_WINDOWDECORATION", value = "1", enabled = false }
env[#env + 1] = { key = "QT_QPA_PLATFORMTHEME", value = "qt5ct", enabled = false }
env[#env + 1] = { key = "QT_QPA_PLATFORMTHEME", value = "qt6ct", enabled = false }

--- xwayland apps scale fix (useful if you are use monitor scaling). ---
-- Set same value if you use scaling in Monitors.conf
-- 1 is 100% 1.5 is 150%
-- see https://wiki.hyprland.org/Configuring/XWayland/
env[#env + 1] = { key = "GDK_SCALE", value = "1", enabled = false }
env[#env + 1] = { key = "QT_SCALE_FACTOR", value = "1", enabled = false }

--- NVIDIA ---
-- This is from Hyprland Wiki. Below will be activated nvidia gpu detected
-- See hyprland wiki https://wiki.hyprland.org/Nvidia/#environment-variables

env[#env + 1] = { key = "LIBVA_DRIVER_NAME", value = "nvidia", enabled = false }
env[#env + 1] = { key = "__GLX_VENDOR_LIBRARY_NAME", value = "nvidia", enabled = false }
env[#env + 1] = { key = "NVD_BACKEND", value = "direct", enabled = false }
env[#env + 1] = { key = "GSK_RENDERER", value = "ngl", enabled = false }

--- additional ENV's for nvidia. Caution, activate with care ---
env[#env + 1] = { key = "GBM_BACKEND", value = "nvidia-drm", enabled = false }
env[#env + 1] = { key = "__GL_GSYNC_ALLOWED", value = "1", enabled = false, comment = "adaptive Vsync" }
env[#env + 1] = { key = "__NV_PRIME_RENDER_OFFLOAD", value = "1", enabled = false }
env[#env + 1] = { key = "__VK_LAYER_NV_optimus", value = "NVIDIA_only", enabled = false }
env[#env + 1] = { key = "WLR_DRM_NO_ATOMIC", value = "1", enabled = false }

--- FOR VM and POSSIBLY NVIDIA ---
-- LIBGL_ALWAYS_SOFTWARE software mesa rendering
env[#env + 1] = { key = "LIBGL_ALWAYS_SOFTWARE", value = "1", enabled = false, comment = "Warning. May cause hyprland to crash" }
env[#env + 1] = { key = "WLR_RENDERER_ALLOW_SOFTWARE", value = "1", enabled = false }

--- nvidia firefox ---
-- check this post https://github.com/elFarto/nvidia-vaapi-driver#configuration
env[#env + 1] = { key = "MOZ_DISABLE_RDD_SANDBOX", value = "1", enabled = false }
env[#env + 1] = { key = "EGL_PLATFORM", value = "wayland", enabled = false }

--- Aquamarine Environment Variables (Hyprland > 0.45) ---
-- https://wiki.hyprland.org/Configuring/Environment-variables/#aquamarine-environment-variables
env[#env + 1] = { key = "AQ_TRACE", value = "1", enabled = false, comment = "Enables more verbose logging." }
env[#env + 1] = { key = "AQ_DRM_DEVICES", value = "/dev/dri/card1:/dev/dri/card0", enabled = false,
	comment = "Set an explicit list of DRM devices (GPUs) to use. It's a colon-separated list of paths, with the first being the primary. E.g. /dev/dri/card1:/dev/dri/card0" }
env[#env + 1] = { key = "AQ_MGPU_NO_EXPLICIT", value = "1", enabled = false, comment = "Disables explicit syncing on mgpu buffers" }
env[#env + 1] = { key = "AQ_NO_MODIFIERS", value = "1", enabled = false, comment = "Disables modifiers for DRM buffers" }

return env