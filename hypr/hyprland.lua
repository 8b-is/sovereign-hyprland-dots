-- ══════════════════════════════════════════════════════════════════════════════
-- SOVEREIGN 8b.is × QWAVE × MACCRACKEN × NOCTALIA AI WORKSTATION (Lua)
-- Zero-Password Boot · 100% Pure-Rust HUD · C64 64KB Ring · Zero-Float Salience
-- Constellation Ink × Neon Jungle × Catppuccin Mocha (#05060a / #00f0ff / #cba6f7 / #62e6c9 / #e8b05c)
-- hapi: drift-audit 2026-11-06 — merged macCracken/dotfiles (hyprlock, hypridle,
--       mocha, neon_jungle glass blur, 6-curve animations) + Noctalia AGY/BongoCat dock
-- Validated for Hyprland 0.57.1+ Lua Engine
-- ══════════════════════════════════════════════════════════════════════════════

------------------
---- MONITORS ----
------------------
hl.monitor({
    output   = "DP-2",
    disabled = true,
})

hl.monitor({
    output    = "desc:Apple Computer Inc ProDisplayXDR 0x0F090B03",
    mode      = "5120x2880@60",
    position  = "2560x0",
    scale     = 2,
    vrr       = 0,
    transform = 3,
})

hl.monitor({
    output    = "desc:Apple Computer Inc ProDisplayXDR 0x340F0A03",
    mode      = "preferred",
    position  = "0x1080",
    scale     = 2,
    vrr       = 0,
    transform = 0,
})

hl.monitor({
    output   = "HDMI-A-1",
    mode     = "3840x2160@60",
    position = "0x0",
    scale    = 2,
    vrr      = 0,
})

hl.monitor({
    output   = "HDMI-A-2",
    mode     = "3840x2160@60",
    position = "4000x0",
    scale    = 2,
    vrr      = 0,
})

hl.monitor({
    output   = "HDMI-A-3",
    mode     = "3840x2160@60",
    position = "4000x0",
    scale    = 2,
    vrr      = 0,
})

hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = 2,
    vrr      = 0,
})

-- Load user monitor & workspace layouts saved by nwg-displays (if present)
pcall(dofile, "/home/hue/.config/hypr/monitors.lua")
pcall(dofile, "/home/hue/.config/hypr/workspaces.lua")

---------------------
---- MY PROGRAMS ----
---------------------
local hud         = "/home/hue/.local/bin/qwave-hypr-hud"
local terminal    = "alacritty --working-directory /home/hue/8b-is"
local fileManager = "alacritty -e /home/hue/.local/bin/qwave /home/hue/8b-is/qwave/README.md"
local menu        = "sh -c 'noctalia msg panel-toggle launcher || wofi --show drun || fuzzel'"
local browser     = "chromium http://127.0.0.1:8787 https://cheet.is/a6000 https://g8t.is https://gemini-diary.8b.is"

-------------------
---- AUTOSTART ----
-------------------
hl.on("hyprland.start", function ()
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP HYPRLAND_INSTANCE_SIGNATURE")
    hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP HYPRLAND_INSTANCE_SIGNATURE")
    hl.exec_cmd(hud .. " boot-session")
    hl.exec_cmd(hud .. " smoke-bg 0")
    hl.exec_cmd("sh -c 'pidof hypridle >/dev/null 2>&1 || hypridle'")

    -- Workspace 1 (1:STUDIO): Interactive /home/hue/8b-is shell (AGY Studio & Qwave HUD launched idempotently by boot-session)
    hl.exec_cmd("[workspace 1 silent] " .. terminal)

    -- Workspace 2 (2:CONSTELLATION): ALEXIAI (:8787), cheet.is/a6000, g8t.is, gemini-diary.8b.is
    hl.exec_cmd("[workspace 2 silent] " .. browser)
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------
hl.env("AQ_DRM_DEVICES", "/dev/dri/by-path/pci-0000:00:02.0-card:/dev/dri/by-path/pci-0000:01:00.0-card")
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("GDK_BACKEND", "wayland,x11")
hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")
hl.env("OLLAMA_HOST", "127.0.0.1:11436")
hl.env("PATH", "/home/hue/.local/bin:/home/hue/.cargo/bin:/usr/local/bin:/usr/bin:/bin")

-----------------------------------------
---- PERSISTENT AI STUDIO WORKSPACES ----
-----------------------------------------
hl.workspace_rule({ workspace = "1", default_name = "1:STUDIO",        persistent = true })
hl.workspace_rule({ workspace = "2", default_name = "2:CONSTELLATION", persistent = true })
hl.workspace_rule({ workspace = "3", default_name = "3:QWAVE-LAB",     persistent = true })
hl.workspace_rule({ workspace = "4", default_name = "4:MODELS",        persistent = true })
hl.workspace_rule({ workspace = "5", default_name = "5:FLEET",         persistent = true })
hl.workspace_rule({ workspace = "6", default_name = "6:MUSIC",         persistent = true })

--------------------------------------------------------------------------
---- LOOK AND FEEL (Constellation Ink × Neon Jungle × Mocha Glass) -------
--------------------------------------------------------------------------
hl.config({
    general = {
        gaps_in  = 6,
        gaps_out = 12,

        border_size = 2,

        col = {
            active_border   = { colors = {"0xff00f0ff", "0xffcba6f7", "0xff62e6c9", "0xffe8b05c"}, angle = 45 },
            inactive_border = "0xff313244",
        },

        resize_on_border = true,
        allow_tearing    = false,
        layout           = "dwindle",
    },

    decoration = {
        rounding       = 12,
        rounding_power = 2,

        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled      = true,
            range        = 14,
            render_power = 3,
            color        = 0x6605060a,
        },

        blur = {
            enabled           = false,
            size              = 4,
            passes            = 1,
            new_optimizations = true,
            ignore_opacity    = true,
            vibrancy          = 0.22,
        },
    },

    animations = {
        enabled = true,
    },
})

-- macCracken/dotfiles 6-curve + spring animation suite
hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1} } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1} } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}    } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1} } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}  } })
hl.curve("snappy",         { type = "spring", mass = 1, stiffness = 280, dampening = 26 })

hl.animation({ leaf = "global",           enabled = true, speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",           enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",          enabled = true, speed = 4.79, spring = "snappy" })
hl.animation({ leaf = "windowsIn",        enabled = true, speed = 4.1,  spring = "snappy",       style = "popin 87%" })
hl.animation({ leaf = "windowsOut",       enabled = true, speed = 1.49, bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "fadeIn",           enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",          enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",             enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers",           enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",         enabled = true, speed = 4,    bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",        enabled = true, speed = 1.5,  bezier = "linear",       style = "fade" })
hl.animation({ leaf = "fadeLayersIn",     enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut",    enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",       enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn",     enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut",    enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 3,    spring = "snappy",       style = "slidevert" })
hl.animation({ leaf = "zoomFactor",       enabled = true, speed = 7,    bezier = "quick" })

hl.config({
    dwindle = {
        preserve_split = true,
        smart_resizing = true,
    },
    master = {
        new_status = "master",
    },
    scrolling = {
        fullscreen_on_one_column = true,
    },
    misc = {
        force_default_wallpaper  = 0,
        disable_hyprland_logo    = true,
        disable_splash_rendering = true,
        vrr                      = 0,
    },
    input = {
        kb_layout    = "us",
        follow_mouse = 1,
        sensitivity  = 0,
        touchpad = {
            natural_scroll = true,
        },
    },
})

hl.gesture({
    fingers   = 3,
    direction = "horizontal",
    action    = "workspace",
})

---------------------
---- KEYBINDINGS ----
---------------------
local mainMod = "SUPER"

-- 1. Sovereign AI Development & Voice Hotkeys (100% Pure-Rust qwave-hypr-hud)
hl.bind(mainMod .. " + O",              hl.dsp.exec_cmd(hud .. " ai-menu"))
hl.bind(mainMod .. " + X",              hl.dsp.exec_cmd(hud .. " ai-clip --mode explain"))
hl.bind(mainMod .. " + SHIFT + X",      hl.dsp.exec_cmd(hud .. " ai-clip --mode fix"))
hl.bind(mainMod .. " + SPACE",          hl.dsp.exec_cmd(hud .. " voice-type"))
hl.bind(mainMod .. " + V",              hl.dsp.exec_cmd(hud .. " voice-type"))
hl.bind(mainMod .. " + A",              hl.dsp.exec_cmd(hud .. " ask-aye"))
hl.bind(mainMod .. " + M",              hl.dsp.exec_cmd(hud .. " toggle-ear"))
hl.bind(mainMod .. " + SHIFT + M",      hl.dsp.exec_cmd("nwg-displays"))
hl.bind(mainMod .. " + D",              hl.dsp.exec_cmd(hud .. " markdown-hud"))
hl.bind(mainMod .. " + G",              hl.dsp.exec_cmd(hud .. " a6000-pulse"))
hl.bind(mainMod .. " + I",              hl.dsp.exec_cmd("alacritty --class agy-terminal -T '8b.is Sovereign AGY Studio (Resumed)' --working-directory /home/hue/8b-is -e " .. hud .. " agy-resume"))
hl.bind(mainMod .. " + SHIFT + Return", hl.dsp.exec_cmd("alacritty --class agy-terminal -T '8b.is Sovereign AGY Studio (Resumed)' --working-directory /home/hue/8b-is -e " .. hud .. " agy-resume"))
hl.bind(mainMod .. " + W",              hl.dsp.exec_cmd(hud .. " wifi-menu"))
hl.bind(mainMod .. " + SHIFT + W",      hl.dsp.exec_cmd(hud .. " wifi-tui"))
hl.bind(mainMod .. " + N",              hl.dsp.exec_cmd("noctalia msg panel-toggle control-center"))
hl.bind(mainMod .. " + U",              hl.dsp.exec_cmd(hud .. " vault-menu"))
hl.bind(mainMod .. " + T",              hl.dsp.exec_cmd(hud .. " tokyo-song"))
hl.bind(mainMod .. " + Y",              hl.dsp.exec_cmd(hud .. " humayian-mix"))
hl.bind(mainMod .. " + SHIFT + P",      hl.dsp.exec_cmd(hud .. " phoenix-menu"))
hl.bind(mainMod .. " + CTRL + P",       hl.dsp.exec_cmd(hud .. " phoenix-preset next"))

-- 1b. Noctalia Plugins & macCracken Lock / Wallpaper / Notes / Docker / Process Monitor
hl.bind(mainMod .. " + SHIFT + ESCAPE", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + CTRL + B",       hl.dsp.exec_cmd("noctalia msg bar-toggle"))
hl.bind(mainMod .. " + CTRL + W",       hl.dsp.exec_cmd("noctalia msg desktop-widgets-toggle"))
hl.bind(mainMod .. " + CTRL + N",       hl.dsp.exec_cmd("noctalia msg panel-toggle noctalia/notes:panel"))
hl.bind(mainMod .. " + CTRL + D",       hl.dsp.exec_cmd("noctalia msg panel-toggle 8bury/mini-docker:manager"))
hl.bind(mainMod .. " + CTRL + M",       hl.dsp.exec_cmd("noctalia msg panel-toggle yahya637/process-monitor:panel"))
hl.bind(mainMod .. " + period",         hl.dsp.exec_cmd("noctalia msg launcher-open /kaomoji"))
hl.bind(mainMod .. " + ALT + W",        hl.dsp.exec_cmd("noctalia msg wallpaper-random"))

-- 2. Self-Healing AI Scratchpads (Dropdown Terminal, Live Qwave/AI Radar, Live GPU/CPU btop)
hl.bind(mainMod .. " + grave",          hl.dsp.exec_cmd(hud .. " scratchpad term"))
hl.bind(mainMod .. " + semicolon",      hl.dsp.exec_cmd(hud .. " scratchpad term"))
hl.bind(mainMod .. " + Z",              hl.dsp.exec_cmd(hud .. " scratchpad qwave"))
hl.bind(mainMod .. " + SHIFT + D",      hl.dsp.exec_cmd(hud .. " scratchpad qwave"))
hl.bind(mainMod .. " + SHIFT + G",      hl.dsp.exec_cmd(hud .. " scratchpad btop"))

-- 3. Core Studio Launchers & Screenshots
hl.bind(mainMod .. " + Return",         hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + B",              hl.dsp.exec_cmd(hud .. " markdown-hud"))
hl.bind(mainMod .. " + SHIFT + B",      hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + R",              hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + E",              hl.dsp.exec_cmd(fileManager))
hl.bind("Print",                        hl.dsp.exec_cmd("sh -c 'grim -g \"$(slurp)\" - | wl-copy && notify-send \"Sovereign Capture [+]\" \"Region copied to Wayland clipboard\"'"))
hl.bind(mainMod .. " + Print",          hl.dsp.exec_cmd("sh -c 'grim -g \"$(slurp)\" - | wl-copy && notify-send \"Sovereign Capture [+]\" \"Region copied to Wayland clipboard\"'"))
hl.bind(mainMod .. " + SHIFT + S",      hl.dsp.exec_cmd("sh -c 'grim -g \"$(slurp)\" - | wl-copy && notify-send \"Sovereign Capture [+]\" \"Region copied to Wayland clipboard\"'"))

-- 4. Window & Layout Management
hl.bind(mainMod .. " + Q",              hl.dsp.window.close())
hl.bind(mainMod .. " + C",              hl.dsp.window.close())
hl.bind(mainMod .. " + F",              hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + SHIFT + F",      hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P",              hl.dsp.window.pseudo())
hl.bind(mainMod .. " + S",              hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + backslash",      hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + CTRL + R",       hl.dsp.reload_config())

-- 5. Focus Navigation (Complete Arrow & Vim H/J/K/L)
hl.bind(mainMod .. " + left",           hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right",          hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",             hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",           hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + H",              hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + J",              hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + K",              hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + L",              hl.dsp.focus({ direction = "right" }))

-- 6. Swap / Move Windows (SUPER + SHIFT + Arrow / H/J/K/L)
hl.bind(mainMod .. " + SHIFT + left",   hl.dsp.window.swap({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + right",  hl.dsp.window.swap({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + up",     hl.dsp.window.swap({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + down",   hl.dsp.window.swap({ direction = "down" }))
hl.bind(mainMod .. " + SHIFT + H",      hl.dsp.window.swap({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + J",      hl.dsp.window.swap({ direction = "down" }))
hl.bind(mainMod .. " + SHIFT + K",      hl.dsp.window.swap({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + L",      hl.dsp.window.swap({ direction = "right" }))

-- 7. Fine Keyboard Window Resizing (SUPER + CTRL + Arrow / H/J/K/L)
hl.bind(mainMod .. " + CTRL + left",    hl.dsp.window.resize({ x = -60, y = 0 }), { repeating = true })
hl.bind(mainMod .. " + CTRL + right",   hl.dsp.window.resize({ x = 60,  y = 0 }), { repeating = true })
hl.bind(mainMod .. " + CTRL + up",      hl.dsp.window.resize({ x = 0,   y = -60 }), { repeating = true })
hl.bind(mainMod .. " + CTRL + down",    hl.dsp.window.resize({ x = 0,   y = 60 }),  { repeating = true })
hl.bind(mainMod .. " + CTRL + H",       hl.dsp.window.resize({ x = -60, y = 0 }), { repeating = true })
hl.bind(mainMod .. " + CTRL + L",       hl.dsp.window.resize({ x = 60,  y = 0 }), { repeating = true })
hl.bind(mainMod .. " + CTRL + K",       hl.dsp.window.resize({ x = 0,   y = -60 }), { repeating = true })
hl.bind(mainMod .. " + CTRL + J",       hl.dsp.window.resize({ x = 0,   y = 60 }),  { repeating = true })

-- 8. Switch Workspaces (SUPER + [0-9]) & Move Active Window (SUPER + SHIFT + [0-9])
for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Multimedia, PipeWire Volume, Mic Mute & Brightness keys
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })
hl.bind("XF86AudioNext",         hl.dsp.exec_cmd("playerctl next"),                                 { locked = true })
hl.bind("XF86AudioPause",        hl.dsp.exec_cmd("playerctl play-pause"),                           { locked = true })
hl.bind("XF86AudioPlay",         hl.dsp.exec_cmd("playerctl play-pause"),                           { locked = true })
hl.bind("XF86AudioPrev",         hl.dsp.exec_cmd("playerctl previous"),                             { locked = true })

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------
hl.window_rule({
    name           = "suppress-maximize-events",
    match          = { class = ".*" },
    suppress_event = "maximize",
})

hl.window_rule({
    name     = "fix-xwayland-drags",
    match    = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },
    no_focus = true,
})

hl.window_rule({
    name   = "float-agy-terminal",
    match  = { class = "agy-terminal" },
    float  = true,
    size   = "1280 800",
    center = true,
})

hl.window_rule({
    name   = "float-wifi-manager",
    match  = { class = "wifi-manager" },
    float  = true,
    size   = "960 640",
    center = true,
})

hl.window_rule({
    name   = "float-ai-dialog",
    match  = { class = "ai-floating" },
    float  = true,
    size   = "1120 720",
    center = true,
})

hl.window_rule({
    name   = "float-ai-scratch-term",
    match  = { class = "ai-scratch-term" },
    float  = true,
    size   = "1220 720",
    center = true,
})

hl.window_rule({
    name   = "float-qwave-radar",
    match  = { class = "qwave-radar" },
    float  = true,
    size   = "1260 760",
    center = true,
})

hl.window_rule({
    name   = "float-btop-hud",
    match  = { class = "btop-hud" },
    float  = true,
    size   = "1260 760",
    center = true,
})
