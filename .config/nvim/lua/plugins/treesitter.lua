-- nvim-treesitter: syntax highlighting, indentation, and text objects.

return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    config = function()
        local treesitter = require("nvim-treesitter")
        treesitter.setup()
        treesitter.install {
            -- Core / config
                "vim", "vimdoc", "lua",
            -- Web
                "html", "css", "javascript", "typescript",
            -- Python / notebooks
                "python",
            -- Data / config files
                "json", "yaml", "toml",
            -- Markup / docs
                "markdown", "markdown_inline",
            -- LaTeX
                "latex", "bibtex",
            -- QML (Qt)
                "qmljs",
        }
        vim.api.nvim_create_autocmd('FileType', {
            pattern = { "vim", "vimdoc", "lua", "html", "css", "javascript", "typescript",
                "python", "json", "yaml", "toml", "markdown", "markdown_inline",
                "latex", "bibtex", "qml" },
            callback = function()
            -- syntax highlighting, provided by Neovim
            vim.treesitter.start()
            -- folds, provided by Neovim
            -- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
            -- vim.wo.foldmethod = 'expr'
            -- indentation, provided by nvim-treesitter
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end,
            })
    end,
}
