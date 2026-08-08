return {
    'glepnir/dashboard-nvim',
    event = 'VimEnter',
    config = function()
        require('dashboard').setup {
            theme = 'hyper',
            config = {
                week_header = {
                    enable = true,
                },
                shortcut = {
                    { desc = ' Update', group = '@property', action = 'Lazy update', key = 'u' },
                    {
                        desc = ' Restore Session',
                        group = 'DiagnosticHint',
                        action = 'Session',
                        key = 's',
                    },
                    {
                        desc = ' Neovim config files',
                        group = 'Number',
                        action = 'lua require("telescope.builtin").find_files {cwd="~/.config/nvim"}',
                        key = 'd',
                    },
                },
            },
        }
    end,
    dependencies = { {'nvim-tree/nvim-web-devicons'}}
}

