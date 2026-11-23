return {
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = "VeryLazy",
    config = function()
      local highlight = {
        "RainbowRed",
        "RainbowYellow",
        "RainbowBlue",
        "RainbowOrange",
        "RainbowGreen",
        "RainbowViolet",
        "RainbowCyan",
      }
      local hooks = require("ibl.hooks")

      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#D97078" })
        vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E2C082" })
        vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#67ADE7" })
        vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#CD9B6C" })
        vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#9AC27E" })
        vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C27CD6" })
        vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#5DB3BE" })
      end)

      require("ibl").setup({
        indent = { char = "│", highlight = highlight },
        scope = { enabled = true, show_start = false, show_end = false },
      })
    end,
  },
  {
    "saghen/blink.pairs",
    dependencies = "saghen/blink.lib",
    version = "*",
    event = "VeryLazy",
    build = function() require("blink.pairs").build():pwait(60000) end,
    init = function()
      local groups = {
        BlinkPairsRed = "#D97078",
        BlinkPairsYellow = "#E2C082",
        BlinkPairsBlue = "#67ADE7",
        BlinkPairsOrange = "#CD9B6C",
        BlinkPairsGreen = "#9AC27E",
        BlinkPairsPurple = "#C27CD6",
        BlinkPairsCyan = "#5DB3BE",
      }
      local function set_colors()
        for name, fg in pairs(groups) do
          vim.api.nvim_set_hl(0, name, { fg = fg })
        end
      end
      set_colors()
      vim.api.nvim_create_autocmd("ColorScheme", { callback = set_colors })
    end,
    opts = {
      highlights = {
        groups = {
          "BlinkPairsRed",
          "BlinkPairsYellow",
          "BlinkPairsBlue",
          "BlinkPairsOrange",
          "BlinkPairsGreen",
          "BlinkPairsPurple",
          "BlinkPairsCyan",
        },
      },
    },
  },
  {
    "Djancyp/better-comments.nvim",
    event        = { "VeryLazy" },
    opts         = {
      tags = {
        {
          name = "TODO",
          fg = "#f9e2af",
          bg = "",
          bold = true,
        },
        {
          name = "FIX",
          fg = "#cba6f7",
          bg = "",
          bold = true,
        },
        {
          name = "WARNING",
          fg = "#f38ba8",
          bg = "",
          bold = false,
        },
        {
          name = "INFO",
          fg = "#74c7ec",
          bg = "",
          bold = false,
        },
        {
          name = "!",
          fg = "#f38ba8",
          bg = "",
          bold = true,
        },
        {
          name = "*",
          fg = "#a6e3a1",
          bg = "",
          bold = true,
        },
        {
          name = "?",
          fg = "#74c7ec",
          bg = "",
          bold = true,
        },
      },
    },
    config       = function(_, opts)
      require('better-comment').Setup(opts)
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter"
    }
  },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      current_line_blame = true,
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end
        map("n", "<leader>ghp", gs.preview_hunk, "Preview Hunk")
      end,
    },
  },
  {
    "akinsho/bufferline.nvim",
    after = "catppuccin",
    event = "VeryLazy",
    opts = {
      options = {
        diagnostics = "nvim_lsp",
        separator_style = "slant",
        diagnostics_indicator = function(_, _, diag)
          local ret = (diag.error and " " .. diag.error .. " " or "")
              .. (diag.warning and " " .. diag.warning or "")
          return vim.trim(ret)
        end,
      },
    },
    keys = {
      {
        "<leader>k",
        function()
          require("bufferline").cycle(1)
        end,
      },
      {
        "<leader>j",
        function()
          require("bufferline").cycle(-1)
        end,
      },
    },
    config = function(_, opts)
      opts.highlights = require("catppuccin.special.bufferline").get_theme({
        styles = { "italic", "bold" },
      })
      require("bufferline").setup(opts)
    end,
    dependencies = "nvim-tree/nvim-web-devicons",
  },
}
