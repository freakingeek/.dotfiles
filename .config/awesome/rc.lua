TERM = os.getenv("TERM") or "alacritty"

-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")

local beautiful = require("beautiful")
local menubar = require("menubar")

local keys = require("modules.keys")

menubar.utils.terminal = TERM -- Some applications may require it

beautiful.init(gears.filesystem.get_configuration_dir() .. "theme/init.lua")

-- Keys
root.keys(keys.globalkeys)

-- root.buttons(gears.table.join(
--     awful.button({ }, 3, function () mymainmenu:toggle() end),
--     awful.button({}, 4, awful.tag.viewnext),
--     awful.button({}, 5, awful.tag.viewprev)
-- ))

-- Configs
require("modules.error")
require("modules.rules")
require("modules.screen")
require("modules.signals")
require("modules.layouts")

-- Auto Starts
awful.spawn.with_shell("~/.config/awesome/autostart")
