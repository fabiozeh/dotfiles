-- typescript-language-server: JS and TS support
-- Install via Mason: :MasonInstall typescript-language-server
return {
    cmd = { "typescript-language-server", "--stdio" },
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
}
