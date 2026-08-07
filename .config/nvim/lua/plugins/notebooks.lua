-- Jupyter notebook support via jupytext + molten-nvim.
--
-- Workflow:
--   1. Open a .ipynb file → jupytext converts it to a .py (percent format)
--   2. Run :MoltenInit to connect to (or start) a Jupyter kernel
--   3. Place cursor inside a cell and use <leader>mr / <leader>mc to execute
--   4. Output appears as virtual text below the cell
--
-- Prerequisites (Python side):
--   pip install pynvim jupyter_client ipython
--   (install any kernel you need: pip install ipykernel; python -m ipykernel install --user)
--
-- Image rendering:
--   Foot terminal does not support the kitty graphics protocol, so image output
--   is disabled (vim.g.molten_image_provider = "none").  Plain text, DataFrames,
--   and tracebacks all work fine.  If you ever switch to a kitty-compatible
--   terminal, install image.nvim and change the provider to "image.nvim".

return {
    -- jupytext.nvim: transparently opens .ipynb files as percent-format Python
    {
        "GCBallesteros/jupytext.nvim",
        -- Load when a .ipynb file is opened; jupytext CLI must be on PATH
        -- (pip install jupytext)
        ft = "ipynb",
        config = function()
            require("jupytext").setup({
                style            = "percent",
                output_extension = "py",
                force_ft         = "python",
            })
        end,
    },

    -- molten-nvim: interactive kernel execution inside Neovim
    {
        "benlubas/molten-nvim",
        version = "^1.0.0",
        build   = ":UpdateRemotePlugins",
        ft      = "python",   -- only activate for Python buffers
        init = function()
            -- Text-only output (no image backend for Foot terminal)
            vim.g.molten_image_provider    = "none"
            vim.g.molten_output_win_max_height = 20
            vim.g.molten_auto_open_output  = true
            vim.g.molten_wrap_output       = true
            -- Show a condensed inline summary above each cell's output window
            vim.g.molten_virt_text_output  = true
            vim.g.molten_virt_lines_off_by_1 = true
        end,
        keys = {
            { "<leader>mi", ":MoltenInit<CR>",
              desc = "Molten: init / attach kernel" },
            { "<leader>mr", ":MoltenEvaluateLine<CR>",
              desc = "Molten: run current line" },
            { "<leader>mc", ":MoltenEvaluateOperator<CR>",
              desc = "Molten: run motion (e.g. <leader>mcip for inner paragraph)" },
            { "<leader>mv", ":<C-u>MoltenEvaluateVisual<CR>",
              mode = "v", desc = "Molten: run visual selection" },
            { "<leader>mR", ":MoltenReevaluateCell<CR>",
              desc = "Molten: re-run cell" },
            { "<leader>mo", ":MoltenShowOutput<CR>",
              desc = "Molten: show output window" },
            { "<leader>mx", ":MoltenInterrupt<CR>",
              desc = "Molten: interrupt kernel" },
            { "<leader>md", ":MoltenDelete<CR>",
              desc = "Molten: delete cell output" },
        },
    },
}
