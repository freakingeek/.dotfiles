local gears = require("gears")
local awful = require("awful")

-- Widget and layout library
local wibox = require("wibox")

local utils = require("modules.utils")

-- Wibar
awful.screen.connect_for_each_screen(function(screen)
    utils.set_wallpaper(screen)

    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, screen, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    screen.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    screen.mylayoutbox = awful.widget.layoutbox(screen)

    screen.mylayoutbox:buttons(
        gears.table.join(
            awful.button({}, 1, function() awful.layout.inc(1) end),
            awful.button({}, 3, function() awful.layout.inc(-1) end),
            awful.button({}, 4, function() awful.layout.inc(1) end),
            awful.button({}, 5, function() awful.layout.inc(-1) end)
        )
    )

    -- Create a taglist widget
    screen.mytaglist = awful.widget.taglist {
        screen  = screen,
        filter  = awful.widget.taglist.filter.all,
        buttons = gears.table.join(
            awful.button({}, 1, function(t) t:view_only() end),

            awful.button({ modkey }, 1,
               function(t)
                   if client.focus then
                       client.focus:move_to_tag(t)
                   end
               end
            ),

	    awful.button({}, 3, awful.tag.viewtoggle),

            awful.button({ modkey }, 3,
               function(t)
                   if client.focus then
                       client.focus:toggle_tag(t)
                   end
               end
            ),

            awful.button({}, 4, function(t) awful.tag.viewnext(t.screen) end),
            awful.button({}, 5, function(t) awful.tag.viewprev(t.screen) end)
        )
    }

    -- Create a tasklist widget
    screen.mytasklist = awful.widget.tasklist {
        screen  = screen,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = gears.table.join(
            -- awful.button({}, 1,
            --     function(c)
            --         if c == client.focus then
            --             c.minimized = true
            --         else
            --             c:emit_signal("request::activate", "tasklist", { raise = true })
            --         end
            --     end
            -- ),

            awful.button({}, 3, function() awful.menu.client_list({ theme = { width = 250 } }) end),

            awful.button({}, 4, function() awful.client.focus.byidx(1) end),
            awful.button({}, 5, function() awful.client.focus.byidx(-1) end)
        )
    }

    -- Create the wibox
    screen.mywibox = awful.wibar({ position = "top", screen = screen })

    -- Add widgets to the wibox
    screen.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            screen.mytaglist,
            screen.mypromptbox,
        },
        screen.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            awful.widget.keyboardlayout(),
            wibox.widget.systray(),
            wibox.widget.textclock(),
            screen.mylayoutbox,
        },
    }
end)
