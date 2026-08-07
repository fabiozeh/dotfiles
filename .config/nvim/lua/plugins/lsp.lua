-- LSP configuration using Neovim 0.11+ native vim.lsp.config / vim.lsp.enable.
-- No nvim-lspconfig needed. Server definitions live in lsp/*.lua and are
-- picked up automatically by Neovim when vim.lsp.enable() is called.
--
-- Run :Mason to open the Mason UI and install/update server binaries.
-- Quick-install list: lua-language-server, typescript-language-server,
--   html-lsp, css-lsp, json-lsp, yaml-language-server, texlab
-- pyright is installed system-wide (/usr/bin/pyright-langserver)

return {
    -- Mason manages installing the server binaries into a consistent location.
    -- It also patches vim.env.PATH so bare binary names resolve correctly.
    -- Loaded on BufReadPre so Mason's PATH patch happens before any server starts.
    {
        "williamboman/mason.nvim",
        event = "BufReadPre",
        build = ":MasonUpdate",
        dependencies = {
            -- blink must be ready before Mason's config runs so we can call
            -- get_lsp_capabilities() and apply capabilities to all servers.
            "saghen/blink.cmp",
        },
        config = function()
            require("mason").setup()

            -- Apply blink.cmp's extended capabilities to every server globally.
            -- This must happen before servers start (i.e. before FileType fires).
            vim.lsp.config("*", {
                capabilities = require("blink.cmp").get_lsp_capabilities(),
            })

            -- qmlls: QML language server shipped with Qt 6 (qt6-declarative).
            -- System binary /usr/bin/qmlls6 — no Mason package. Defined inline
            -- here rather than in lsp/ since it has no per-project settings.
            -- For accurate import resolution, add a `.qmlls.ini` at the project
            -- root (CMake: set(QT_QML_GENERATE_QMLLS_INI ON)) or set the
            -- QMLLS_BUILD_DIRS env var; it works without one, just noisier.
            vim.lsp.config("qmlls", {
                cmd = { "qmlls6" },
                filetypes = { "qml", "qmljs" },
                root_markers = { ".qmlls.ini", "CMakeLists.txt", ".git" },
            })

            -- Enable servers whose full configs live in lsp/*.lua.
            -- Add / remove entries here when you install new servers.
            vim.lsp.enable({
                "lua_ls",
                "pyright",
                "c",
                "ts_ls",
                "html",
                "cssls",
                "jsonls",
                "yamlls",
                "texlab",
                "qmlls",
            })

            vim.lsp.config("c", {
                cmd = { "clangd" },
                filetypes = { "c", "h", "cpp" },
                root_markers = { "Makefile" }
            })

            -- ── Keymaps ──────────────────────────────────────────────────────
            -- Applied whenever any LSP attaches to a buffer.
            vim.api.nvim_create_autocmd("LspAttach", {
                desc = "LSP keymaps",
                callback = function(event)
                    local buf = event.buf
                    local function map(modes, lhs, rhs, desc)
                        vim.keymap.set(modes, lhs, rhs, { buffer = buf, desc = desc })
                    end

                    map("n", "K",         vim.lsp.buf.hover,          "Hover documentation")
                    map("n", "gd",        vim.lsp.buf.definition,     "Go to definition")
                    map("n", "gD",        vim.lsp.buf.declaration,    "Go to declaration")
                    map("n", "gi",        vim.lsp.buf.implementation, "Go to implementation")
                    map("n", "go",        vim.lsp.buf.type_definition,"Go to type definition")
                    map("n", "gr",        vim.lsp.buf.references,     "Find references")
                    map("n", "gs",        vim.lsp.buf.signature_help, "Signature help")
                    map("n", "<F2>",      vim.lsp.buf.rename,         "Rename symbol")
                    map({"n","x"}, "<F3>",
                        function() vim.lsp.buf.format({ async = true }) end, "Format buffer")
                    map("n", "<F4>",      vim.lsp.buf.code_action,    "Code action")
                    map({"n","v"}, "<leader>gf",
                        function() vim.lsp.buf.format({ async = true }) end, "Format")
                    map("n", "gl",        vim.diagnostic.open_float,  "Open diagnostics float")
                    map("n", "<F9>",      function() vim.diagnostic.jump({count = -1}) end,   "Previous diagnostic")
                    map("n", "<F10>",     function() vim.diagnostic.jump({count = 1}) end,   "Next diagnostic")
                end,
            })

            -- ── Diagnostics ───────────────────────────────────────────────────
            vim.diagnostic.config({
                virtual_text    = true,
                signs           = true,
                update_in_insert = false,
                underline       = true,
                severity_sort   = true,
                float           = { border = "rounded" },
            })
        end,
    },

    -- lazydev: Neovim Lua API type annotations and completions.
    -- Only active for lua files; works alongside blink.cmp automatically.
    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                -- Include luv types when vim.uv is referenced
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },
}
