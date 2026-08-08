return {
    {
        "GCBallesteros/jupytext.nvim",
        config = function()
            require("jupytext").setup(
                {
                    style = "hydrogen",
                    output_extension = "auto",  -- Default extension. Don't change unless you know what you are doing
                    force_ft = 'python',  -- Default filetype. Don't change unless you know what you are doing
                    custom_language_formatting = {}
                    -- custom_language_formatting = {
                    --     python = {
                    --         extension = "py",
                    --         style = "percent",
                    --         force_ft = "markdown", -- you can set whatever filetype you want here
                    --     },
                    -- }
                }
            )
        end,
    },
    {
        'Vigemus/iron.nvim',
        config = function()
            local iron = require("iron.core")

            iron.setup {
                config = {
                    -- Whether a repl should be discarded or not
                    scratch_repl = true,
                    -- Your repl definitions come here
                    repl_definition = {
                        sh = {
                            -- Can be a table or a function that
                            -- returns a table (see below)
                            command = {"bash"}
                        },
                        python = {
                            command = { "ipython", "--no-autoindent" }, -- { "python3" },
                            format = require("iron.fts.common").bracketed_paste_python
                        }
                    },
                    -- How the repl window will be displayed
                    -- See below for more information
                    repl_open_cmd = "vertical botright 80 split" -- require('iron.view').bottom(40),
                },
                -- Iron doesn't set keymaps by default anymore.
                -- You can set them here or manually add keymaps to the functions in iron.core
                keymaps = {
                    send_motion = "<space>rr",
                    visual_send = "<space>rr",
                    send_file = "<space>rf",
                    -- send_line = "<space>sl",
                    -- send_paragraph = "<space>sp",
                    -- send_until_cursor = "<space>su",
                    -- send_mark = "<space>sm",
                    -- mark_motion = "<space>mc",
                    -- mark_visual = "<space>mc",
                    -- remove_mark = "<space>md",
                    -- cr = "<space>s<cr>",
                    -- interrupt = "<space>s<space>",
                    -- exit = "<space>sq",
                    -- clear = "<space>cl",
                },
                -- If the highlight is on, you can change how it looks
                -- For the available options, check nvim_set_hl
                highlight = {
                    italic = true
                },
                ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
            }

        end,
    }
    -- {
    --     "pappasam/nvim-repl",
    --     init = function()
    --         vim.g["repl_filetype_commands"] = {
    --             javascript = "node",
    --             python = "ipython --no-autoindent"
    --         }
    --     end,
    --     keys = {
    --         { "<leader>rt", "<cmd>ReplToggle<cr>", desc = "Toggle nvim-repl" },
    --         { "<leader>rc", "<cmd>ReplRunCell<cr>", desc = "nvim-repl run cell" },
    --     },
    -- }
}
