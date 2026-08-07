-- Re-enable blur for all windows (overrides base rule which disables it globally)
hl.window_rule({ match = { class = ".*" }, no_blur = false })

-- Floating app windows
hl.window_rule({ match = { class = "^(pomodorolm)$" }, float = true })
hl.window_rule({ match = { class = "^(pomodorolm)$" }, size = {288, 400} })
hl.window_rule({ match = { class = "^(pomodorolm)$" }, move = {1587, 268} })
hl.window_rule({ match = { class = "^(cameractrlsgtk)$" }, float = true })
