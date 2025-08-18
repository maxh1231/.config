local icons = require("icons")
local colors = require("colors")
local settings = require("settings")
local app_icons = require("helpers.icon_map")

local max_workspaces = 9
local focused_workspace_index = nil
local is_show_windows = true

-- Create a toggle button that control the visibility for workspace labels
local toggle_windows = sbar.add("item", {
    icon = {
        string = icons.aerospace,
        padding_right = 12,
        padding_left = 10,
    },
    label = { width = 0, y_offset = 0.5, padding_right = 15 },
    background = {
        color = colors.bg,
        border_color = colors.border,
        border_width = 2
    },
})

-- Hover animations provide visual feedback for interactive elements
toggle_windows:subscribe("mouse.entered", function()
    sbar.animate("tanh", 10, function()
        toggle_windows:set({
            label = { string = is_show_windows and icons.chevron.left or icons.chevron.right, width = "dynamic" },
            background = {
                color = colors.bg,
            },
        })
    end)
end)

toggle_windows:subscribe("mouse.exited", function()
    sbar.animate("tanh", 10, function()
        toggle_windows:set({
            label = { width = 0 },
            background = {
                color = colors.bg
            },
        })
    end)
end)

toggle_windows:subscribe("aerospace_mode_change", function(ENV)
    local mode = ENV.MODE
    sbar.animate("tanh", 10, function()
        if mode ~= "main" then
            toggle_windows:set({
                icon = {
                    color = colors.yellow,
                },
            })
        else
            toggle_windows:set({
                icon = {
                    color = colors.fg,
                },
                background = {
                    color = colors.bg,
                    border_width = 2,
                },
            })
        end
    end)
end)

local workspaces = {}

-- Updates workspace UI to reflect current window state
-- Shows window icons when apps are open and hides them when empty,
-- except for the focused workspace which shows a placeholder
local function updateWindows(workspace_index)
    local get_windows =
        string.format("aerospace list-windows --workspace %s --format '%%{app-name}' --json", workspace_index)
    sbar.exec(get_windows, function(open_windows)
        local icon_line = ""
        local no_app = true
        for _, open_window in ipairs(open_windows) do
            no_app = false
            local app = open_window["app-name"]
            -- Fallback to default icon if app-specific icon isn't found
            local lookup = app_icons[app]
            local icon = ((lookup == nil) and app_icons["default"] or lookup)
            icon_line = icon_line .. " " .. icon
        end
        sbar.animate("tanh", 10, function()
            if no_app then
                if workspace_index == focused_workspace_index then
                    -- Show placeholder for empty focused workspace
                    icon_line = " —"
                    workspaces[workspace_index]:set({
                        icon = { drawing = true },
                        label = { drawing = true, string = icon_line },
                        background = { drawing = true },
                        -- padding_right = 1,
                        padding_left = 2,
                    })
                    return
                end

                -- Hide empty unfocused workspaces
                workspaces[workspace_index]:set({
                    icon = { drawing = false },
                    label = { drawing = false },
                    background = { drawing = false },
                    padding_right = 0,
                    padding_left = 0,
                })
                return
            end

            workspaces[workspace_index]:set({
                icon = { drawing = true },
                label = { drawing = true, string = icon_line },
                background = { drawing = true },
                padding_right = 1,
                padding_left = 2,
            })
        end)
    end)
end

for workspace_index = 1, max_workspaces do
    local workspace = sbar.add("item", {
        icon = {
            font = { family = settings.font.numbers },
            color = colors.fg_secondary,
            string = workspace_index,
            padding_left = 14,
            padding_right = 4,
        },
        label = {
            padding_right = 20,
            color = colors.fg_secondary,
            highlight_color = colors.fg,
            font = "sketchybar-app-font:Regular:16.0",
            y_offset = -1,
        },
        padding_right = 1,
        padding_left = 2,
        background = {
            border_color = colors.border,
            border_width = 2
        },
    })

    workspaces[workspace_index] = workspace

    -- Updates highlight of focused workspace when workspace changes
    workspace:subscribe("aerospace_workspace_change", function(env)
        focused_workspace_index = tonumber(env.FOCUSED_WORKSPACE)
        local is_focused = focused_workspace_index == workspace_index

        sbar.animate("tanh", 10, function()
            workspace:set({
                icon = {
                    highlight = is_focused,
                    highlight_color = colors.fg
                },
                label = { highlight = is_focused, highlight_color = colors.fg },
                background = {
                    border_width = is_focused and 2 or 0,
                    border_color = colors.fg
                },
            })
        end)
    end)

    workspace:subscribe("aerospace_focus_change", function()
        updateWindows(workspace_index)
    end)

    -- Allow workspace switching via click
    workspace:subscribe("mouse.clicked", function()
        local focus_workspace = "aerospace workspace " .. workspace_index
        sbar.exec(focus_workspace)
    end)

    -- Workspace hover effects
    workspace:subscribe("mouse.entered", function()
        sbar.animate("tanh", 10, function()
            workspace:set({
                icon = {
                    highlight = true,
                    highlight_color = colors.fg
                },
                label = { highlight = true, highlight_color = colors.fg },
                background = {
                    border_width = true and 2 or 0,
                    border_color = colors.fg
                },
            })
        end)
    end)

    -- Maintain highlight if this is the focused workspace
    workspace:subscribe("mouse.exited", function()
        if workspace_index == focused_workspace_index then
            return
        end

        sbar.animate("tanh", 10, function()
            workspace:set({
                icon = { highlight = false },
                label = { highlight = false },
                background = { border_width = 0 },
            })
        end)
    end)

    -- Set initial workspace state
    updateWindows(workspace_index)
    sbar.exec("aerospace list-workspaces --focused", function(focused_workspace)
        workspaces[tonumber(focused_workspace)]:set({
            icon = {
                highlight = true,
                highlight_color = colors.fg
            },
            label = { highlight = true, highlight_color = colors.fg },
            background = {
                border_width = true and 2 or 0,
                border_color = colors.fg
            },
        })
    end)
end

-- Toggle visibility of workspace's labels(open windows)
toggle_windows:subscribe("mouse.clicked", function()
    is_show_windows = not is_show_windows
    sbar.animate("tanh", 10, function()
        toggle_windows:set({
            label = {
                string = is_show_windows and icons.chevron.left or icons.chevron.right,
            },
        })
        for _, workspace in ipairs(workspaces) do
            workspace:set({
                icon = { padding_right = is_show_windows and 8 or 15 },
                label = { width = is_show_windows and "dynamic" or 0 },
            })
        end
    end)
end)
