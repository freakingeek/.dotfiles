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

return helpers
