return {
    'neovim/nvim-lspconfig',
    event = 'BufReadPre',
    dependencies = {
        {'williamboman/mason.nvim'},           -- Optional
        {'williamboman/mason-lspconfig.nvim'}, -- Optional
        -- Autocompletion
        {'saghen/blink.cmp'},
        --{'hrsh7th/nvim-cmp'},         -- Required
        --{'hrsh7th/cmp-nvim-lsp'},     -- Required
        --{'hrsh7th/cmp-buffer'},       -- Optional
        --{'hrsh7th/cmp-path'},         -- Optional
        --{'hrsh7th/cmp-nvim-lua'},     -- Optional
        --{'hrsh7th/cmp-nvim-lsp-signature-help'},

        -- Snippets
        --{'L3MON4D3/LuaSnip'},
        --{'saadparwaiz1/cmp_luasnip'},
        {'rafamadriz/friendly-snippets'}, -- Optional
        { "folke/lazydev.nvim",
            ft = "lua", -- only load on lua files
            opts = {
                library = {
                    -- See the configuration section for more details
                    -- Load luvit types when the `vim.uv` word is found
                    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                },
            },
        },
    },
    config = function()

        local lspconfig = require('lspconfig')

        --local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
        --lsp_capabilities.textDocument.completion.completionItem.snippetSupport = true

        local lsp_capabilities = require('blink.cmp').get_lsp_capabilities()
        lsp_capabilities.workspace = {
            didChangeWatchedFiles = {
                dynamicRegistration = false
            }
        }

        vim.api.nvim_create_autocmd('LspAttach', {
            desc = 'LSP actions',
            callback = function(event)
                local opts = {buffer = event.buf}

                vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
                vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
                vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
                vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
                vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
                vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
                vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
                vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
                vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
                vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)

                vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)
                vim.keymap.set('n', '<F9>', '<cmd>lua vim.diagnostic.goto_prev()<cr>', opts)
                vim.keymap.set('n', '<F10>', '<cmd>lua vim.diagnostic.goto_next()<cr>', opts)
            end
        })

        local default_setup = function(server)
            lspconfig[server].setup({
                capabilities = lsp_capabilities,
            })
        end

        require('mason').setup({})
        require('mason-lspconfig').setup({
            ensure_installed = {},
            handlers = {default_setup},
        })

        lspconfig.pyright.setup({ capabilities = lsp_capabilities })
        --lspconfig.lua_ls.setup({ capabilities = lsp_capabilities })

        lspconfig.clangd.setup({capabilities = lsp_capabilities })

        -- require("luasnip.loaders.from_vscode").lazy_load()

        --local cmp = require('cmp')
        --local luasnip = require('luasnip')

        --cmp.setup({
        --    snippet = {
        --        expand = function(args)
        --            luasnip.lsp_expand(args.body) -- For `luasnip` users.
        --        end,
        --    },
        --    window = {
        --        completion = cmp.config.window.bordered(),
        --        documentation = cmp.config.window.bordered(),
        --    },
        --    mapping = cmp.mapping.preset.insert({
        --        -- `Enter` key to confirm completion
        --        ['<CR>'] = cmp.mapping.confirm({select = false}),

        --        -- Ctrl+Space to trigger completion menu
        --        ['<C-Space>'] = cmp.mapping.complete(),

        --        -- Navigate between snippet placeholder

        --        -- Scroll up and down in the completion documentation
        --        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        --        ['<C-d>'] = cmp.mapping.scroll_docs(4),

        --        --['<Tab>'] = cmp_action.luasnip_supertab(),
        --        --['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
        --    }),
        --    sources = cmp.config.sources({
        --        { name = 'nvim_lsp' },
        --        { name = 'luasnip' }, -- For luasnip users.
        --        { name = 'nvim_lsp_signature_help' },
        --    })
        --})

        vim.diagnostic.config({
            virtual_text = true,
            signs = true,
            update_in_insert = false,
            underline = true,
            severity_sort = false,
            float = true,
        })

        -- (additional) keybinding for formatting
        vim.keymap.set({"n", "v"}, "<leader>gf", function()
            vim.lsp.buf.format({ async = true })
        end)
    end
}
