# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.


import os
import subprocess

from typing import List  # noqa: F401

from libqtile import qtile
from libqtile.lazy import lazy
from libqtile import bar, layout, hook, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen

# My Qtile Modules
from modules.defaults import defaults

keys = [
    # Applications
    Key([defaults["mod"]], "Return", lazy.spawn(defaults["terminal"]), desc="Launch terminal"),
    Key([defaults["mod"]], "r", lazy.spawn("rofi -show drun"), desc="Launch rofi menu"),
    
    # Switch between windows
    Key([defaults["mod"]], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([defaults["mod"]], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([defaults["mod"]], "j", lazy.layout.down(), desc="Move focus down"),
    Key([defaults["mod"]], "k", lazy.layout.up(), desc="Move focus up"),
    
    Key([defaults["mod"]], "Left", lazy.layout.left(), desc="Move focus to left"),
    Key([defaults["mod"]], "Right", lazy.layout.right(), desc="Move focus to right"),
    Key([defaults["mod"]], "Down", lazy.layout.down(), desc="Move focus to down"),
    Key([defaults["mod"]], "Up", lazy.layout.up(), desc="Move focus to up"),

    Key(["mod1"], "Tab", lazy.layout.next(), desc="Move window focus to other window"),


    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([defaults["mod"], "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([defaults["mod"], "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([defaults["mod"], "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([defaults["mod"], "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),

    Key([defaults["mod"], "shift"], "Left", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([defaults["mod"], "shift"], "Right", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([defaults["mod"], "shift"], "Down", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([defaults["mod"], "shift"], "Up", lazy.layout.shuffle_up(), desc="Move window up"),

    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([defaults["mod"], "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([defaults["mod"], "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([defaults["mod"], "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([defaults["mod"], "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),

    Key([defaults["mod"], "control"], "Left", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([defaults["mod"], "control"], "Right", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([defaults["mod"], "control"], "Down", lazy.layout.grow_down(), desc="Grow window down"),
    Key([defaults["mod"], "control"], "Up", lazy.layout.grow_up(), desc="Grow window up"),
    
    Key([defaults["mod"], "control"], "n", lazy.layout.normalize(), desc="Reset all window sizes"),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key([defaults["mod"], "shift"], "Return", lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack"),

    # Toggle between different layouts as defined below
    Key([defaults["mod"]], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([defaults["mod"]], "w", lazy.window.kill(), desc="Kill focused window"),

    Key([defaults["mod"], "control"], "r", lazy.restart(), desc="Restart Qtile"),
    Key([defaults["mod"], "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    # Key([defaults["mod"]], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
    
    # Brightness
    # Key([], "X86MonBrightnessUp", lazy.spawn("brightnessctl set +8% --quiet"), desc="Update brightness x + x%"),

    # Audio controllers
    Key([], "XF86AudioMute", lazy.spawn("pactl set-sink-mute 0 toggle"), desc="Toggle"),
    Key([], "XF86AudioRaiseVolume", lazy.spawn("pactl set-sink-volume 0 +4%"), desc="Update volume x + x%"),
    Key([], "XF86AudioLowerVolume", lazy.spawn("pactl set-sink-volume 0 -4%"), desc="Update volume x - x%"),

    # Screen Locker
    Key([defaults["mod"]], "l", lazy.spawn("light-locker-command -l"))
]

groups = [Group(i) for i in "123456789"]

for i in groups:
    keys.extend([
        Key([defaults["mod"]], i.name, lazy.group[i.name].toscreen(),
            desc=f'Switch to group {i.name}'),

        Key([defaults["mod"], "shift"], i.name, lazy.window.togroup(i.name, switch_group=True),
            desc=f"Switch to & move focused window to group {i.name}"),
    ])


# Layout Configs
columns_layout_options = {
        "border_width": 2,
        "margin": [8, 4, 4, 4],
        "border_focus": '#3d59a1',
        "border_normal": '#101014',
}

layouts = [
    layout.Columns(**columns_layout_options),
    layout.Max(),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.MonadTall(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

widget_defaults = dict(
    font='sans',
    fontsize=12,
    padding=3
)
extension_defaults = widget_defaults.copy()


screens = [
    Screen(
        top=bar.Bar(
            widgets = [
                widget.GroupBox(padding=8, borderwidth=0),
                widget.Spacer(),
                widget.Clock(font="sans Bold", format='%a %d %H:%M', foreground = "#a9b1d6"),
                widget.Spacer(),
                # widget.Battery(format='Battery: {percent: 2.0%}'),
                # widget.Chord(
                #     chords_colors={
                #         'launch': ("#ff0000", "#d79921"),
                #     },
                #     name_transform=lambda name: name.upper(),
                # ),
                widget.Systray(padding = 4, icon_size = 14),
                widget.Spacer(length = 8),
                widget.Image(filename="~/.config/qtile/icons/power.svg", margin=6, mouse_callbacks={'Button1': lambda: qtile.cmd_spawn('~/.config/rofi/bin/launcher_alone')}),
                widget.Spacer(length = 4),
            ],

            size=26,
	        margin=0,
            foreground="#a9b1d6",
            background="#1a1b26",
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([defaults["mod"]], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([defaults["mod"]], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([defaults["mod"]], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    *layout.Floating.default_float_rules,
    Match(wm_class='confirmreset'),  # gitk
    Match(wm_class='makebranch'),  # gitk
    Match(wm_class='maketag'),  # gitk
    Match(wm_class='ssh-askpass'),  # ssh-askpass
    Match(title='branchdialog'),  # gitk
    Match(title='pinentry'),  # GPG key password entry
])
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# Autostart
@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser('~/.config/qtile/autostart.sh')
    subprocess.call([home])



# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
