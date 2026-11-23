local mainMod = "SUPER"
local term = "kitty"

local layouts = { "dwindle", "scrolling", "master", "monocle" }

hl.bind("ALT + F4", hl.dsp.window.kill())
hl.bind("ALT + TAB", function()
    local currentLayout = hl.get_config("general.layout")

    hl.dispatch(hl.dsp.window.cycle_next({
        tiled = currentLayout == "monocle"
    }))
end
)
hl.bind("ALT + SHIFT + TAB", function()
    local currentLayout = hl.get_config("general.layout")

    if currentLayout == "monocle" then
        hl.dispatch(hl.dsp.layout("cycleprev"))
        return
    end

    hl.dispatch(hl.dsp.window.cycle_next({
        next = false,
    }))
end)
hl.bind(mainMod .. " + Q", hl.dsp.window.close())

-- Layout bindings

for i, layout in ipairs(layouts) do
    hl.bind(mainMod .. " + " .. i, function()
        hl.config({ general = { layout = layout } })
    end
    )
end

hl.bind(mainMod .. " + SHIFT + O", hl.dsp.window.fullscreen({ action = "toggle", mode = "maximized" }))
hl.bind(mainMod .. " + F", hl.dsp.window.float())

hl.bind(mainMod .. " + R", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.layout("togglesplit"))

hl.bind(mainMod .. " + SHIFT + A", hl.dsp.window.toggle_swallow())

-- Workspace bindings
for i = 1, 10, 1 do
    hl.bind(mainMod .. " + F" .. i, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + F" .. i, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + TAB", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + SHIFT + TAB", hl.dsp.focus({ workspace = "e-1" }))

hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Mouse bindings
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Window bindings

hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.swap({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.swap({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + up", hl.dsp.window.swap({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.window.swap({ direction = "down" }))

hl.bind(mainMod .. " + CTRL + left", hl.dsp.window.resize({ x = -20, y = 0, relative = true }))
hl.bind(mainMod .. " + CTRL + right", hl.dsp.window.resize({ x = 20, y = 0, relative = true }))
hl.bind(mainMod .. " + CTRL + up", hl.dsp.window.resize({ x = 0, y = -20, relative = true }))
hl.bind(mainMod .. " + CTRL + down", hl.dsp.window.resize({ x = 0, y = 20, relative = true }))

hl.bind(mainMod .. " + CTRL + SHIFT + left", hl.dsp.window.move({ x = -20, y = 0, relative = true }))
hl.bind(mainMod .. " + CTRL + SHIFT + right", hl.dsp.window.move({ x = 20, y = 0, relative = true }))
hl.bind(mainMod .. " + CTRL + SHIFT + up", hl.dsp.window.move({ x = 0, y = -20, relative = true }))
hl.bind(mainMod .. " + CTRL + SHIFT + down", hl.dsp.window.move({ x = 0, y = 20, relative = true }))


-- Application bindings
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(term))
