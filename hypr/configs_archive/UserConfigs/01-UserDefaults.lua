-- /* ---- 💫 https://github.com/JaKooLit 💫 ---- */ --

-- This is a file where you put your own default apps, default search Engine etc

local M = {}

-- Set your default editor here uncomment and reboot to take effect.
-- NOTE, this will be automatically uncommented if you select neovim or vim to your default editor
-- M.env_editor = { key = "EDITOR", value = "vim", enabled = false } -- default editor

-- Define preferred text editor for the KooL Quick Settings Menu (SUPER SHIFT E)
-- script will take the default EDITOR and nano as fallback
local EDITOR = os.getenv("EDITOR")
M.edit = (EDITOR ~= nil and EDITOR ~= "") and EDITOR or "nano"

-- These two are for UserKeybinds.conf & Waybar Modules
M.term = "kitty"   -- Terminal
M.files = "thunar" -- File Manager

-- Default Search Engine for ROFI Search (SUPER S)
M.Search_Engine = "https://www.google.com/search?q={}"

return M
