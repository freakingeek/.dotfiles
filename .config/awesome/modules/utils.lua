local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")

local utils = {}

function utils.set_wallpaper(s)
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper

        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end

        gears.wallpaper.maximized(wallpaper, s, true)
    end
end


function utils.toggle_language()
    awful.spawn.with_shell(
        "setxkbmap -query | grep -q 'layout:\\s\\+us' && setxkbmap ir || setxkbmap us"
    )
end

return utils
