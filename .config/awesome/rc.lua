-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Modules
local utils = require('modules.utils')
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init(gears.filesystem.get_configuration_dir() .. "themes/tokyo_night.lua")

-- This is used later as the default terminal and editor to run.
terminal = os.getenv("TERMINAL") or "alacritty"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor

modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
    awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
   { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end },
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "open terminal", terminal }
                                  }
                        })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar
-- Create a textclock widget
mytextclock = wibox.widget.textclock()

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
    awful.button({}, 1, function(t) t:view_only() end),
    
    awful.button({ modkey }, 1,
        function(t)
            if client.focus then
                client.focus:move_to_tag(t)
            end
        end
    ),
    
    awful.button({ }, 3, awful.tag.viewtoggle),
    
    awful.button({ modkey }, 3,
        function(t)
            if client.focus then
                client.focus:toggle_tag(t)
            end
        end
    ),
    
    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
    
    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)

local tasklist_buttons = gears.table.join(
    awful.button({}, 1, 
        function (c)
            if c == client.focus then
                c.minimized = true
            else
                c:emit_signal("request::activate", "tasklist", { raise = true })
            end
        end
    ),
    
    awful.button({}, 3, function() awful.menu.client_list({ theme = { width = 250 } }) end),
    
    awful.button({}, 4, function () awful.client.focus.byidx(1) end),
    
    awful.button({}, 5, function () awful.client.focus.byidx(-1) end)
)

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", utils.set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    utils.set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()

    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
            awful.button({ }, 1, function () awful.layout.inc( 1) end),
            awful.button({ }, 3, function () awful.layout.inc(-1) end),
            awful.button({ }, 4, function () awful.layout.inc( 1) end),
            awful.button({ }, 5, function () awful.layout.inc(-1) end)
        )
    )
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons
    }

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            mylauncher,
            s.mytaglist,
            s.mypromptbox,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            mykeyboardlayout,
            wibox.widget.systray(),
            mytextclock,
            s.mylayoutbox,
        },
    }
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = gears.table.join(
    awful.key({ modkey }, "s", hotkeys_popup.show_help, {
        group="awesome",
        description="show help"
    }),
    
    awful.key({ modkey }, "Left", awful.tag.viewprev, {
        group = "tag",
        description = "view previous"
    }),
    
    awful.key({ modkey }, "Right", awful.tag.viewnext, {
        group = "tag",
        description = "view next"
    }),
    
    awful.key({ modkey }, "Escape", awful.tag.history.restore, {
        group = "tag",
        description = "go back"
    }),

    awful.key({ modkey }, "j", function () awful.client.focus.byidx( 1) end, {
        group = "client",
        description = "focus next by index"
    }),
    
    awful.key({ modkey }, "k", function () awful.client.focus.byidx(-1) end, {
        group = "client",
        description = "focus previous by index"
    }),
    
    awful.key({ modkey }, "w", function () mymainmenu:show() end, {
        group = "awesome",
        description = "show main menu"
    }),

    -- Layout manipulation
    awful.key({ modkey, "Shift" }, "j", function () awful.client.swap.byidx(1) end, {
        group = "client",
        description = "swap with next client by index"
    }),
    
    awful.key({ modkey, "Shift" }, "k", function () awful.client.swap.byidx(-1) end, {
        group = "client",
        description = "swap with previous client by index"
    }),
    
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative(1) end, {
        group = "screen",
        description = "focus the next screen"
    }),
    
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end, {
        group = "screen",
        description = "focus the previous screen"
    }),
    
    awful.key({ modkey }, "u", awful.client.urgent.jumpto, {
        group = "client",
        description = "jump to urgent client"
    }),
    
    awful.key({ modkey }, "Tab",
    function ()
        awful.client.focus.history.previous()
        if client.focus then
            client.focus:raise()
        end
    end, {
        group = "client",
        description = "go back"
    }),

    -- Standard program
    awful.key({ modkey, "Shift" }, "Return", function() awful.spawn(terminal) end, {
        group = "launcher",
        description = "open a terminal"
    }),
    
    awful.key({ modkey, "Control" }, "r", awesome.restart, {
        group = "awesome",
        description = "reload awesome"
    }),

    awful.key({ modkey, "Shift" }, "q", awesome.quit, {
        group = "awesome",
        description = "quit awesome"
    }),

    awful.key({ modkey }, "l", function () awful.tag.incmwfact(0.05) end, {
        group = "layout",
        description = "increase master width factor"
    }),
    
    awful.key({ modkey }, "h", function () awful.tag.incmwfact(-0.05) end, {
        group = "layout",
        description = "decrease master width factor"
    }),
    
    awful.key({ modkey, "Shift" }, "h", function () awful.tag.incnmaster( 1, nil, true) end, {
        group = "layout",
        description = "increase the number of master clients"
    }),
    
    awful.key({ modkey, "Shift" }, "l", function () awful.tag.incnmaster(-1, nil, true) end, {
        group = "layout",
        description = "decrease the number of master clients"
    }),
    
    awful.key({ modkey, "Control" }, "h", function () awful.tag.incncol( 1, nil, true) end, {
        group = "layout",
        description = "increase the number of columns"
    }),
    
    awful.key({ modkey, "Control" }, "l", function () awful.tag.incncol(-1, nil, true) end, {
        group = "layout",
        description = "decrease the number of columns"
    }),
    
    awful.key({ modkey }, "space", function () awful.layout.inc( 1) end, {
        group = "layout",
        description = "select next"
    }),
    
    awful.key({ modkey, "Shift" }, "space", function () awful.layout.inc(-1) end, {
        group = "layout",
        description = "select previous"
    }),

    awful.key({ modkey, "Control" }, "n",
    function ()
        local c = awful.client.restore()
        -- Focus restored client
        if c then
        c:emit_signal(
            "request::activate", "key.unminimize", {raise = true}
        )
        end
    end, {
        group = "client",
        description = "restore minimized"
    }),

    -- Prompt
    awful.key({ modkey }, "r", function () awful.screen.focused().mypromptbox:run() end, {
        group = "launcher",
        description = "run prompt"
    }),

    awful.key({ modkey }, "x",
    function ()
        awful.prompt.run {
        prompt       = "Run Lua code: ",
        textbox      = awful.screen.focused().mypromptbox.widget,
        exe_callback = awful.util.eval,
        history_path = awful.util.get_cache_dir() .. "/history_eval"
        }
    end, {
        group = "awesome",
        description = "lua execute prompt"
    }),
    
    -- Menubar
    awful.key({ modkey, "Shift" }, "p", function() menubar.show() end, {
        group = "launcher",
        description = "show the menubar"
    }),
    
    -- XF86 Keys
    awful.key({}, "XF86AudioRaiseVolume",
    function() awful.spawn.with_shell("pactl set-sink-volume @DEFAULT_SINK@ +5%") end, {
        group = "",
        description = ""
    }),

    awful.key({}, "XF86AudioLowerVolume",
    function() awful.spawn.with_shell("pactl set-sink-volume @DEFAULT_SINK@ -5%") end, {
        group = "",
        description = ""
    }),
    
    awful.key({}, "XF86AudioMute",
    function() awful.spawn.with_shell("pactl set-sink-mute @DEFAULT_SINK@ toggle") end, {
        group = "",
        description = ""
    }),

    awful.key({}, "XF86AudioPlay",
    function() awful.spawn.with_shell("playerctl play-pause") end, {
        group = "",
        description = ""
    }),

    awful.key({}, "XF86AudioPause",
    function() awful.spawn.with_shell("playerctl pause") end, {
        group = "",
        description = ""
    }),
    
    awful.key({}, "XF86AudioPrev",
    function() awful.spawn.with_shell("playerctl previous") end, {
        group = "",
        description = ""
    }),
    
    awful.key({}, "XF86AudioNext",
    function() awful.spawn.with_shell("playerctl next") end, {
        group = "",
        description = ""
    })
)

clientkeys = gears.table.join(
    awful.key({ modkey }, "f",
    function (c)
        c.fullscreen = not c.fullscreen
        c:raise()
    end, {
        group = "client",
        description = "toggle fullscreen"
    }),
    
    awful.key({ modkey, "Shift" }, "c", function (c) c:kill() end, {
        group = "client",
        description = "close"
    }),
    
    awful.key({ modkey, "Control" }, "space", awful.client.floating.toggle, {
        group = "client",
        description = "toggle floating"
    }),
    
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end, {
        group = "client",
        description = "move to master"
    }),
    
    awful.key({ modkey }, "o", function (c) c:move_to_screen() end, {
        group = "client",
        description = "move to screen"
    }),
    
    awful.key({ modkey }, "t", function (c) c.ontop = not c.ontop end, {
        group = "client",
        description = "toggle keep on top"
    }),
    
    awful.key({ modkey }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end, {
            group = "client",
            description = "minimize"
    }),
    
    awful.key({ modkey }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end, {
            group = "client",
            description = "(un)maximize"
    }),
    
    awful.key({ modkey, "Control" }, "m",
        function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end, {
            group = "client",
            description = "(un)maximize vertically"
    }),
    
    awful.key({ modkey, "Shift" }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end, {
            group = "client",
            description = "(un)maximize horizontally"
    })
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen
     }
    },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
          "pinentry",
        },
        class = {
          "Arandr",
          "Blueman-manager",
          "Gpick",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Sxiv",
          "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
          "Wpa_gui",
          "veromix",
          "xtightvncviewer"},

        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "ConfigManager",  -- Thunderbird's about:config.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { floating = true }},

    -- Add titlebars to normal clients and dialogs
    { rule_any = {type = { "normal", "dialog" }
      }, properties = { titlebars_enabled = false }
    },

    -- Set Firefox to always map on the tag named "2" on screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { screen = 1, tag = "2" } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)
