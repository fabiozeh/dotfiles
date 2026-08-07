-- vscode-json-language-server: JSON with schema validation
-- Install via Mason: :MasonInstall json-lsp
return {
    cmd = { "vscode-json-language-server", "--stdio" },
    filetypes = { "json", "jsonc" },
    root_markers = { ".git" },
    init_options = { provideFormatter = true },
}
