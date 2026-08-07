-- ── Editor settings ───────────────────────────────────────────────────────────
vim.opt.number      = true
vim.opt.scrolloff   = 8
vim.opt.tabstop     = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth  = 4
vim.opt.autoindent  = true
vim.opt.expandtab   = true
vim.opt.hlsearch    = false
vim.opt.incsearch   = true
vim.opt.helpheight  = 38
vim.opt.winborder   = "rounded"
-- vim.opt.clipboard = "unnamed,unnamedplus"

vim.g.mapleader = " "

-- ── Navigation ────────────────────────────────────────────────────────────────

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half-page down (centred)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half-page up (centred)" })
vim.keymap.set("i", "jk",    "<Esc>",    { desc = "Escape insert mode" })

-- ── Buffer management ─────────────────────────────────────────────────────────
vim.keymap.set("n", "<leader>]", vim.cmd.bn,   { desc = "Next buffer" })
vim.keymap.set("n", "<leader>[", vim.cmd.bp,   { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>w", vim.cmd.bd,   { desc = "Delete buffer" })
vim.keymap.set("n", "<leader>n", vim.cmd.enew, { desc = "New buffer" })

-- ── LSP (quick access) ────────────────────────────────────────────────────────
-- Full LSP keymaps are set on LspAttach in lua/plugins/lsp.lua.
-- This one is buffer-independent (works before any server attaches).
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })

-- ── Filetype hooks ────────────────────────────────────────────────────────────
-- :make in a Python buffer runs the current file
vim.api.nvim_create_autocmd("FileType", {
    pattern  = "python",
    callback = function() vim.opt_local.makeprg = "python %" end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern  = "c",
    callback = function() vim.opt_local.makeprg = "cc %" end,
})
-- ── Extra keymaps ────────────────────────────────────────────────────────────

vim.keymap.set("n", "<leader>kr", ':enew<cr><cmd>r!openssl aes-256-cbc -d -a -pbkdf2 -k s\\%8c\\$e00 -in ~/.bb2<cr>')
vim.keymap.set("n", "<leader>kw", ':%!openssl aes-256-cbc -e -a -pbkdf2 -k s\\%8c\\$e00 <cr><cmd>saveas! ~/.bb2<cr><bar>bd<cr>')

-- ── Cosmetic ──────────────────────────────────────────────────────────────────
-- Brief highlight of yanked region
vim.api.nvim_create_autocmd("TextYankPost", {
    group    = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
    pattern  = "*",
    desc     = "Highlight yanked text",
    callback = function()
        vim.highlight.on_yank({ timeout = 200, visual = true })
    end,
})

-- ── LSP ───────────────────────────────────────────────────────────────────────

vim.lsp.enable({"c"})

vim.lsp.config("c", {
cmd = { "clangd" },
filetypes = { "c", "h", "cpp" },
root_markers = { "Makefile" }
})

-- ── Plugin manager (lazy.nvim) ────────────────────────────────────────────────
-- vim.pack (native, 0.12+) has no lazy-loading support, so we keep lazy.nvim
-- for fast startup times.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Each file under lua/plugins/ is a plugin spec or a table of specs.
require("lazy").setup("plugins")

vim.cmd.colorscheme = "humdrum"
