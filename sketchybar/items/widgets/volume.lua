local icons = require("icons")
local settings = require("settings")


local volume = sbar.add("item", "widgets.volume", {
    position = "right",
    icon = {
        string = icons.volume._100,
    },
    label = {
        string = "??%",
        font = { family = settings.font.numbers },
        width = 0,
    },
})

volume:subscribe("volume_change", function(env)
    local vol = tonumber(env.INFO)
    local icon = icons.volume._0
    if vol > 60 then
        icon = icons.volume._100
    elseif vol > 30 then
        icon = icons.volume._66
    elseif vol > 10 then
        icon = icons.volume._33
    elseif vol > 0 then
        icon = icons.volume._10
    end

    local lead = ""
    if vol < 10 then
        lead = "0"
    end

    volume:set({
        icon = { string = icon },
        label = { string = lead .. vol .. "%" },
    })
end)

volume:subscribe("mouse.entered", function()
    sbar.animate("tanh", 30, function()
        volume:set({
            label = { width = "dynamic" },
        })
    end)
end)

volume:subscribe("mouse.exited", function()
    sbar.animate("tanh", 30, function()
        volume:set({
            label = { width = 0 },
        })
    end)
end)
