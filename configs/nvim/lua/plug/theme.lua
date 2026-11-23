return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        icons_enabled = true,
        theme = "auto",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disable_filetypes = {
          statusline = {},
          winbar = {},
        },
      },
      sections = {
        lualine_a = {
          { "mode", separator = { right = "", left = " " }, },
        },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { "filename" },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = {
          { "location", separator = { left = "", right = "" }, },
        },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {},
    },
  },
  {
    "rcarriga/nvim-notify",
    keys = {
      {
        "<leader>rm",
        function()
          require("notify").dismiss({ silent = true, pending = true })
        end,
        desc = "Delete all Notifications",
      },
    },
    opts = {
      timeout = 3000,
			max_height = function()
				return math.floor(vim.o.lines * 0.5)
			end,
			max_width = function()
				return math.floor(vim.o.columns * 0.5)
			end,
    },
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      views = {
        cmdline_popup = {
          position = {
            row = 5,
            col = "50%",
          },
          size = {
            width = 60,
            height = "auto",
          },
        },
      },
      presets = {
				bottom_search = true,
				command_palette = true,
				long_message_to_split = false,
			},
      lsp = {
				progress = {
					enabled = false,
				},
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
				},
			},
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    opts = {
      transparent_background = false,
      term_colors = true,
      compile_path = vim.fn.stdpath("config") .. "/cache/catppuccin",
      styles = {
				booleans = { "bold", "italic" },
				keywords = { "italic", "bold" },
				loops = { "italic" },
				operators = { "bold" },
				functions = { "bold" },
			},
      integrations = {
				notify = true,
				-- mason = true,
				noice = true,
				-- lsp_trouble = true,
				indent_blankline = {
					enabled = true,
					colored_indent_levels = true,
				},
			},
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd([[colorscheme catppuccin]])
    end,
  }
}
