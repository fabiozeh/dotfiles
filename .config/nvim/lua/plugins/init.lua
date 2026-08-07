-- Plugin manifest: colour schemes, utilities, and miscellaneous plugins.
-- LSP lives in lsp.lua, completion in blink.lua, fuzzy-finding in picker.lua.

return {
    -- ── Colour schemes ────────────────────────────────────────────────────────
    "navarasu/onedark.nvim",
    "yorickpeterse/vim-paper",
    "bdesham/biogoo",
    "rebelot/kanagawa.nvim",

    -- ── Icons (used by lualine, dashboard, etc.) ──────────────────────────────
    { "nvim-tree/nvim-web-devicons", lazy = true },

    -- ── Git gutter symbols ────────────────────────────────────────────────────
    -- Shows added/changed/deleted lines in the sign column.
    {
        "lewis6991/gitsigns.nvim",
        event = "BufReadPre",
        opts = {
            signs = {
                add          = { text = "│" },
                change       = { text = "│" },
                delete       = { text = "_" },
                topdelete    = { text = "‾" },
                changedelete = { text = "~" },
                untracked    = { text = "┆" },
            },
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns
                local function map(lhs, rhs, desc)
                    vim.keymap.set("n", lhs, rhs, { buffer = bufnr, desc = desc })
                end
                map("]g", gs.next_hunk,         "Next git hunk")
                map("[g", gs.prev_hunk,          "Prev git hunk")
                map("<leader>gp", gs.preview_hunk, "Preview hunk")
                map("<leader>gs", gs.stage_hunk,   "Stage hunk")
                map("<leader>gu", gs.undo_stage_hunk, "Unstage hunk")
                map("<leader>gb", gs.blame_line,   "Git blame line")
            end,
        },
    },

    -- ── Copilot ghost text ────────────────────────────────────────────────────
    -- auto_trigger = false: suggestions only appear when you explicitly ask.
    -- TAB is left entirely for blink.cmp completions.
    -- Keybindings:
    --   <M-/>   request / cycle to next suggestion
    --   <M-CR>  accept full suggestion
    --   <M-w>   accept next word only
    --   <M-[>   previous suggestion
    --   <M-e>   dismiss
    {
        "zbirenbaum/copilot.lua",
        cmd   = "Copilot",
        event = "InsertEnter",
        opts = {
            suggestion = {
                enabled     = true,
                auto_trigger = false,
                keymap = {
                    accept      = "<M-CR>",
                    accept_word = "<M-w>",
                    next        = "<M-/>",   -- also requests a suggestion if none shown
                    prev        = "<M-[>",
                    dismiss     = "<M-e>",
                },
            },
            panel = { enabled = false, keymap = { open = false } },
        },
    },

    -- ── Claude / AI chat ──────────────────────────────────────────────────────
    -- Non-intrusive: only opens when you invoke a command or keybinding.
    -- Requires ANTHROPIC_API_KEY in your environment.
    -- Keybindings:  <leader>cc  toggle chat
    --               <leader>ca  action menu (explain, refactor, test…)
    --               <leader>ci  inline prompt
    --               <leader>cv  (visual) add selection to chat
    {
        "olimorris/codecompanion.nvim",
        cmd  = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionActions" },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        keys = {
            { "<leader>cc", "<cmd>CodeCompanionChat Toggle<cr>", desc = "Claude chat toggle" },
            { "<leader>ca", "<cmd>CodeCompanionActions<cr>",     desc = "Claude actions" },
            { "<leader>ci", "<cmd>CodeCompanion<cr>",            desc = "Claude inline" },
            { "<leader>cv", "<cmd>CodeCompanionChat Add<cr>",    mode = "v",
              desc = "Add selection to Claude chat" },
        },
        opts = {
            adapters = {
                -- Falls back to ANTHROPIC_API_KEY in environment
                claude = function()
                    return require("codecompanion.adapters").extend("anthropic", {
                        schema = {
                            model = { default = "claude-opus-4-6" },
                        },
                    })
                end,
            },
            strategies = {
                chat   = { adapter = "claude" },
                inline = { adapter = "claude" },
                agent  = { adapter = "claude" },
            },
            display = {
                -- Narrow side-panel so it doesn't crowd your buffer
                chat = { window = { width = 0.30 } },
            },
        },
    },

    -- ── CopilotChat ───────────────────────────────────────────────────────────
    -- Kept alongside codecompanion; useful for Copilot-specific context.
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        cmd          = { "CopilotChat", "CopilotChatToggle" },
        dependencies = { "nvim-lua/plenary.nvim" },
        build        = "make tiktoken",
        opts         = {},
    },

    -- ── Markdown rendering ────────────────────────────────────────────────────
    -- Renders markdown (headers, code blocks, tables) directly in the buffer.
    {
        "MeanderingProgrammer/render-markdown.nvim",
        ft   = { "markdown", "codecompanion" },
        opts = { file_types = { "markdown", "codecompanion" } },
    },

    -- ── Formatting (non-LSP) ──────────────────────────────────────────────────
    -- stylua for Lua, black for Python.  Triggered via <F3> / <leader>gf.
    {
        "nvimtools/none-ls.nvim",
        event        = "BufReadPre",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local nls = require("null-ls")
            nls.setup({
                sources = {
                    nls.builtins.formatting.stylua,
                    nls.builtins.formatting.black,
                },
            })
        end,
    },

    -- ── Utilities ─────────────────────────────────────────────────────────────
    {
        "folke/zen-mode.nvim",
        cmd  = "ZenMode",
        opts = { window = { width = 0.80 } },
    },
    {
        "j-hui/fidget.nvim",
        version = "*", -- alternatively, pin this to a specific version, e.g., "1.6.1"
        opts = {
            -- options
        },
    },
    {
        "echasnovski/mini.splitjoin",
        config = true,
    },
    {
        "folke/trouble.nvim",
        cmd = { "TroubleToggle", "Trouble" },
    },
    {
        "brenoprata10/nvim-highlight-colors",
        cmd = { "HighlightColorsOn", "HighlightColorsToggle" },
    },
    {
        "junegunn/vim-peekaboo",  -- register preview on " and @
    },
    {
        "aklt/plantuml-syntax",
        ft = "plantuml",
    },
    {
        "cameron-wags/rainbow_csv.nvim",
        config = true,
        ft = { "csv", "tsv", "csv_semicolon", "csv_whitespace", "csv_pipe",
               "rfc_csv", "rfc_semicolon" },
        cmd = { "RainbowDelim", "RainbowDelimSimple", "RainbowDelimQuoted",
                "RainbowMultiDelim" },
    },
}
