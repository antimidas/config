
local M = {}

function M.toggle(addr)
    local active = hl.monitors[1].specialWorkspace.name

    if active == "special:dropdown_ranger" then
        hl.dsp.workspace.toggle_special("dropdown_ranger")
    else
        hl.dsp.workspace.toggle_special("dropdown_ranger")
        if addr and addr ~= "" then
            hl.dsp.window.focus("address:" .. addr)
        end
    end
end

return M
