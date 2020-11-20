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
-- Disable window edge snapping
awful.mouse.snap.edge_enabled = false
-- Naughty notification presets
naughty.config.defaults.icon_size = 32
naughty.config.defaults.border_width = 2
naughty.config.defaults.border_color = '#000000'
naughty.config.defaults.fg = '#ffffff'
naughty.config.defaults.bg = '#222222'
naughty.config.presets.critical.fg = '#000000'
naughty.config.presets.critical.bg = '#FF0000'
naughty.config.defaults.font = 'Monospace Bold 9'
-- Vicious library
local vicious = require("vicious")
-- Lain library
local lain = require("lain")
-- Set font
awesome.font = ("FontAwesome 9")
-- Startup
-- os.execute("sleep 1 && i3lock-fancy -t '' -- scrot &")

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
modkey = "Mod4"
terminal = "urxvt"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor
beautiful.init(awful.util.getdir("config") .. "/themes/default/theme.lua")

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
    -- awful.layout.suit.max,
    -- awful.layout.suit.max.fullscreen,
    -- awful.layout.suit.magnifier,
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
vicious.register(netwidgetwifi, vicious.widgets.net, '  ${wifi down_kb} kB     ${wifi up_kb} kB', 3)

-- Create network net widget
netwidgetnet = wibox.widget.textbox()
vicious.register(netwidgetnet, vicious.widgets.net, '  ${net down_kb} kB     ${net up_kb} kB', 2)

-- Create separator widget
separator = wibox.widget.textbox()
separator:set_text("    ")

-- Create a textdate widget
mytextdate = awful.widget.textclock("  %a %b %d   ", 1)

-- Create a textclock widget
mytextclock = wibox.widget.textclock("  %I:%M %p", 1)

-- Attach Lain Calendar Widget
lain.widget.cal({
    attach_to = { mytextdate, mytextclock },
    notification_preset = { font = "Monospace Bold 10", fg = "#FFFFFF", bg = "#222222" },
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
                                          end)
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
    s.quake = lain.util.quake({ app = "urxvt -pe tabbed", width = 0.75, height = 0.33, horiz = "center", vert = "bottom", border=2 })

    -- Widgets that are aligned to the left
    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(mytaglist[s])
    left_layout:add(separator)
    left_layout:add(mylayoutbox[s])
    left_layout:add(separator)
    -- left_layout:add(mypromptbox[s])
    -- left_layout:add(separator)
    left_layout:add(netwidgetwifi)
    left_layout:add(separator)
    left_layout:add(netwidgetnet)
    left_layout:add(separator)
    left_layout:add(cpuwidget)

    -- Widgets that are aligned to the right
    local right_layout = wibox.layout.fixed.horizontal()
    -- if s == 1 then right_layout:add(wibox.widget.systray()) end
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

-- {{{ Key bindings
globalkeys = gears.table.join(

    -- General bindings
    awful.key({ modkey, "Shift"   }, "q",       awesome.restart),                                       -- Restart
    awful.key({ modkey,           }, "[",       awful.tag.viewprev),                                    -- Show previous tag
    awful.key({ modkey,           }, "]",       awful.tag.viewnext),                                    -- Show next tag
    awful.key({ modkey,           }, "Escape",  awful.tag.history.restore),                             -- Show last visited tag

    -- Layout manipulation
    awful.key({ modkey,           }, "u",       awful.client.urgent.jumpto),                            -- Jump to urgent client
    awful.key({ modkey,           }, "k",       function () awful.client.focus.byidx(-1) end),          -- Show previous window
    awful.key({ modkey,           }, "j",       function () awful.client.focus.byidx( 1) end),          -- Show next window
    awful.key({ modkey,           }, "q",       function () awful.screen.focused().quake:toggle() end), -- Toggle quake terminal
    awful.key({ modkey, "Shift"   }, "k",       function () awful.screen.focus_relative(-1) end),       -- Focus previous screen
    awful.key({ modkey, "Shift"   }, "j",       function () awful.screen.focus_relative( 1) end),       -- Focus next screen

    -- Standard program
    awful.key({ modkey,           }, "h",       function () awful.tag.incmwfact(-0.05) end),            -- Increase tiling window size left
    awful.key({ modkey,           }, "l",       function () awful.tag.incmwfact( 0.05) end),            -- Increase tiling window size right
    awful.key({ modkey, "Shift"   }, "[",       function () awful.layout.inc(-1) end),                  -- Switch layout previous
    awful.key({ modkey, "Shift"   }, "]",       function () awful.layout.inc( 1) end),                  -- Switch layout next

    -- Show hide wibar
    awful.key({ modkey,           }, "b",       function () mywibox[mouse.screen].visible = not mywibox[mouse.screen].visible end),

    -- Restore minimized group
    awful.key({ modkey, "Control" }, "n",
      function ()
          local c = awful.client.restore()
          if c then
              client.focus = c
              c:raise()
          end
      end)

	-- awful.key({ modkey }, "x", function ()
	-- awful.prompt.run({ prompt = "Run Lua code: " },
	-- mypromptbox[mouse.screen].widget,
    -- awful.util.eval, nil,
    -- awful.util.getdir("cache") .. "/history_eval")
	--	end)
)

clientkeys = gears.table.join(
    awful.key({ modkey, "Control" }, "m",       lain.util.magnify_client),                                    -- Lain magnify
    awful.key({ modkey, "Control" }, "Return",  function (c) c:swap(awful.client.getmaster()) end),           -- Move to master
    awful.key({ modkey,           }, "o",       function (c) c:move_to_screen() end),                         -- Move to screen
    awful.key({ modkey,           }, "m",       function (c) c.maximized = not c.maximized c:raise() end),    -- Maximize window
    awful.key({ modkey,           }, "s",       awful.client.floating.toggle)                                 -- Toggle floating mode
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
      }, properties = { floating = true }}
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

-- Hide window border for maximized clients
client.connect_signal("property::maximized", function(c)
    c.border_width = c.maximized and 0 or beautiful.border_width
end)

-- Focus and unfocus borders
client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
