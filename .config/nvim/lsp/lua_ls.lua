-- lua-language-server: types and completions for Lua + Neovim API
-- Install via Mason: :MasonInstall lua-language-server
return {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    root_markers = { ".luarc.json", ".luarc.jsonc", ".git" },
    settings = {
        Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = {
                -- Don't flag `vim` as an undefined global in Neovim configs
                globals = { "vim" },
            },
            workspace = {
                -- Pull in Neovim runtime types so completion works everywhere
                library = { vim.env.VIMRUNTIME },
                checkThirdParty = false,
            },
            telemetry = { enable = false },
        },
    },
}
