return {
    'joshdick/onedark.vim',
    'yorickpeterse/vim-paper',
    'bdesham/biogoo',
    'rebelot/kanagawa.nvim',
    {
        'nvim-tree/nvim-web-devicons',
        lazy = true, -- vai ser carregado pelos demais
    },
    {
        "folke/zen-mode.nvim",
        cmd = "ZenMode",
        opts = {
            window = {
                width = .80
            }
        }
    },
    {
        'simrat39/symbols-outline.nvim',
        cmd = { 'SymbolsOutline' },
    },
    {
        'folke/trouble.nvim',
        cmd = { 'TroubleToggle', 'Trouble' }
    },
    {
        'tpope/vim-commentary',
        event = 'BufReadPre',
    },
    {
        'brenoprata10/nvim-highlight-colors',
        cmd = { 'HighlightColorsOn', 'HighlightColorsToggle' },
    },
    {
        'rcarriga/nvim-notify',
        lazy = true,
    },
    {
        'junegunn/vim-peekaboo',
    },
    {
        'nvimtools/none-ls.nvim',
        config = function ()
            local nonels = require('null-ls')
            nonels.setup({
                sources = {
                    nonels.builtins.formatting.stylua,
                    -- nonels.builtins.completion.spell,
                    nonels.builtins.formatting.black,
                    -- require("none-ls.diagnostics.eslint"), -- requires none-ls-extras.nvim
                },
            })
        end
    },
    {
        'aklt/plantuml-syntax',
    },
}
