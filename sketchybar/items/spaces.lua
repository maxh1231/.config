local colors = require("colors")
local icons = require("icons")
local settings = require("settings")
local app_icons = require("helpers.app_icons")

local function parse_string_to_table(s)
    local result = {}
    for line in s:gmatch("([^\n]+)") do
        table.insert(result, line)
    end
    return result
end

local file = io.popen("aerospace list-workspaces --all")
local result = file:read("*a")
file:close()
local workspaces = parse_string_to_table(result)

for _, i in ipairs(workspaces) do
    local space = sbar.add("item", "space." .. i, {
        icon = {
            font = { family = settings.font.numbers },
            string = i,
            padding_left = 15,
            padding_right = 8,
            color = colors.white,
            highlight_color = colors.red,
        },
        label = {
            padding_right = 1,
            color = colors.grey,
            highlight_color = colors.white,
            font = "SF Pro:Regular:16.0",
            y_offset = -1,
        },
        padding_right = 1,
        padding_left = 1,
        background = {
            color = colors.bg1,
            border_width = 1,
            height = 26,
            border_color = colors.black,
        },
    })

    -- Single item bracket for space items to achieve double border on highlight
    sbar.add("bracket", { space.name }, {
        background = {
            color = colors.transparent,
            border_color = colors.bg2,
            height = 28,
            border_width = 2
        }
    })

    -- Padding space
    sbar.add("item", "space.padding." .. i, {
        script = "",
        width = settings.group_paddings,
    })


    space:subscribe("aerospace_workspace_change", function(env)
        local selected = env.FOCUSED_WORKSPACE == i
        space:set({
            icon = { highlight = selected, },
            label = { highlight = selected },
            background = { border_color = selected and colors.white or colors.bg2 }
        })
    end)

    space:subscribe("mouse.exited", function(_)
        space:set({ popup = { drawing = false } })
    end)
end

local spaces_indicator = sbar.add("item", "spaces_indicator", {
    icon = {
        padding_left = 8,
        color = colors.grey,
        string = icons.switch.on,
    },
    label = {
        width = 0,
        padding_left = 4,
        padding_right = 8,
        string = "Spaces",
        color = colors.bg1,
    },
    background = {
        color = colors.with_alpha(colors.grey, 0.0),
        border_color = colors.with_alpha(colors.dark, 0.0),
    }
})


spaces_indicator:subscribe("swap_menus_and_spaces", function(_)
    local currently_on = spaces_indicator:query().icon.value == icons.switch.on
    spaces_indicator:set({
        icon = currently_on and icons.switch.off or icons.switch.on
    })
end)

spaces_indicator:subscribe("mouse.entered", function(_)
    sbar.animate("tanh", 30, function()
        spaces_indicator:set({
            background = {
                color = { alpha = 1.0 },
                border_color = { alpha = 1.0 },
            },
            icon = { color = colors.bg1 },
            label = { width = "dynamic" }
        })
    end)
end)

spaces_indicator:subscribe("mouse.exited", function(_)
    sbar.animate("tanh", 30, function()
        spaces_indicator:set({
            background = {
                color = { alpha = 0.0 },
                border_color = { alpha = 0.0 },
            },
            icon = { color = colors.grey },
            label = { width = 0, }
        })
    end)
end)

spaces_indicator:subscribe("mouse.clicked", function(_)
    sbar.trigger("swap_menus_and_spaces")
end)

sbar.exec("sketchybar --move spaces_indicator after space." .. #workspaces)
sbar.exec("sketchybar --move front_app after spaces_indicator")
