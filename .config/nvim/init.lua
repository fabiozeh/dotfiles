-- ── Editor settings ───────────────────────────────────────────────────────────
vim.opt.number      = true
vim.opt.scrolloff   = 10
vim.opt.tabstop     = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth  = 4
vim.opt.autoindent  = true
vim.opt.expandtab   = true
vim.opt.hlsearch    = false
vim.opt.incsearch   = true
vim.opt.foldcolumn  = "3"
vim.opt.helpheight  = 38
vim.opt.winborder   = "rounded"
-- vim.opt.clipboard = "unnamed,unnamedplus"

-- ── Leader ────────────────────────────────────────────────────────────────────
vim.g.mapleader = " "

-- ── Navigation ────────────────────────────────────────────────────────────────
-- Disable arrow keys (use hjkl)
vim.keymap.set({ "n", }, "<Up>",    "<nop>")
vim.keymap.set({ "n", }, "<Down>",  "<nop>")
vim.keymap.set({ "n", }, "<Left>",  "<nop>")
vim.keymap.set({ "n", }, "<Right>", "<nop>")

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half-page down (centred)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half-page up (centred)" })
vim.keymap.set("n", "0",     "^",        { desc = "Go to first non-blank char" })
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

vim.keymap.set('n', '<leader>dh', function()
  local enabled = vim.diagnostic.config().virtual_text
  vim.diagnostic.config({ virtual_text = not enabled })
end, { desc = 'Toggle diagnostic virtual text' })

-- ── Text objects ──────────────────────────────────────────────────────────────
vim.keymap.set("v", "il", "g_o^",           { desc = "Inner line (visual)" })
vim.keymap.set("o", "il", ":normal vil<CR>", { desc = "Inner line (operator)" })

-- ── Fuzzy finding ─────────────────────────────────────────────────────────────
-- All <leader>f… keymaps are defined in lua/plugins/picker.lua (snacks.nvim).
-- Quick reference:
--   <leader>ff  project files (git root aware)
--   <leader>fl  live grep in project
--   <leader>fg  git-tracked files only
--   <leader>fr  LSP references
--   <leader>ft  symbols in buffer
--   <leader>fo  recent files
--   <leader>fd  Neovim config files
--   <leader>fh  Hyprland config files
--   <leader>fH  help tags

-- ── Copilot ───────────────────────────────────────────────────────────────────
-- Ghost text keymaps are configured in lua/plugins/init.lua (copilot.lua).
-- Quick reference (insert mode):
--   <M-/>   request next suggestion
--   <M-CR>  accept full suggestion
--   <M-w>   accept next word
--   <M-[>   previous suggestion
--   <M-e>   dismiss

-- ── Session management ────────────────────────────────────────────────────────
vim.api.nvim_create_user_command("SaveSession",
    function() vim.cmd.mksession({ args = { "~/.vimsession.vim" }, bang = true }) end, {})
vim.api.nvim_create_user_command("Bye",
    function() vim.cmd.SaveSession() vim.cmd.wq() end, {})
vim.api.nvim_create_user_command("Session",
    function() vim.cmd.so("~/.vimsession.vim") end, {})

-- ── Filetype hooks ────────────────────────────────────────────────────────────
-- :make in a Python buffer runs the current file
vim.api.nvim_create_autocmd("FileType", {
    pattern  = "python",
    callback = function() vim.opt_local.makeprg = "python %" end,
})


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

-- Convenience command to switch lualine theme at runtime: :LualineTheme kanagawa
vim.api.nvim_create_user_command("LualineTheme",
    function(t) require("lualine").setup({ options = { theme = t.args } }) end,
    { nargs = "*" })

-- Remove the Tab mapping that blink.cmp sets when entering command-line mode
-- (otherwise Tab cycles the wildmenu, which conflicts)
vim.api.nvim_create_autocmd("CmdlineEnter", {
    pattern  = "*:",
    callback = function() pcall(vim.api.nvim_del_keymap, "c", "<Tab>") end,
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
