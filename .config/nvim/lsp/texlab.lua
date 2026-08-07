-- texlab: LaTeX language server (completions, diagnostics, formatting)
-- Install via Mason: :MasonInstall texlab
return {
    cmd = { "texlab" },
    filetypes = { "tex", "plaintex", "bib" },
    root_markers = { ".latexmkrc", ".git" },
    settings = {
        texlab = {
            build = {
                onSave = false, -- set to true to auto-build on save
            },
            chktex = { onOpenAndSave = true },
        },
    },
}
