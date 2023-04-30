from libqtile import bar, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.layout.columns import Columns
from libqtile.layout.floating import Floating
from libqtile.layout.max import Max
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
from catppuccin import theme
from colors import colors

mod = "mod4"
terminal = guess_terminal()
theme = theme["macchiato"]
font = "Space Mono Nerd Font"

keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key(
        [mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"
    ),
    Key(
        [mod, "shift"],
        "l",
        lazy.layout.shuffle_right(),
        desc="Move window to the right",
    ),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key(
        [mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"
    ),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "f", lazy.spawn("firefox"), desc="Launch firefox"),
    Key([mod], "d", lazy.spawn("discord"), desc="Launch discord"),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
    Key(
        [mod, "control"],
        "f",
        lazy.window.toggle_floating(),
        desc="Toggle floating",
    ),
]

groups = [Group(i) for i in "123456789"]

for i in groups:
    keys.extend(
        [
            # mod1 + letter of group = switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            # mod1 + shift + letter of group = switch to & move focused window to group
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(i.name),
            ),
            # Or, use below if you prefer not to switch to that group.
            # # mod1 + shift + letter of group = move focused window to group
            # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            #     desc="move focused window to group {}".format(i.name)),
        ]
    )

layouts = [
    Columns(
        border_focus=theme["flamingo"],
        border_normal=theme["base"],
        border_width=4,
        margin=8,
    ),
    Max(),
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
    font="sans",
    fontsize=12,
    padding=3,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        bottom=bar.Bar(
            [
                # Left side
                widget.GroupBox(
                    active=colors["overlay1"],
                    background=theme["lavender"],
                    other_screen_border=theme["lavender"],
                    other_current_screen_border=theme["lavender"],
                    this_screen_border=theme["lavender"],
                    this_current_screen_border=theme["lavender"],
                    inactive=theme["mantle"],
                    block_highlight_text_color=theme["text"],
                    fontsize=15,
                    padding_x=15,
                    font=font,
                    disable_drag=True,
                ),
                widget.TextBox(
                    text="",
                    fontsize=35,
                    foreground=theme["lavender"],
                    background=colors["surface0"],
                    padding=0,
                ),
                widget.Spacer(length=20),
                widget.WindowName(
                    foreground=colors["text"],
                    fontsize=18,
                    font=font,
                ),
                widget.Spacer(length=20),
                # Right side
                widget.TextBox(
                    text="",
                    fontsize=35,
                    foreground=colors["surface1"],
                    background=colors["base"],
                    padding=0,
                ),
                widget.Systray(
                    padding=15,
                    icon_size=25,
                    background=colors["surface1"],
                ),
                widget.Spacer(length=25, background=colors["surface1"]),
                widget.TextBox(
                    text="",
                    fontsize=35,
                    foreground=colors["surface0"],
                    background=colors["surface1"],
                    padding=0,
                ),
                widget.PulseVolume(
                    background=colors["surface0"],
                    foreground=colors["text"],
                    font=font,
                    fontsize=20,
                    fmt="墳 {} ",
                    mouse_callbacks={"Button3": lazy.spawn("pavucontrol -t 4")},
                ),
                widget.TextBox(
                    text="",
                    fontsize=35,
                    foreground=colors["mantle"],
                    background=colors["surface0"],
                    padding=0,
                ),
                widget.Clock(
                    background=colors["mantle"],
                    foreground=colors["text"],
                    format=" %d/%m/%Y  %H:%M ",
                    font=font,
                    fontsize=20,
                    padding=10,
                ),
            ],
            size=35,
            background=colors["base"],
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag(
        [mod],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()
    ),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

wmname = "qtile"
