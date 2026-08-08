return {
    'nvim-lualine/lualine.nvim',
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "meuter/lualine-so-fancy.nvim",
    },
    config = function ()
        require("lualine").setup {
            options = {
                theme = 'auto',
                component_separators = "|",
                section_separators = { left = "", right = "" },
                always_divide_middle = false
            },
            sections = {
                lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } },
                lualine_b = { {"filename", path = 2}, "fancy_branch", {"diff", colored = true}},
                lualine_c = {},
                lualine_x = {},
                lualine_y = {
                    {
                        -- Lsp server name .
                        function()
                            local msg = 'No Active Lsp'
                            local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
                            local clients = vim.lsp.get_clients()
                            if next(clients) == nil then
                                return msg
                            end
                            for _, client in ipairs(clients) do
                                local filetypes = client.config.filetypes
                                if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                                    if client.name == 'null-ls' then
                                        msg = client.name
                                    else
                                        return client.name
                                    end
                                end
                            end
                            return msg
                        end,
                        icon = "󰌘",
                    },
                    {
                        'fileformat',
                        symbols = {
                            unix = '', -- e712
                            dos = '',  -- e70f
                            mac = '',  -- e711
                        }
                    },
                    "encoding",
                    "fancy_filetype",
                    "progress"
                },
                lualine_z = { { "location", separator = { right = "" }, left_padding = 2 } },
            },
            inactive_sections = {
                lualine_a = {"filename"},
                lualine_b = {},
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = {},
            },
            tabline = {
                lualine_a = {
                    {
                        "buffers",
                        separator = { left = "", right = "" },
                        right_padding = 2,
                        symbols = { alternate_file = "" },
                        max_length = vim.o.columns * 7 / 8,
                    },
                },
                lualine_z = {
                    "tabs",
                }
            },
        }
    end
}
