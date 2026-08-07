--! User
hl.bind("CTRL + SUPER + Slash", hl.dsp.exec_cmd("xdg-open ~/.config/illogical-impulse/config.json"),
    { description = "Edit shell config" })
hl.bind("CTRL + SUPER + ALT + Slash", hl.dsp.exec_cmd("xdg-open ~/.config/hypr/custom/keybinds.lua"),
    { description = "Edit extra keybinds" })

hl.unbind("SUPER + E")
hl.bind("SUPER + E", hl.dsp.exec_cmd("thunar"), { description = "App: File manager" })

hl.unbind("SUPER + T")
hl.bind("SUPER + T", hl.dsp.exec_cmd("hyprctl dispatch togglegroup"))

hl.bind("SUPER + Comma", hl.dsp.exec_cmd("hyprctl dispatch changegroupactive f"))
