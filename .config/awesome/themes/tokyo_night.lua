local gears = require('gears')
local defult_theme_path = gears.filesystem.get_themes_dir() .. "default/theme.lua"

local theme = dofile(defult_theme_path)

theme.wallpaper = "~/.local/share/backgrounds/tokyo-night.jpg"

return theme