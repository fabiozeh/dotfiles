-- vscode-css-language-server: CSS, SCSS, Less
-- Install via Mason: :MasonInstall css-lsp
return {
    cmd = { "vscode-css-language-server", "--stdio" },
    filetypes = { "css", "scss", "less" },
    root_markers = { "package.json", ".git" },
    init_options = { provideFormatter = true },
}
