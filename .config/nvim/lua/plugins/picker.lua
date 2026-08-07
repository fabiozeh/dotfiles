-- snacks.nvim: replaces Telescope with a simpler, faster picker.
-- Key design decisions:
--   • project root is detected via git / pyproject.toml / package.json,
--     falling back to the current buffer's directory
--   • fd respects .gitignore (drops node_modules, .venv, __pycache__ etc.)
--     as long as those dirs are listed there; explicit excludes below catch
--     projects that don't gitignore their venv
--   • specific searches for the Neovim config and Hyprland config dirs
--
-- Keybindings (all under <leader>f…):
--   ff  project files     fg  git-tracked files
--   fl  live grep         ft  LSP symbols in buffer
--   fr  LSP references    fo  recent files
--   fd  nvim config       fh  Hyprland config
--   fH  help tags

return {
    "folke/snacks.nvim",
    priority = 1000,  -- load early so other plugins can use Snacks.*
    lazy = false,
    ---@type snacks.Config
    opts = {
        picker = {
            sources = {
                files = {
                    -- Extra excludes on top of .gitignore.
                    -- fd flag syntax: each string is passed as a separate --exclude argument.
                    exclude = {
                        "node_modules", ".venv", "venv", "__pycache__",
                        ".mypy_cache", ".pytest_cache", "dist", "build",
                    },
                },
            },
        },
    },
    keys = {
        -- Helper: find the project root from the current buffer.
        -- Used in several bindings below as a local closure.

        -- Project files (git root → pyproject.toml → package.json → buffer dir)
        { "<leader>ff", function()
            local root = vim.fs.root(0, { ".git", "pyproject.toml", "package.json" })
                or vim.fn.expand("%:p:h")
            Snacks.picker.files({ cwd = root })
        end, desc = "Find project files" },

        -- Live grep across the project
        { "<leader>fl", function()
            local root = vim.fs.root(0, { ".git", "pyproject.toml", "package.json" })
                or vim.fn.expand("%:p:h")
            Snacks.picker.grep({ cwd = root })
        end, desc = "Live grep in project" },

        -- Git-tracked files only (useful to avoid untracked build artefacts)
        { "<leader>fg", function() Snacks.picker.git_files() end,
          desc = "Git files" },

        -- LSP references for symbol under cursor
        { "<leader>fr", function() Snacks.picker.lsp_references() end,
          desc = "LSP references" },

        -- LSP / treesitter symbols in the current buffer
        { "<leader>ft", function() Snacks.picker.lsp_symbols() end,
          desc = "Symbols in buffer" },

        -- Recently opened files
        { "<leader>fo", function() Snacks.picker.recent() end,
          desc = "Recent files" },

        -- Neovim config files
        { "<leader>fd", function()
            Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
        end, desc = "Find nvim config files" },

        -- Hyprland config files
        { "<leader>fh", function()
            Snacks.picker.files({ cwd = vim.fn.expand("~/.config/hypr") })
        end, desc = "Find Hyprland config files" },

        -- Help tags
        { "<leader>fH", function() Snacks.picker.help() end,
          desc = "Search help tags" },

        { "<leader>fn", function() Snacks.picker.notifications() end, desc = "Notification History"},

        { "<leader>e", function() Snacks.explorer() end, desc = "File Explorer"},

        { "<leader>sd", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics"},

        { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps"},

        { "<leader>uC", function() Snacks.picker.colorschemes() end, desc = "Colorschemes"},

        { "<leader>N", function()
            Snacks.win({
                file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
                width = 0.6,
                height = 0.6,
                wo = {
                    spell = false,
                    wrap = false,
                    signcolumn = "yes",
                    statuscolumn = " ",
                    conceallevel = 3,
                },
            })
        end, desc = "Neovim News", },
    },
}
