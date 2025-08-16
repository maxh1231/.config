local colors = require("colors")
local icons = require("icons")

sbar.add("item", {
    icon = {
        font = { size = 16.0 },
        string = icons.apple,
        padding_right = 10,
        padding_left = 10,
        color = colors.fg
    },
    label = { drawing = false },
    background = {
        drawing = true,
        color = colors.bg,
        border_color = colors.border,
        border_width = 2
    },
    padding_left = 1,
    padding_right = 1,
    click_script = "$CONFIG_DIR/helpers/menus/bin/menus -s 0"
})
