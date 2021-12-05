--
-- load modules
--

pcall(require, "luarocks.loader")
local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")

require("awful.autofocus")
require("awful.hotkeys_popup.keys")


--
-- error handling
--

if awesome.startup_errors then
    naughty.notify({
        preset = naughty.config.presets.critical,
        title = "Oops, there were errors during startup!",
        text = awesome.startup_errors })
end

do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true
        naughty.notify({
            preset = naughty.config.presets.critical,
            title = "Oops, an error happened!",
            text = tostring(err) })
        in_error = false
    end)
end


--
-- variables
--

terminal = "alacritty"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor
modk = "Mod4"
beautiful.init("/home/mateck/.config/awesome/theme.lua")


--
-- workspaces
--

awful.layout.layouts = {
    awful.layout.suit.max,
    awful.layout.suit.tile,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.floating,
    -- awful.layout.suit.tile.left,
    -- awful.layout.suit.tile.top,
    -- awful.layout.suit.fair,
    -- awful.layout.suit.fair.horizontal,
    -- awful.layout.suit.spiral,
    -- awful.layout.suit.spiral.dwindle,
    -- awful.layout.suit.magnifier,
    -- awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}


--
-- wibar
--

local wtextclock = wibox.widget.textclock('%y/%m/%d %R')

local wprompt = function (s)
    local w = awful.widget.prompt()
    s.wprompt = w
    return w
end

local wlayoutbox = function(s)
    -- TODO
    -- awful.widget.layoutbox { screen = s, buttons = ... } on new version
    local w = awful.widget.layoutbox(s)
    w:buttons(gears.table.join(
        awful.button({ }, 1, function () awful.layout.inc( 1) end),
        awful.button({ }, 3, function () awful.layout.inc(-1) end),
        awful.button({ }, 4, function () awful.layout.inc( 1) end),
        awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    return w
end

local wtaglist = function(s)
    local w = awful.widget.taglist {
        screen = s,
        filter = awful.widget.taglist.filter.all,
        buttons = gears.table.join(
            awful.button({ }, 1, function(t) t:view_only() end),
            awful.button({ modk }, 1, function(t)
                if client.focus then
                    client.focus:move_to_tag(t)
                end
            end),
            awful.button({ }, 3, awful.tag.viewtoggle),
            awful.button({ modk }, 3, function(t)
                if client.focus then
                    client.focus:toggle_tag(t)
                end
            end),
            awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
            awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
        )
    }
    return w
end

local wtasklist = function(s)
    local w = awful.widget.tasklist {
        screen = s,
        filter = awful.widget.tasklist.filter.currenttags,
        buttons = gears.table.join(
            awful.button({ }, 1, function (c)
                if c == client.focus then
                    c.minimized = true
                else
                    c:emit_signal("request::activate", "tasklist", {raise = true})
                end
            end),
            awful.button({ }, 3, function()
                awful.menu.client_list({ theme = {width=250} })
            end),
            awful.button({ }, 4, function ()
                awful.client.focus.byidx(1)
            end),
            awful.button({ }, 5, function ()
                awful.client.focus.byidx(-1)
            end)
        )
    }
    return w
end

local wwibar = function(s)
    local w = awful.wibar {
        position = "top",
        screen = s,
    }
    w:setup {
        layout = wibox.layout.align.horizontal,
        {
            layout = wibox.layout.fixed.horizontal,
            wlayoutbox(s),
            wtaglist(s),
            wprompt(s),
        },
        {
            layout = wibox.layout.fixed.horizontal,
            wtasklist(s),
        },
        {
            layout = wibox.layout.fixed.horizontal,
            wtextclock,
        },
    }
    return w
end

local function set_wallpaper(s)
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- ee-set wallpaper when a screen geometry changes
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- wallpaper
    set_wallpaper(s)
    -- tag table
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])
    -- wibar
    s.wwibar = wwibar(s)
end)


--
-- mouse bindings
--

root.buttons(gears.table.join(
--    awful.button({ }, 3, function () mymainmenu:toggle() end),
--    awful.button({ }, 4, awful.tag.viewnext),
--    awful.button({ }, 5, awful.tag.viewprev)
))

clientbuttons = gears.table.join(
    awful.button({ }, 1,
        function (c)
            c:emit_signal("request::activate", "mouse_click", {raise = true})
        end),
    awful.button({ modk }, 1,
        function (c)
            c:emit_signal("request::activate", "mouse_click", {raise = true})
            awful.mouse.client.move(c)
        end),
    awful.button({ modk }, 3,
        function (c)
            c:emit_signal("request::activate", "mouse_click", {raise = true})
            awful.mouse.client.resize(c)
        end)
)


--
-- key bindings
--

-- global keys
globalkeys = gears.table.join(

    -- awesome
    awful.key({ modk }, "s",
        hotkeys_popup.show_help,
        {description="show help", group="awesome"}),
    awful.key({ modk, "Control" }, "r",
        awesome.restart,
        {description = "reload awesome", group = "awesome"}),
    awful.key({ modk, "Shift" }, "q",
        awesome.quit,
        {description = "quit awesome", group = "awesome"}),
    awful.key({ modk}, "x",
        function ()
            awful.prompt.run {
                prompt = "Run Lua code: ",
                textbox = awful.screen.focused().wprompt.widget,
                exe_callback = awful.util.eval,
                history_path = awful.util.get_cache_dir() .. "/history_eval"
            }
        end,
        {description = "lua execute prompt", group = "awesome"}),

    -- launcher
    awful.key({ modk }, "Return",
        function () awful.spawn(terminal) end,
        {description = "open terminal", group = "launcher"}),
    awful.key({ modk }, "r",
        function () awful.screen.focused().wprompt:run() end,
        {description = "run prompt", group = "launcher"}),
    awful.key({ modk }, "p",
        function() menubar.show() end,
        {description = "show menubar", group = "launcher"}),

    -- screen
    awful.key({ modk, "Control" }, "j",
        function () awful.screen.focus_relative(1) end,
        {description = "focus next screen", group = "screen"}),
    awful.key({ modk, "Control" }, "k",
        function () awful.screen.focus_relative(-1) end,
        {description = "focus previous screen", group = "screen"}),

    -- tag
    awful.key({ modk }, "Escape",
        awful.tag.history.restore,
        {description = "go back", group = "tag"}),

    -- layout
    awful.key({ modk }, "space",
        function () awful.layout.inc(1) end,
        {description = "select next layout", group = "layout"}),
    awful.key({ modk, "Shift" }, "space",
        function () awful.layout.inc(-1) end,
        {description = "select previous layout", group = "layout"}),
    awful.key({ modk }, "l",
        function () awful.tag.incmwfact(0.05) end,
        {description = "increase master width factor", group = "layout"}),
    awful.key({ modk }, "h",
        function () awful.tag.incmwfact(-0.05) end,
        {description = "decrease master width factor", group = "layout"}),
    awful.key({ modk, "Shift" }, "h",
        function () awful.tag.incnmaster(1, nil, true) end,
        {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modk, "Shift" }, "l",
        function () awful.tag.incnmaster(-1, nil, true) end,
        {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modk, "Control" }, "h",
        function () awful.tag.incncol(1, nil, true) end,
        {description = "increase the number of columns", group = "layout"}),
    awful.key({ modk, "Control" }, "l",
        function () awful.tag.incncol(-1, nil, true) end,
        {description = "decrease the number of columns", group = "layout"}),

    -- navigation
    awful.key({ modk }, "j",
        function () awful.client.focus.byidx(1) end,
        {description = "focus next by index", group = "navigation"}),
    awful.key({ modk }, "k",
        function () awful.client.focus.byidx(-1) end,
        {description = "focus previous by index", group = "navigation"}),
    awful.key({ modk }, "u",
        awful.client.urgent.jumpto,
        {description = "jump to urgent client", group = "navigation"}),
    awful.key({ modk }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "navigation"}),

    -- client
    awful.key({ modk, "Shift" }, "j",
        function () awful.client.swap.byidx(1) end,
        {description = "swap with next client by index", group = "client"}),
    awful.key({ modk, "Shift" }, "k",
        function () awful.client.swap.byidx(-1) end,
        {description = "swap with previous client by index", group = "client"}),
    awful.key({ modk, "Control" }, "n",
        -- TODO change with new version
        -- https://awesomewm.org/apidoc/core_components/client.html#minimized
        function ()
            local c = awful.client.restore()
            if c then
                c:emit_signal("request::activate", "key.unminimize", {raise = true})
            end
        end,
        {description = "restore minimized", group = "client"})
)

-- tag specific keys
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        awful.key({ modk }, "#" .. i + 9,
            function ()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    tag:view_only()
                end
            end,
            {description = "view tag #"..i, group = "tag"}),
        awful.key({ modk, "Control" }, "#" .. i + 9,
            function ()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    awful.tag.viewtoggle(tag)
                end
            end,
            {description = "toggle tag #" .. i, group = "tag"}),
        awful.key({ modk, "Shift" }, "#" .. i + 9,
            function ()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:move_to_tag(tag)
                    end
                end
            end,
            {description = "move focused client to tag #"..i, group = "tag"}),
        awful.key({ modk, "Control", "Shift" }, "#" .. i + 9,
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

-- client specific keys
clientkeys = gears.table.join(
    awful.key({ modk, "Shift" }, "c",
        function (c) c:kill() end,
        {description = "close", group = "client"}),
    awful.key({ modk }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ modk, "Control" }, "space",
        awful.client.floating.toggle,
        {description = "toggle floating", group = "client"}),
    awful.key({ modk }, "n",
        function (c)
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    awful.key({ modk }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "(un)maximize", group = "client"}),
    awful.key({ modk, "Control" }, "m",
        function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end ,
        {description = "(un)maximize vertically", group = "client"}),
    awful.key({ modk, "Shift" }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end ,
        {description = "(un)maximize horizontally", group = "client"}),
    awful.key({ modk, "Control" }, "Return",
        function (c) c:swap(awful.client.getmaster()) end,
        {description = "move to master", group = "client"}),
    awful.key({ modk }, "o",
        function (c) c:move_to_screen() end,
        {description = "move to screen", group = "client"}),
    awful.key({ modk }, "t",
        function (c) c.ontop = not c.ontop end,
        {description = "toggle keep on top", group = "client"})
)

-- set keys
root.keys(globalkeys)


--
-- rules
--

awful.rules.rules = {
    -- all clients
    {
        rule = { },
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = false,
            keys = clientkeys,
            buttons = clientbuttons,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap+awful.placement.no_offscreen,
        },
        callback = awful.client.setslave,
    },

    -- floating
    {
        rule_any = {
            instance = {
                "DTA", -- firefox addon DownThemAll
                "copyq", -- includes session name in class
                "pinentry",
            },
            class = {
                "Arandr",
                "Blueman-manager",
                "Gpick",
                "Kruler",
                "MessageWin",  -- kalarm
                "Sxiv",
                "Tor Browser", -- needs a fixed window size to avoid fingerprinting by screen size
                "Wpa_gui",
                "veromix",
                "xtightvncviewer"
            },
            -- note that the name property shown in xprop might be set slightly after creation of the client
            -- and the name shown there might not match defined rules here
            name = {
                "Event Tester",  -- xev
            },
            role = {
                "AlarmWindow",  -- thunderbird's calendar
                "ConfigManager",  -- thunderbird's about:config
                "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools
            }
        },
        properties = {
            floating = true,
            placement = awful.placement.align.center,
        }
    },

    -- add titlebars to normal clients and dialogs
    --{
    --    rule_any = { type = { "normal", "dialog" } },
    --    properties = {
    --        titlebars_enabled = false,
    --    }
    --},

    -- set firefox to start on screen 1 tag 2
    --{
    --    rule = { class = "Firefox" },
    --    properties = {
    --        screen = 1,
    --        tag = "2",
    --    }
    --},

    -- TODO
    -- prevent steam friends windows to grab focus when fullscreen
    -- prevent firefox and steam sales windows to grad previous tag
}


--
-- signals
--

-- triggered when new client spawns
client.connect_signal("manage", function (c)
    -- TODO 'request::manage' on new version

    -- set new clients in slave stack
    -- if not awesome.startup then awful.client.setslave(c) end

    -- prevent clients from being unreachable after screen count changes
    if awesome.startup and not c.size_hints.user_position
            and not c.size_hints.program_position then
        awful.placement.no_offscreen(c)
    end
end)

-- triggered on focus change
client.connect_signal("focus", function(c)
    c.border_color = beautiful.border_focus
end)
client.connect_signal("unfocus", function(c)
    c.border_color = beautiful.border_normal
end)

-- triggered when mouse enters
client.connect_signal("mouse::enter", function(c)
    -- enable sloppy focus
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

-- trigger when titlebar is set
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c) : setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.floatingbutton(c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton(c),
            awful.titlebar.widget.ontopbutton(c),
            awful.titlebar.widget.closebutton(c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

