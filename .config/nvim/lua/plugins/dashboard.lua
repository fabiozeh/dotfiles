return {
    "glepnir/dashboard-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("dashboard").setup({
            theme = "hyper",
            config = {
                week_header = { enable = true },
                shortcut = {
                    { desc  = " Update",
                      group = "@property",
                      action = "Lazy update",
                      key   = "u" },
                    { desc  = " Restore Session",
                      group = "DiagnosticHint",
                      action = "Session",
                      key   = "s" },
                    { desc  = " Neovim config",
                      group = "Number",
                      -- Uses Snacks picker (see lua/plugins/picker.lua)
                      action = function()
                          Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
                      end,
                      key   = "d" },
                },
            },
        })
    end,
}
