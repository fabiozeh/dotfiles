-- vscode-html-language-server: HTML with embedded CSS/JS awareness
-- Install via Mason: :MasonInstall html-lsp
return {
    cmd = { "vscode-html-language-server", "--stdio" },
    filetypes = { "html" },
    root_markers = { "package.json", ".git" },
    init_options = { provideFormatter = true },
}
