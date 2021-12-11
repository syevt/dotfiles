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
local dpi   = require("beautiful.xresources").apply_dpi
local weather_widget = require("awesome-wm-widgets.weather-widget.weather")
local ram_widget = require("awesome-wm-widgets.ram-widget.ram-widget")
local cpu_widget = require("awesome-wm-widgets.cpu-widget.cpu-widget")
local volume_widget = require('awesome-wm-widgets.volume-widget.volume')
local calendar_widget = require("awesome-wm-widgets.calendar-widget.calendar")
local logout_menu_widget = require("awesome-wm-widgets.logout-menu-widget.logout-menu")
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
beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")
-- beautiful.init("~/.config/awesome/default/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "alacritty"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor

-- theme.font = "Operator Mono 16"

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
-- modkey = "Mod4"
modkey = "Mod1"

awful.screen.set_auto_dpi_enabled( true )

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.floating,
    -- awful.layout.suit.tile.left,
    -- awful.layout.suit.tile.bottom,
    -- awful.layout.suit.tile.top,
    -- awful.layout.suit.fair,
    -- awful.layout.suit.fair.horizontal,
    -- awful.layout.suit.spiral,
    -- awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    -- awful.layout.suit.magnifier,
    -- awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}
-- }}}

local chosen_theme = "vertex"
beautiful.init(string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), chosen_theme))

-- {{{ Menu
-- Create a launcher widget and a main menu
newaita_path =  "/home/syevt/.local/share/icons/Newaita-dark/apps/64/"
newaita_cats_path =  "/home/syevt/.local/share/icons/Newaita-dark/categories/64/"
myawesomemenu = {
   { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "manual", terminal .. " -e man awesome", newaita_path .. "viber.svg" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end },
}

myinet = {
  { "Firefox", "firefox", newaita_path .. "firefox.svg" },
  { "Chrome", "google-chrome-stable", newaita_path .. "google-chrome.svg" },
  { "Falkon", "falkon", newaita_path .. "falkon.svg" },
  { "Qbittorrent", "qbittorrent", newaita_path .. "qbittorrent.svg" },
  { "Postman", "postman", newaita_path .. "postman.svg" },
}

mymeetings = {
  { "Zoom", "zoom", newaita_path .. "Zoom.svg" },
  { "Teams", "teams", newaita_path .. "teams-for-linux.svg" },
}

mymessengers = {
  { "Slack", "slack", newaita_path .. "slack.svg" },
  { "Viber", "viber", newaita_path .. "viber.svg" },
}

mymedia = {
  { "Audacious", "audacious", newaita_path .. "audacious.svg" },
  { "VideoLAN", "vlc", newaita_path .. "vlc.svg" }
}

mydocs = {
  { "Okular", "okular", newaita_path .. "okular.svg" }
}

mymainmenu = awful.menu({ items = { 
  -- { "awesome", myawesomemenu, beautiful.awesome_icon },
    { "Internet", myinet, newaita_path .. "palemoon.svg" },
    { "Meetings", mymeetings, newaita_cats_path .. "mumble.svg" },
    { "Messengers", mymessengers, newaita_cats_path .. "pidgin.svg" },
    { "Media", mymedia, newaita_cats_path .. "org.gnome.Podcasts.svg" },
    { "Docs", mydocs, newaita_cats_path .. "text-editor.svg" },
    { "Alacritty", terminal, newaita_cats_path .. "tilix.svg" },
    { "Solitaire", "kpat", newaita_path .. "kpatience.svg" },
    { "Dolphin", "dolphin", newaita_path .. "system-file-manager.svg" },
    { "restart", awesome.restart },
    { "quit", function() awesome.quit() end },
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

local cw = calendar_widget({
    -- theme = 'outrun',
    placement = 'top_right',
    -- start_sunday = true,
    radius = 8,
    previous_month_button = 1,
    next_month_button = 3,
})

mytextclock:connect_signal("button::press",
    function(_, _, _, button)
        if button == 1 then cw.toggle() end
    end)

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
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

local tasklist_buttons = gears.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  c:emit_signal(
                                                      "request::activate",
                                                      "tasklist",
                                                      {raise = true}
                                                  )
                                              end
                                          end),
                     awful.button({ }, 3, function()
                                              awful.menu.client_list({ theme = { width = 250 } })
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))

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
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons,
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons,
        bg_focus = "#242424"
    }

    -- Create the wibox
    s.mywibox = awful.wibar({
      position = "top",
      screen = s,
      width = '99%',
      border_width = dpi(2),
      opacity = 0.9,
      shape = function(cr, w, h)
        gears.shape.rounded_rect(cr, w, h, 8)
      end,
    })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            -- mylauncher,
            s.mytaglist,
            s.mypromptbox,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            -- wibox.widget.textbox("Some 2 text"),
            mykeyboardlayout,
            weather_widget({
              api_key='ef1b4bda42764ceb3d76460a00b02117',
              coordinates = {48.4679,35.0413},
              -- time_format_12h = true,
              -- units = 'imperial',
              -- both_units_widget = true,
              -- font_name = 'PT Sans Narrow',
              icons = 'VitalyGorbachev',
              -- for VitalyGorbachev's icons you need to set `svg`
              icons_extension = '.svg',
              -- icons = 'weather-underground-icons',
              show_hourly_forecast = true,
              show_daily_forecast = true,
            }),
            ram_widget{
              color_used = beautiful.bg_normal
            },
            cpu_widget(),
            -- wibox.widget.textbox("Some 3 text"),
            wibox.widget.systray(),
            mytextclock,
            volume_widget{
              -- widget_type = 'arc'
              widget_type = 'icon_and_text'
              -- widget_type = 'icon'
              -- widget_type = 'horizontal_bar'
            },
            logout_menu_widget(),
            s.mylayoutbox,
        },
    }
end)

-- {{{ Mouse bindings
root.buttons(gears.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}


-- {{{ Key bindings
globalkeys = gears.table.join(
    awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),
    -- awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
              -- {description = "view previous", group = "tag"}),
    -- awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
              -- {description = "view next", group = "tag"}),
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
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),

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
    awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),

    awful.key({ modkey, "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                    c:emit_signal(
                        "request::activate", "key.unminimize", {raise = true}
                    )
                  end
              end,
              {description = "restore minimized", group = "client"}),

    -- Prompt
    awful.key({ modkey },            "r",
              function ()
                  awful.spawn.with_shell("rofi -show drun")
              end,
              {description = "run prompt", group = "launcher"}),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end,
              {description = "lua execute prompt", group = "awesome"}),
    -- Menubar
    awful.key({ modkey }, "p", function() menubar.show() end,
              {description = "show the menubar", group = "launcher"}),
    awful.key({ modkey, "Control" }, "=", function () lain.util.useless_gaps_resize(1) end,
          {description = "increase gaps", group = "customise"}),
          awful.key({ modkey, "Control" }, "-", function () lain.util.useless_gaps_resize(-1) end,
          {description = "decrease gaps", group = "customise"})
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
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "(un)maximize", group = "client"}),
    awful.key({ modkey, "Control" }, "m",
        function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end ,
        {description = "(un)maximize vertically", group = "client"}),
    awful.key({ modkey, "Shift"   }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end ,
        {description = "(un)maximize horizontally", group = "client"}),
    awful.key({ "Control" }, "7",
        function ()
          awful.spawn.with_shell("setxkbmap -layout us -variant dvorak && setxkbmap -option caps:swapescape")
        end ,
        {description = "switch keyboard layout to us dvorak", group = "client"}),
    awful.key({ "Control" }, "8",
        function ()
          awful.spawn.with_shell("setxkbmap ua && setxkbmap -option caps:swapescape")
        end ,
        {description = "switch keyboard layout to uk", group = "client"}),
    awful.key({ "Control" }, "9",
        function ()
          awful.spawn.with_shell("setxkbmap ru && setxkbmap -option caps:swapescape")
        end ,
        {description = "switch keyboard layout to ru", group = "client"})
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
      properties = {
        border_width = beautiful.border_width,
        border_color = beautiful.border_normal,
        focus = awful.client.focus.filter,
        raise = true,
        keys = clientkeys,
        buttons = clientbuttons,
        screen = awful.screen.preferred,
        placement = awful.placement.no_overlap+awful.placement.no_offscreen,
        shape = function()
          return function(cr, w, h)
            gears.shape.rounded_rect(cr, w, h, 8)
          end
        end,
      }
    },

    -- { rule = { maximized = true },
      -- properties = {
        -- shape = function()
          -- return function(cr, w, h)
            -- gears.shape.rounded_rect(cr, w, h, 0)
          -- end
        -- end,
      -- }
    -- },

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

    -- Set no border for gis-weather
    -- { rule = { type = "utility" },

    { rule = { class = "firefox" },
      properties = {
        tag = "2"
    } },

    { rule = { class = "Slack" },
      properties = {
        tag = "3"
    } },

    { rule = { class = "Microsoft Teams - Preview" },
      properties = {
        tag = "4"
    } },

    { rule = { class = "Gis-weather.py" },
      properties = {
        border_width = 0,
        tag = "5"
    } },

    { rule = { class = "Audacious" },
      properties = {
        border_width = 0,
        tag = "5"
    } },

    { rule = { class = "zoom" },
      properties = {
        tag = "6"
    } },

    { rule = { class = "Google-chrome" },
      properties = {
        tag = "9"
    } },

    -- { rule = { class = "dolphin" },
      -- properties = {
        -- screen = "HDMI-1",
        -- tag = "7"
    -- } },

    -- Set no border for the maximized windows
    -- no luck...
    { rule = { maximized = true},
      properties = {
        border_width = 0,
    } },

    -- Add titlebars to normal clients and dialogs
    -- { rule_any = {type = { "normal", "dialog" }
      -- }, properties = { titlebars_enabled = true }
    -- },

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

-- an attempt to remove the border on a single client
-- https://stackoverflow.com/questions/30324250/how-to-hide-borders-dynamically-from-windows-when-not-tiled-awesome-wm
-- for s = 1, screen.count() do
    -- screen[s]:connect_signal("arrange", function ()
        -- local clients = awful.client.visible(s)
        -- local layout  = awful.layout.getname(awful.layout.get(s))

        -- -- No borders with only one visible client or in maximized layout
        -- if #clients > 1 and layout ~= "max" then
            -- for _, c in pairs(clients) do -- Floaters always have borders
                -- if not awful.rules.match(c, {class = "Synapse"}) and awful.client.floating.get(c) or layout == "floating" then                                     
                    -- c.border_width = beautiful.border_width
                    -- c.border_color = beautiful.border_focus
                -- end
            -- end
        -- end
    -- end)
-- end

-- Add a titlebar if titlebars_enabled is set to true in the rules.
-- client.connect_signal("request::titlebars", function(c)
    -- -- buttons for the titlebar
    -- local buttons = gears.table.join(
        -- awful.button({ }, 1, function()
            -- c:emit_signal("request::activate", "titlebar", {raise = true})
            -- awful.mouse.client.move(c)
        -- end),
        -- awful.button({ }, 3, function()
            -- c:emit_signal("request::activate", "titlebar", {raise = true})
            -- awful.mouse.client.resize(c)
        -- end)
    -- )

    -- awful.titlebar(c) : setup {
        -- { -- Left
            -- awful.titlebar.widget.iconwidget(c),
            -- buttons = buttons,
            -- layout  = wibox.layout.fixed.horizontal
        -- },
        -- { -- Middle
            -- { -- Title
                -- align  = "center",
                -- widget = awful.titlebar.widget.titlewidget(c)
            -- },
            -- buttons = buttons,
            -- layout  = wibox.layout.flex.horizontal
        -- },
        -- { -- Right
            -- awful.titlebar.widget.floatingbutton (c),
            -- awful.titlebar.widget.maximizedbutton(c),
            -- awful.titlebar.widget.stickybutton   (c),
            -- awful.titlebar.widget.ontopbutton    (c),
            -- awful.titlebar.widget.closebutton    (c),
            -- layout = wibox.layout.fixed.horizontal()
        -- },
        -- layout = wibox.layout.align.horizontal
    -- }
-- end)

-- Enable sloppy focus, so that focus follows mouse.
-- client.connect_signal("mouse::enter", function(c)
    -- c:emit_signal("request::activate", "mouse_enter", {raise = false})
-- end)
-- beautiful.useless_gap = 5
-- beautiful.wibar_bg = "#ff0000"
-- beautiful.wibar_stretch = false
-- beautiful.bg_normal = "#ff000011"

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

screen.connect_signal("arrange", function (s)
    local only_one = #s.tiled_clients == 1
    for _, c in pairs(s.clients) do
        if only_one or c.class == "Gis-weather.py" then
            c.border_width = 0
        else
            c.border_width = beautiful.border_width
        end
    end
end)

commands = {
  "picom --config  $HOME/.config/awesome/my_picom.conf",
  "xrandr --output HDMI-1 --primary --mode 1920x1080 --rate 60.00 --output VGA-1 --mode 1360x768 --rate 60.02 --left-of HDMI-1",
  "setxkbmap us -variant dvorak && setxkbmap -option caps:swapescape",
  "xset -dpms && xset s off",
  "nm-applet",
  "easystroke",
  "flameshot",
  "indicator-bulletin",
  "workrave",
  "gis-weather"
}

for _, command in ipairs(commands) do
  awful.spawn.with_shell(command)
end

-- run nm-applet
-- #run caffeine
-- run pamac-tray
-- run variety
-- run xfce4-power-manager
-- run blueberry-tray
-- run /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
-- run numlockx on
-- run volumeicon
-- }}}
