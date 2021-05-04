--  Main
local theme = {}

-- Theme
theme.wallpaper   = "~/.config/awesome/themes/default/wallpaper"
theme.font        = "FontAwesome Bold 9"
theme.fg_normal   = "#FFFFFF"
theme.fg_focus    = "#000000"
theme.fg_urgent   = "#FF0000"
theme.fg_minimize = "#ffffff"
theme.bg_normal   = "#2C303C"
theme.bg_focus    = "#00AFF0"
theme.bg_urgent   = "#000000"
theme.bg_minimize = "#444444"
theme.bg_systray  = theme.bg_normal

-- Borders
theme.useless_gap   = 5
theme.border_width  = 2
theme.border_normal = "#5B92FA"
theme.border_focus  = "#FF0000"
theme.border_marked = "#CC9393"

-- Tooltip
theme.tooltip_border_color = "#000000"
theme.tooltip_bg           = "#111111"
theme.tooltip_fg           = "#ffffff"
theme.tooltip_font         = 'Monospace Bold 9'
theme.tooltip_border_width = 2

-- Menu
theme.menu_height       = 15
theme.menu_width        = 100
theme.menu_border_width = 0

-- Taglist
theme.taglist_squares_sel   = "~/.config/awesome/themes/default/taglist/squarefz.png"
theme.taglist_squares_unsel = "~/.config/awesome/themes/default/taglist/squarefz.png"

-- Layout
theme.layout_max        = "~/.config/awesome/themes/default/layouts/maxw.png"
theme.layout_tile       = "~/.config/awesome/themes/default/layouts/tilew.png"
theme.layout_fairh      = "~/.config/awesome/themes/default/layouts/fairhw.png"
theme.layout_fairv      = "~/.config/awesome/themes/default/layouts/fairvw.png"
theme.layout_spiral     = "~/.config/awesome/themes/default/layouts/spiralw.png"
theme.layout_tiletop    = "~/.config/awesome/themes/default/layouts/tiletopw.png"
theme.layout_dwindle    = "~/.config/awesome/themes/default/layouts/dwindlew.png"
theme.layout_floating   = "~/.config/awesome/themes/default/layouts/floatingw.png"
theme.layout_tileleft   = "~/.config/awesome/themes/default/layouts/tileleftw.png"
theme.layout_cornernw   = "~/.config/awesome/themes/default/layouts/cornernww.png"
theme.layout_cornerne   = "~/.config/awesome/themes/default/layouts/cornernew.png"
theme.layout_cornersw   = "~/.config/awesome/themes/default/layouts/cornersww.png"
theme.layout_cornerse   = "~/.config/awesome/themes/default/layouts/cornersew.png"
theme.layout_magnifier  = "~/.config/awesome/themes/default/layouts/magnifierw.png"
theme.layout_fullscreen = "~/.config/awesome/themes/default/layouts/fullscreenw.png"
theme.layout_tilebottom = "~/.config/awesome/themes/default/layouts/tilebottomw.png"

-- Titlebar
theme.titlebar_close_button_focus               = "/usr/share/awesome/themes/zenburn/titlebar/close_focus.png"
theme.titlebar_close_button_normal              = "/usr/share/awesome/themes/zenburn/titlebar/close_normal.png"
theme.titlebar_ontop_button_focus_active        = "/usr/share/awesome/themes/zenburn/titlebar/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active       = "/usr/share/awesome/themes/zenburn/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive      = "/usr/share/awesome/themes/zenburn/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive     = "/usr/share/awesome/themes/zenburn/titlebar/ontop_normal_inactive.png"
theme.titlebar_sticky_button_focus_active       = "/usr/share/awesome/themes/zenburn/titlebar/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active      = "/usr/share/awesome/themes/zenburn/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive     = "/usr/share/awesome/themes/zenburn/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive    = "/usr/share/awesome/themes/zenburn/titlebar/sticky_normal_inactive.png"
theme.titlebar_floating_button_focus_active     = "/usr/share/awesome/themes/zenburn/titlebar/floating_focus_active.png"
theme.titlebar_floating_button_normal_active    = "/usr/share/awesome/themes/zenburn/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive   = "/usr/share/awesome/themes/zenburn/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive  = "/usr/share/awesome/themes/zenburn/titlebar/floating_normal_inactive.png"
theme.titlebar_maximized_button_focus_active    = "/usr/share/awesome/themes/zenburn/titlebar/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active   = "/usr/share/awesome/themes/zenburn/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive  = "/usr/share/awesome/themes/zenburn/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = "/usr/share/awesome/themes/zenburn/titlebar/maximized_normal_inactive.png"

--  End
theme.icon_theme = nil
return theme
