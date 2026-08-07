return {
    "yorickpeterse/vim-paper",
    "xpac27/humdrum.vim",
    "idr4n/github-monochrome.nvim",
    { "nvim-tree/nvim-web-devicons", lazy = true },
    {
        "aklt/plantuml-syntax",
        ft = "plantuml",
    },
    {
        "cameron-wags/rainbow_csv.nvim",
        config = true,
        ft = { "csv", "tsv", "csv_semicolon", "csv_whitespace", "csv_pipe",
               "rfc_csv", "rfc_semicolon" },
        cmd = { "RainbowDelim", "RainbowDelimSimple", "RainbowDelimQuoted",
                "RainbowMultiDelim" },
    },
    {
	    "folke/snacks.nvim",
	    priority = 1000,
	    lazy = false,
	    --@type snacks.Config
	    opts = {},
	    keys = {
	      {
		      "<leader><space>",
		      function() Snacks.picker.smart() end,
		      desc = "Smart Find Files"
	      },
	      {
	  	      "<leader>fo",
		      function() Snacks.picker.recent() end,
		      desc = "Find recent"
	      },
	      {
	  	      "<leader>cs",
		      function() Snacks.picker.colorschemes() end,
		      desc = "Colorscheme picker"
	      },
	      {
	  	      "<leader>e",
		      function() Snacks.picker.explorer() end,
		      desc = "File explorer"
	      },
	    },
    },
}
