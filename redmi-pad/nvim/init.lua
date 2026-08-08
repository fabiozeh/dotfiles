vim.opt.number = true
vim.opt.scrolloff = 10
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.foldcolumn = "3"
vim.opt.helpheight = 38
-- vim.opt.clipboard = "unnamed,unnamedplus"

vim.g.python3_host_prog='/home/fabio/venv/bin/python3'

vim.g.mapleader = " "

vim.keymap.set("n", "<C-d>", "<C-d>zz") -- center cursor when moving half a page
vim.keymap.set("n", "<C-u>", "<C-u>zz") -- center cursor when moving half a page
vim.keymap.set("n", "0", "^") -- easy go to first char in line
vim.keymap.set("i", "jk", "<Esc>") -- easy Esc
-- vim.keymap.set("i", "<C-s>", "<cmd>lua vim.lsp.buf.signature_help()<cr>")

vim.keymap.set("n", "<leader>]", vim.cmd.bn, {desc="Next Buffer"})
vim.keymap.set("n", "<leader>[", vim.cmd.bp, {desc="Previous Buffer"})
vim.keymap.set("n", "<leader>w", vim.cmd.bd, {desc="Delete Buffer"})
vim.keymap.set("n", "<leader>n", vim.cmd.enew, {desc="New Buffer"})
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {desc="Rename Variable"})

vim.keymap.set("v", "il", "g_o^") -- inner line
vim.keymap.set("o", "il", ":normal vil<CR>")


-- Telescope
vim.keymap.set("n", "<leader>fg", function()
    require("telescope.builtin").git_files()
    end,
    {desc="Telescope Git Files."})
vim.keymap.set("n", "<leader>fl", function()
    require("telescope.builtin").live_grep()
    end,
    {desc="Telescope Live Grep."})
vim.keymap.set("n", "<leader>fr", function()
    require("telescope.builtin").lsp_references()
    end, {desc="Telescope Find LSP References."})
vim.keymap.set("n", "<leader>ft", function()
    require("telescope.builtin").treesitter()
    end, {desc="Telescope Find symbol in buffer (Treesitter)."})
vim.keymap.set("n", "<leader>fo", function()
    require("telescope.builtin").oldfiles()
    end, {desc="Telescope Find recently open files."})
vim.keymap.set("n", "<leader>ff", function()
    require("telescope.builtin").find_files({opts={
        cwd=vim.fn.expand "%:p:h"}})
    end,
    {desc="Telescope Find Files."})
vim.keymap.set("n", "<leader>fd", function()
    require("telescope.builtin").find_files({
        cwd="~/.config/nvim/",
        })
    end,
    {desc="Dotfiles no Telescope."})

-- session
vim.api.nvim_create_user_command("SaveSession", function() vim.cmd.mksession({args={"~/.vimsession.vim"}, bang=true}) end, {})
vim.api.nvim_create_user_command("Bye", function() vim.cmd.SaveSession() vim.cmd.wq() end, {})
vim.api.nvim_create_user_command("Session", function () vim.cmd.so("~/.vimsession.vim") end, {})

-- start Pyright
vim.api.nvim_create_user_command("Pyright", function () vim.lsp.start({name="pyright", cmd={"/home/fabio/.local/share/nvim/mason/bin/pyright-langserver", "--stdio"}}) end, {})

-- adjust the make command for Python files
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.opt_local.makeprg = "python %"
    vim.opt_local.shellpipe = "2>&1 | tee"
  end,
})

-- highlight yank
vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
    pattern = "*",
    desc = "Highlight selection on yank.",
    callback = function()
        vim.highlight.on_yank({ timeout = 200, visual = true })
    end,
})

vim.keymap.set('n', '<leader>kr', '<cmd>r!source ~/.config/my_scripts/readpwd.sh<CR>')

vim.api.nvim_create_user_command("LualineTheme", function (t) require("lualine").setup({options = {theme = t.args}}) end, {nargs = '*'})


local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim",
    -- "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


require("lazy").setup('plugins')

vim.cmd.colorscheme('retrobox')
