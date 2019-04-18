-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
-- require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup").widget
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")
-- Naughty notification presets
naughty.config.defaults.border_width = 2
naughty.config.defaults['icon_size'] = 32
naughty.config.defaults.border_color = '#000000'
naughty.config.presets.critical.fg = '#000000'
-- Vicious library
local vicious = require("vicious")
-- Lain library
local lain = require("lain")
-- Set font
awesome.font = ("FontAwesome 8")
-- Startup
os.execute("copyq &")
-- os.execute("sleep 1 && i3lock-fancy -t '' -- scrot &")
-- Exit Signals
awesome.connect_signal("exit", function() awful.util.spawn_with_shell("~/.config/awesome/atexit") end)

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
beautiful.init(awful.util.getdir("config") .. "/themes/default/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "urxvt"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
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
    awful.layout.suit.corner.ne,
    awful.layout.suit.corner.sw,
    awful.layout.suit.corner.se,
}
-- }}}

-- {{{ Helper functions
local function client_menu_toggle_fn()
    local instance = nil

    return function ()
        if instance and instance.wibox.visible then
            instance:hide()
            instance = nil
        else
            instance = awful.menu.clients({ theme = { width = 250 } })
        end
    end
end
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
   { "hotkeys", function() return false, hotkeys_popup.show_help end},
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart }
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu },
                                    { "open terminal", terminal }
                                  }
                        })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar

-- Create bat widget
batwidget = wibox.widget.textbox()
vicious.register(batwidget, vicious.widgets.bat, "  $1$2%", 1, "C23B")

-- Create cpu widget
cpuwidget = wibox.widget.textbox()
vicious.register(cpuwidget, vicious.widgets.cpu, '  $1% ⇆ $2%' , 2)

-- Create memory widget
memwidget = wibox.widget.textbox()
vicious.register(memwidget, vicious.widgets.mem, '  $4 mB', 5)

-- Create swap widget
swapwidget = wibox.widget.textbox()
vicious.register(swapwidget, vicious.widgets.mem, '  $8 mB', 5)

-- Create network wifi widget
netwidgetwifi = wibox.widget.textbox()
vicious.register(netwidgetwifi, vicious.widgets.net, '  ${wifi down_kb} kB      ${wifi up_kb} kB   ', 3)

-- Create network net widget
netwidgetnet = wibox.widget.textbox()
vicious.register(netwidgetnet, vicious.widgets.net, '⇆    ${net down_kb} kB      ${net up_kb} kB', 2)

-- Create separator widget
separator = wibox.widget.textbox()
separator:set_text("    ")

-- Create a textdate widget
mytextdate = awful.widget.textclock("  %a %b %d   ", 1)

-- Create a textclock widget
mytextclock = wibox.widget.textclock("  %I:%M %p", 1)

-- Attach Lain Calendar Widget
lain.widget.calendar({
    attach_to = { mytextdate, mytextclock },
    notification_preset = { font = "Ubuntu Mono Bold 10", fg = "#FFFFFF", bg = "#000000" },
    cal = "/usr/bin/cal --color=always"
})

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9", "10" }, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    -- mylayoutbox[s]:buttons(gears.table.join(
    --                       awful.button({ }, 1, function () awful.layout.inc( 1) end),
    --                       awful.button({ }, 3, function () awful.layout.inc(-1) end),
    --                       awful.button({ }, 4, function () awful.layout.inc( 1) end),
    --                       awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

    -- Create a tasklist widget
    -- mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibar({ position = "top", ontop = true, height = "18", screen = s })

    -- Quake style drop down terminal
    s.quake = lain.util.quake({ app = terminal, width = 0.75, height = 0.33, horiz = "center", vert = "bottom", border=2 })

    -- Widgets that are aligned to the left
    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(mytaglist[s])
    left_layout:add(separator)
    left_layout:add(mylayoutbox[s])
    left_layout:add(separator)
    --left_layout:add(mypromptbox[s])
    --left_layout:add(separator)
    left_layout:add(netwidgetwifi)
    left_layout:add(netwidgetnet)
    left_layout:add(separator)
    left_layout:add(cpuwidget)

    -- Widgets that are aligned to the right
    local right_layout = wibox.layout.fixed.horizontal()
    right_layout:add(separator)
    right_layout:add(memwidget)
    right_layout:add(separator)
    right_layout:add(swapwidget)
    right_layout:add(separator)
    right_layout:add(batwidget)
    right_layout:add(separator)
    right_layout:add(mytextclock)
    right_layout:add(separator)
    right_layout:add(mytextdate)

    -- Now bring it all together (with the tasklist in the middle)
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_right(right_layout)
    mywibox[s]:set_widget(layout)
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
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),
    awful.key({ modkey,           }, "w", function () mymainmenu:show() end,
              {description = "show main menu", group = "awesome"}),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),

    -- Wibox show/hide
    awful.key({ modkey,           }, "b", function () mywibox[mouse.screen].visible = not mywibox[mouse.screen].visible end),

    -- Quake style drop down terminal
    awful.key({ modkey, }, "q", function () awful.screen.focused().quake:toggle() end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal, { placement = awful.placement.under_mouse }) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey, "Control" }, "q", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "Right", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "Left", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),

    -- Restore minimized group
    awful.key({ modkey, "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                      client.focus = c
                      c:raise()
                  end
              end,
              {description = "restore minimized", group = "client"}),

    -- Custom key bindings
    awful.key({ modkey }, "Tab", function ()
    awful.util.spawn_with_shell("~/.config/awesome/window-overview")
        end),

    awful.key({ }, "Print", function ()
    awful.util.spawn_with_shell("~/.config/awesome/snipping-tool")
        end),

    awful.key({ }, "XF86ScreenSaver", function ()
    awful.util.spawn_with_shell("~/.config/awesome/lockscreen")
        end),

    awful.key({ }, "XF86AudioRaiseVolume", function ()
    awful.util.spawn_with_shell("~/.config/awesome/volume-up")
        end),

    awful.key({ }, "XF86AudioLowerVolume", function ()
    awful.util.spawn_with_shell("~/.config/awesome/volume-down")
        end),

    awful.key({ }, "XF86AudioMute", function ()
    awful.util.spawn_with_shell("~/.config/awesome/volume-mute")
        end),

    awful.key({ }, "XF86Display", function ()
    awful.util.spawn_with_shell("~/.config/awesome/xrandr-switch-monitor")
        end),

    awful.key({ modkey }, "p", function ()
    awful.util.spawn_with_shell("~/.config/awesome/file-search")
        end),

    awful.key({ modkey }, "r", function ()
    awful.util.spawn_with_shell("~/.config/awesome/app-launcher")
        end),

    awful.key({ modkey, "Mod1" }, "r", function ()
    awful.util.spawn_with_shell("~/.config/awesome/app-launcher-priv")
        end),

    awful.key({ modkey, "Mod1" }, "p", function ()
    awful.util.spawn_with_shell("~/.config/awesome/internet-search")
        end),

    awful.key({ modkey }, "z", function ()
    awful.util.spawn("copyq toggle")
        end),

    awful.key({ "Mod1" }, "Tab", function ()
    awful.util.spawn_with_shell("~/.config/awesome/window-switcher")
        end)
)

clientkeys = gears.table.join(
    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ modkey,           }, "s",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "maximize", group = "client"}),
    awful.key({ modkey, "Control" }, "m", lain.util.magnify_client)
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
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

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
                     size_hints_honor = false,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen
     }
    },

    -- Floating clients.
    { rule_any = {
        instance = { "copyq", },
      }, properties = { floating = true }},

    -- Honor size hints for specific clients.
    { rule_any = {
        instance = { "gvim", },
      }, properties = { size_hints_honor = true }},
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup and
      not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            client.focus = c
            c:raise()
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            client.focus = c
            c:raise()
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c) : setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.floatingbutton (c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton   (c),
            awful.titlebar.widget.ontopbutton    (c),
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
        and awful.client.focus.filter(c) then
        client.focus = c
    end
end)

-- Disable startup notification globally
local oldspawn = awful.util.spawn
awful.util.spawn = function (s)
    oldspawn(s, false)
end

-- No border for maximized clients
client.connect_signal("property::maximized", function(c)
    c.border_width = c.maximized and 0 or beautiful.border_width
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
