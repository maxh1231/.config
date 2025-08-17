local settings = require("settings")

local cal = sbar.add("item", {
    icon = {
        font = {
            style = settings.font.style_map["Black"],
            size = 12.0,
        },
    },
    label = {
        width = 49,
        align = "right",
        font = { family = settings.font.numbers },
    },
    position = "right",
    update_freq = 30,
    click_script = "open -a 'Calendar'"
})

cal:subscribe({ "forced", "routine", "system_woke" }, function(_)
    cal:set({ icon = os.date("%a. %d %b."), label = os.date("%H:%M") })
end)
