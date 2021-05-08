local gears     = require("gears")       -- Gears module.
local awful     = require("awful")       -- Awful module.
local wibox     = require("wibox")       -- Wibox module.
local beautiful = require("beautiful")   -- Theme module.
local naughty   = require("naughty")     -- Notification module.
local menubar   = require("menubar")     -- Menu bar module.

require("awful.autofocus")               -- Enable autofocus.
awful.mouse.snap.edge_enabled = false    -- Disable window edge snapping.
awesome.font = ("FontAwesome 9")         -- Set font.

-- Naughty notification presets
naughty.config.defaults.font         = 'Monospace Bold 9'
naughty.config.defaults.icon_size    = 32
naughty.config.defaults.fg           = '#ffffff'
naughty.config.defaults.bg           = '#222222'
naughty.config.presets.critical.fg   = '#000000'
naughty.config.presets.critical.bg   = '#FF0000'
naughty.config.defaults.border_color = '#000000'
naughty.config.defaults.border_width = 2

-- Startup
-- awful.spawn.with_shell("sleep 1 && i3lock-fancy -t ''")

-- Error handling
if awesome.startup_errors then
  naughty.notify({
    preset = naughty.config.presets.critical,
    title = "Oops, there were errors during startup!",
    text = awesome.startup_errors
  })
end

-- Handle runtime errors after startup
do
  local in_error = false
  awesome.connect_signal("debug::error", function (err)
    if in_error then return end
    in_error = true

    naughty.notify({
      preset = naughty.config.presets.critical,
      title = "Oops, an error happened!",
      text = tostring(err)
    })
    in_error = false
  end)
end

-- Variable definitions
modkey = "Mod4"
terminal = os.getenv("TERMINAL") or "urxvt"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor
beautiful.init(awful.util.getdir("config") .. "/themes/default/theme.lua")

-- Layouts
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
  awful.layout.suit.magnifier,
  awful.layout.suit.corner.nw,
  awful.layout.suit.corner.ne,
  awful.layout.suit.corner.sw,
  awful.layout.suit.corner.se,
}

-- Helper functions
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

-- Widgets configuration
menubar.utils.terminal = terminal                                                                                                         -- Set the terminal for applications that require it.

widget_memory       = awful.widget.watch('sh -c "printf \'   \' && free --giga -h | awk \'FNR == 2 { print $7 }\'"', 3)                   -- Create memory widget.
widget_swap         = awful.widget.watch('sh -c "printf \'   \' && free --giga -h | awk \'FNR == 3 { print $4 }\'"', 4)                   -- Create swap widget.
widget_battery      = awful.widget.watch('sh -c "printf \'   \' && acpi -b 2>&1 | awk \'{ print $4 }\'"', 5)                              -- Create battery widget.
widget_date         = awful.widget.watch('sh -c "printf \'   \' && date \'+%-l:%M %p      %A %B %-d\'"', 1)                              -- Create date widget.
widget_loadaverage  = awful.widget.watch('sh -c "printf \'   \' && cat /proc/loadavg | awk -v OFS=\'  \' \'{ print $1, $2, $3 }\'"', 5)   -- Create load average widget.
widget_temperature  = awful.widget.watch('sh -c "printf \'   \' && sensors | awk \'/temp1:/ { print $2 }\' | head -n1"', 5)               -- Create temperature widget.
widget_traffic_down = awful.widget.watch(
  'sh -c "printf \'   \'' ..
  ' && vnstat -tr 2 -i $(ip addr | awk \'/state UP/ { print $2; exit }\' | sed \'s/.$//\') | awk \'/rx/ { print $2, $3 }\'"', 5)           -- Create download traffic widget.
widget_traffic_up   = awful.widget.watch(
  'sh -c "printf \'   \'' ..
  ' && vnstat -tr 2 -i $(ip addr | awk \'/state UP/ { print $2; exit }\' | sed \'s/.$//\') | awk \'/tx/ { print $2, $3 }\'"', 5)           -- Create upload traffic widget.
widget_separator    = wibox.widget.textbox() widget_separator:set_text("   ")                                                              -- Create separator widget.

-- Tooltips
local function tooltip(widget, execute)
 local tooltip = awful.tooltip({ margins_leftright = 15 }) tooltip:add_to_object(widget)
 widget:connect_signal("mouse::enter", function()
   awful.spawn.easy_async_with_shell(execute, function(stdout, stderr, reason, exit_code) tooltip.text = stdout end)
 end)
end

tooltip(widget_loadaverage, 'uptime')
tooltip(widget_temperature, 'sensors | grep -v \'+0.0°C\'')
tooltip(widget_battery,     'acpi -abi 2>&1')
tooltip(widget_date,        'cal --color=never')
tooltip(widget_memory,      'free --giga -h -t')

-- Create wibox
mywibox     = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist   = {}

mytaglist.buttons = awful.util.table.join(
  awful.button({        }, 3, awful.tag.viewtoggle),
  awful.button({        }, 1, function(t) t:view_only() end),
  awful.button({ modkey }, 3, function(t) if client.focus then client.focus:toggle_tag(t) end end),
  awful.button({ modkey }, 1, function(t) if client.focus then client.focus:move_to_tag(t) end end)
)

-- Set wallpaper function.
local function set_wallpaper(s)
  if beautiful.wallpaper then
    local wallpaper = beautiful.wallpaper
    if type(wallpaper) == "function" then
      wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)
  end
end

screen.connect_signal("property::geometry", set_wallpaper)                                                                                -- Reset wallpaper on screen geometry changes.

awful.screen.connect_for_each_screen(function(s)

    set_wallpaper(s)                                                                                                                      -- Set wallpaper.
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9", "10" }, s, awful.layout.layouts[1])                                          -- Create tag table for each screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)                                                                                            -- Create layout box.
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)                                            -- Create a taglist widget.
    mywibox[s] = awful.wibar({ position = "top", ontop = true, height = "18", screen = s })                                               -- Create the wibox.

    -- Left
    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(mytaglist[s])
    left_layout:add(widget_separator)
    left_layout:add(mylayoutbox[s])
    left_layout:add(widget_separator)
    left_layout:add(widget_traffic_down)
    left_layout:add(widget_separator)
    left_layout:add(widget_traffic_up)
    left_layout:add(widget_separator)
    left_layout:add(widget_loadaverage)
    left_layout:add(widget_separator)
    left_layout:add(widget_temperature)

    -- Right
    local right_layout = wibox.layout.fixed.horizontal()
    right_layout:add(widget_separator)
    right_layout:add(widget_memory)
    right_layout:add(widget_separator)
    right_layout:add(widget_swap)
    right_layout:add(widget_separator)
    right_layout:add(widget_battery)
    right_layout:add(widget_separator)
    right_layout:add(widget_date)
    right_layout:add(widget_separator)

    -- Now bring it all together (with the tasklist in the middle)
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_right(right_layout)
    mywibox[s]:set_widget(layout)
end)

-- Global Key bindings
globalkeys = gears.table.join(
  awful.key({ modkey,           }, "Escape", awful.tag.history.restore),                                                                 -- Show last visited tag
  awful.key({ modkey,           }, "u",      awful.client.urgent.jumpto),                                                                -- Jump to urgent client

  awful.key({ modkey,           }, "j",      function () awful.client.focus.byidx( 1) end),                                              -- Show next window
  awful.key({ modkey,           }, "k",      function () awful.client.focus.byidx(-1) end),                                              -- Show previous window
  awful.key({ modkey,           }, "h",      awful.tag.viewprev),                                                                        -- Show previous tag
  awful.key({ modkey,           }, "l",      awful.tag.viewnext),                                                                        -- Show next tag

  awful.key({ modkey, "Shift"   }, "j",      function () awful.screen.focus_relative( 1) end),                                           -- Focus next screen
  awful.key({ modkey, "Shift"   }, "k",      function () awful.screen.focus_relative(-1) end),                                           -- Focus previous screen
  awful.key({ modkey, "Shift"   }, "h",      function () awful.layout.inc(-1) end),                                                      -- Switch layout previous
  awful.key({ modkey, "Shift"   }, "l",      function () awful.layout.inc( 1) end),                                                      -- Switch layout next

  awful.key({ modkey, "Mod1"    }, "h",      function () awful.tag.incmwfact(-0.05) end),                                                -- Increase tiling window size left
  awful.key({ modkey, "Mod1"    }, "l",      function () awful.tag.incmwfact( 0.05) end),                                                -- Increase tiling window size right
  awful.key({ modkey,           }, "b",      function () mywibox[mouse.screen].visible = not mywibox[mouse.screen].visible end),         -- Show hide wibar
  awful.key({ modkey, "Control" }, "n",      function () local c = awful.client.restore() if c then client.focus = c c:raise() end end)  -- Restore minimized group
)

-- Client Key bindings
clientkeys = gears.table.join(
  awful.key({ modkey,           }, "s",       awful.client.floating.toggle),                                -- Toggle floating mode
  awful.key({ modkey, "Control" }, "Return",  function (c) c:swap(awful.client.getmaster()) end),           -- Move to master
  awful.key({ modkey,           }, "o",       function (c) c:move_to_screen() end),                         -- Move to screen
  awful.key({ modkey,           }, "m",       function (c) c.maximized = not c.maximized c:raise() end),    -- Maximize window

  awful.key({ modkey, "Control" }, "k",       function(c) c.y = c.y - 1 end),                               -- Move focused window up one pixel.
  awful.key({ modkey, "Control" }, "j",       function(c) c.y = c.y + 1 end),                               -- Move focused window down one pixel.
  awful.key({ modkey, "Control" }, "h",       function(c) c.x = c.x - 1 end),                               -- Move focused window left one pixel.
  awful.key({ modkey, "Control" }, "l",       function(c) c.x = c.x + 1 end),                               -- Move focused window right one pixel.

  awful.key({ modkey, "#49"     }, "k",       function(c) c.y = c.y - 10 end),                              -- Move focused window up fast.
  awful.key({ modkey, "#49"     }, "j",       function(c) c.y = c.y + 10 end),                              -- Move focused window down fast.
  awful.key({ modkey, "#49"     }, "h",       function(c) c.x = c.x - 10 end),                              -- Move focused window left fast.
  awful.key({ modkey, "#49"     }, "l",       function(c) c.x = c.x + 10 end)                               -- Move focused window right fast.
)

-- Bind all key numbers to tags
for i = 1, 9 do
  globalkeys = gears.table.join(globalkeys,
    awful.key({ modkey                     }, "#" .. i + 9, function () local screen = awful.screen.focused() local tag = screen.tags[i] if tag then tag:view_only() end end),               -- View tag only.
    awful.key({ modkey, "Control"          }, "#" .. i + 9, function () local screen = awful.screen.focused() local tag = screen.tags[i] if tag then awful.tag.viewtoggle(tag) end end),     -- Toggle tag display.
    awful.key({ modkey, "Shift"            }, "#" .. i + 9, function () if client.focus then local tag = client.focus.screen.tags[i] if tag then client.focus:move_to_tag(tag) end end end), -- Move client to tag.
    awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9, function () if client.focus then local tag = client.focus.screen.tags[i] if tag then client.focus:toggle_tag(tag) end end end)   -- Toggle tag on focused client.
  )
end

-- Mouse movement
clientbuttons = gears.table.join(
  awful.button({        }, 1, function (c) client.focus = c; c:raise() end),
  awful.button({ modkey }, 1, awful.mouse.client.move),
  awful.button({ modkey }, 3, awful.mouse.client.resize)
)

-- Set keys
root.keys(globalkeys)

-- Rules
awful.rules.rules = {
  {
    rule = { },
    properties = {
      border_width = beautiful.border_width,
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
  {
    rule_any =
    {
      instance = { "copyq", },
    },
    properties = { floating = true }   -- Floating clients.
  }
}

-- Signals (Signal function to execute when a new client appears)
client.connect_signal("manage", function (c)
  if awesome.startup and
    not c.size_hints.user_position
    and not c.size_hints.program_position then
      awful.placement.no_offscreen(c)           -- Prevent clients from being unreachable after screen count changes.
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
awful.util.spawn = function (s) oldspawn(s, false) end

-- Hide window border for maximized clients
client.connect_signal("property::maximized", function(c) c.border_width = c.maximized and 0 or beautiful.border_width end)

-- Focus and unfocus borders
client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
