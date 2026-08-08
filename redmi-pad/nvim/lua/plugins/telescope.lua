return {
    {
        'nvim-telescope/telescope.nvim',
        version = '0.1.4',
        dependencies = { 'nvim-lua/plenary.nvim' },
        lazy = false,
        config = function()
            local uv = vim.loop

            -- Function to detect virtual environment folders and exclude recursively
            local function find_venv_folders()
                local venv_patterns = { "pyvenv.cfg" }
                local exclude_patterns = {}

                -- Helper function to recursively exclude a folder
                local function add_exclusion_pattern(path)
                    local normalized_path = path:gsub("%.", "%%."):gsub("%-", "%%-") -- Escape special characters
                    table.insert(exclude_patterns, "^" .. normalized_path .. "/.*")
                end

                -- Check if a directory contains a virtual environment marker
                local function check_dir(path)
                    for _, pattern in ipairs(venv_patterns) do
                        if uv.fs_stat(path .. "/" .. pattern) then
                            add_exclusion_pattern(path)
                            break
                        end
                    end
                end

                -- Scan the current project root for potential virtual environment folders
                for _, folder in ipairs(vim.fn.glob("./*", true, true)) do
                    if vim.fn.isdirectory(folder) == 1 then
                        check_dir(folder)
                    end
                end

                return exclude_patterns
            end

            -- Dynamically find and exclude venv folders
            local dynamic_exclusions = find_venv_folders()
            require('telescope').setup {
                defaults = {
                    file_ignore_patterns = dynamic_exclusions,
                },
            }

            --`require('telescope').load_extension('fzf')
        end
    },
}
