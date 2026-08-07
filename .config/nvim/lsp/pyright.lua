-- Pyright: static type checker + language server for Python
-- System-wide: /usr/bin/pyright-langserver
-- Or via Mason: :MasonInstall pyright
--
-- Alternative: basedpyright (stricter, community fork) — swap the cmd
-- and install with: pip install basedpyright
return {
    cmd = { "pyright-langserver", "--stdio" },
    filetypes = { "python" },
    root_markers = {
        "pyproject.toml", "setup.py", "setup.cfg",
        "requirements.txt", "Pipfile", ".git",
    },
    settings = {
        python = {
            analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                -- "openFilesOnly" avoids analysing the whole venv on every save
                diagnosticMode = "openFilesOnly",
            },
        },
    },
}
