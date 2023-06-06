local awful = require("awful")

local helpers = {}

function helpers.focus_previous_window()
    awful.client.focus.history.previous()

    if client.focus then
        client.focus:raise()
    end
end

function helpers.run_lua_code()
    awful.prompt.run {
        prompt = "Run Lua code: ",
        textbox = awful.screen.focused().mypromptbox.widget,
        exe_callback = awful.util.eval,
        history_path = awful.util.get_cache_dir() .. "/history_eval"
    }
end

function helpers.open_applications_menu()
    awful.spawn.with_shell("rofi -show drun")
end

function helpers.open_clipboard_menu()
    awful.spawn.with_shell("rofi -modi 'clipboard:greenclip print' -show clipboard -run-command '{cmd}'")
end

function helpers.open_power_menu()
    awful.spawn.with_shell("rofi -show powermenu -modi powermenu:~/.config/rofi/plugins/power-menu.sh")
end

return helpers
