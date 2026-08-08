return {
    {
        'mfussenegger/nvim-dap',
        config = function()
            local dap = require('dap')
            vim.keymap.set("n", "<leader>ds", function() dap.repl.open() end, {desc="Open DAP Repl"})
            vim.keymap.set("n", "<leader>db", function() dap.toggle_breakpoint() end, {desc="Toggle a breakpoint."})
            vim.keymap.set("n", "<F5>", function() dap.continue() end, {desc="Continue debugger execution."})
            vim.keymap.set("n", "<F6>", function() dap.step_over() end, {desc="Step the debugger over the current line."})
            vim.keymap.set("n", "<F7>", function() dap.step_into() end, {desc="Step the debugger into the current line."})
            vim.keymap.set("n", "<F8>", function() dap.step_out() end, {desc="Step the debugger out of the current line."})
            dap.listeners.after.event_initialized["setup_my_interface"] = function()
                dap.repl.open()
            end
        end
    },
    {
        'theHamsta/nvim-dap-virtual-text',
        config = function()
            require('nvim-dap-virtual-text').setup {
                virt_text_pos = 'eol'
            }
        end,
        dependencies = {"mfussenegger/nvim-dap"}
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"},
        config = function ()
            local dap = require('dap')
            local dapui = require('dapui')
            dapui.setup()
            vim.keymap.set("n", "<leader>du", function() dapui.open() end, {desc="Open DAP UI"})
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end
        end
    },
    {
        'mfussenegger/nvim-dap-python',
        ft = 'python',
        dependencies = {
            'mfussenegger/nvim-dap',
            "rcarriga/nvim-dap-ui",
            'theHamsta/nvim-dap-virtual-text',
        },
        config = function ()
            local dap = require('dap')
            local dap_python = require('dap-python')
            dap_python.setup('venv/bin/python')
            dap.configurations.python = {
                {
                    type = 'python',
                    request = 'launch',
                    name = 'Debug Uvicorn App',
                    program = vim.fn.getcwd() .. '/start.sh',
                    -- program = vim.fn.getcwd() .. '/venv/bin/uvicorn',
                    -- args = {'app.main:app', '--reload'},
                    cwd = vim.fn.getcwd(),
                    justMyCode = false,
                },
            }
        end,
    },
}
