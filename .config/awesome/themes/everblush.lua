local gears = require('gears')
local naughty = require("naughty")
local xresources = require("beautiful.xresources")
local defult_theme_path = gears.filesystem.get_themes_dir() .. "default/theme.lua"
local dpi = xresources.apply_dpi

local theme = dofile(defult_theme_path)


------------
-- colors --
------------
theme.primary              = "#11171d"
theme.primary_dark         = "#0c1115"

theme.secondary            = "#1d262d"
theme.secondary_bright     = "#1f2931"

theme.foreground           = "#dadada"
theme.foreground_dark      = "#bdc3c2"
theme.foreground_bright    = "#b3b9b8"

theme.red                  = "#e06e6e"
theme.green                = "#8ccf7e"
theme.yellow               = "#e5c76b"
theme.blue                 = "#67b0e8"
theme.magenta              = "#c47fd5"
theme.cyan                 = "#6da4cd"

theme.progress_bar_normal  = theme.blue
theme.progress_bar_off     = theme.red

theme.bg_normal            = theme.primary
theme.bg_focus             = theme.secondary
theme.bg_urgent            = theme.red
theme.bg_minimize          = theme.primary_dark
theme.bg_systray           = theme.bg_normal

theme.fg_normal            = theme.foreground
theme.fg_focus             = theme.foreground_bright
theme.fg_urgent            = theme.foreground_bright
theme.fg_minimize          = theme.foreground

theme.useless_gap          = dpi(4)
-- theme.gap_single_client    = false

theme.border_width         = dpi(2)
theme.border_normal        = theme.foreground_dark
theme.border_focus         = theme.foreground
theme.border_marked        = theme.red

theme.wibar_bg             = theme.bg_normal
theme.wibar_fg             = theme.fg_normal

theme.bg_systray           = theme.secondary
theme.systray_icon_spacing = dpi(12)

theme.tag_non_empty = theme.foreground
theme.tag_empty = theme.secondary
theme.tag_ind = theme.secondary_bright
theme.tag_hover = "#ffffff"

theme.volume_color_normal = "#398a4e"
theme.volume_color_high = "#8a395b"
theme.volume_color_muted = "#353d45"


theme.wallpaper = "~/.local/share/backgrounds/everblush.png"

return theme