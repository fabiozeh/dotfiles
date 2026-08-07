hl.monitor({
    output = "eDP-1",
    mode = "1920x1080@60",
    position = "0x0",
    scale = 1
})
-- hl.monitor({
--     output = "DP-1",
--     mode = "1920x1080@60",
--     position = "1920x0",
--     scale = 1
-- })
hl.monitor({
    output = "DP-1",
    mode = "2560x1440@60",
    position = "1920x0",
    scale = 1
})

hl.config({
    input = {
        kb_layout = "us",
        kb_variant = "intl",
        -- kb_options = "grp:alt_space_toggle",
        numlock_by_default = true,
        repeat_delay = 250,
        repeat_rate = 35,
        follow_mouse = 1,
        off_window_axis_events = 2,
        touchpad = {
            natural_scroll = true,
            disable_while_typing = true,
            clickfinger_behavior = true,
            scroll_factor = 0.5
        }
    },
    group = {
        groupbar = {
            col = {
                active = "rgba(00000088)",
                inactive = "rgba(00000055)"
            },
            height = 25,
            font_size = 14,
            -- text_color = "0xFF000000",
            font_family = "Rubik",
            gradient_rounding_power = 4.0,
            gradient_rounding = 18,
            gradients = true,
            indicator_height = 0
        }
    }
})
