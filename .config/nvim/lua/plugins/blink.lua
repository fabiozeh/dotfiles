-- blink.cmp: completion engine.
-- TAB / S-TAB navigate and accept completions (super-tab preset).
-- Copilot ghost text is separate (copilot.lua) and does NOT use TAB.

return {
    "saghen/blink.cmp",
    version = "*",
    dependencies = {
        "rafamadriz/friendly-snippets",
        -- lazydev integration: Neovim Lua API completions score at the top
        "folke/lazydev.nvim",
    },

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        keymap = { preset = "super-tab" },

        appearance = {
            nerd_font_variant = "mono",
        },

        completion = {
            documentation = {
                auto_show       = true,
                auto_show_delay_ms = 0,
            },
        },

        signature = { enabled = true },

        sources = {
            default = { "lazydev", "lsp", "path", "snippets", "buffer" },
            providers = {
                lazydev = {
                    name   = "LazyDev",
                    module = "lazydev.integrations.blink",
                    -- Bubble lazydev completions above LSP suggestions
                    score_offset = 100,
                },
                cmdline = { enabled = false },
            },
        },
    },
}
