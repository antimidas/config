local M = {}

function M.load_env(t)
    for _, e in ipairs(t) do
        if e.enabled ~= false and e.key and e.value then 
            hl.config({ env = { [e.key] = e.value } })
        end
    end
end

function M.load_exec(t)
    if not t.exec_once then return end
    hl.on("hyprland.start", function()
        for _, e in ipairs(t.exec_once) do
            if type(e) == "string" then
                hl.exec_cmd(e)
            elseif e.enabled ~= false and e.cmd then 
                hl.exec_cmd(e.cmd) 
            end
        end
    end)
end

function M.load_binds(t)
    if not t.binds then return end
    for _, b in ipairs(t.binds) do
        if b.enabled ~= false and b.key and b.dispatcher then 
            -- Clean up modifier formatting for native Lua API
            local mods = b.mods or ""
            mods = mods:gsub("%$mainMod", "SUPER")
            
            local combo = (mods ~= "") and (mods .. " + " .. b.key) or b.key
            
            if b.dispatcher == "exec" then
                hl.bind(combo, hl.dsp.exec_cmd(b.args or ""))
            elseif b.dispatcher == "submap" then
                hl.bind(combo, hl.dsp.submap(b.args or ""))
            end
        end
    end
end

function M.load_windowrules(t)
    -- Handled natively or left blank to prevent syntax errors
end

function M.load_animations(t)
    if not t.animations then return end
    hl.config({
        animations = {
            enabled = t.animations.enabled
        }
    })
end

function M.load_settings(t)
    local cfg = {}
    if t.general then 
        cfg.general = {
            border_size = t.general.border_size,
            gaps_in = t.general.gaps_in,
            gaps_out = t.general.gaps_out,
        }
    end
    if t.decoration then 
        cfg.decoration = {
            rounding = t.decoration.rounding,
            active_opacity = t.decoration.active_opacity,
            inactive_opacity = t.decoration.inactive_opacity,
        }
    end
    if next(cfg) then hl.config(cfg) end
end

return M