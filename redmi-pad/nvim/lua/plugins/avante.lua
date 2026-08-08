return {
    {
        "yetone/avante.nvim",
        event = "VeryLazy",
        lazy = false,
        version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
        -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
        build = "make",
        dependencies = {
            "stevearc/dressing.nvim",
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            --- The below dependencies are optional,
            "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
            -- "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
            "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
        },
        opts = {
            providers = {
                groq = {
                    __inherited_from = "openai",
                    api_key_name = "GROQ_API_KEY",
                    endpoint = "https://api.groq.com/openai/v1/",
                    model = "llama-3.3-70b-versatile",
                },
            },
            windows = {
                ask = {
                    floating = false,
                    },
                width = 80,
            },
        },
    },
    {
      -- Make sure to set this up properly if you have lazy=true
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
}
