local M = {}

-- User window rules
M.windowrules = {
    -- Ranger dropdown
    {
        match = "match:initialClass ^(dropdown_ranger)$",
        action = "float on, center on, size 1200 800"
    },
}

-- User layer rules
M.layerrules = {}

-- User named window rules
M.named_windowrules = {}

return M
