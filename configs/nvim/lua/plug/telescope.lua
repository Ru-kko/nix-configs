local image_ext = {
  png = true, jpg = true, jpeg = true, gif = true,
  webp = true, bmp = true, svg = true,
}

return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = {
      "Telescope",
    },
    keys = {
      {
        "<leader><leader>",
        function ()
          require("telescope.builtin").find_files({
            cwd = vim.loop.cwd(),
            hidden = true,
            no_ignore = true,
            no_ignore_parent = true,
          })
        end,
        mode = { "n" },
      },
      {
        "<leader>ff",
        function ()
          require("telescope.builtin").live_grep()
        end
      },
      {
        "<C-t>",
        function ()
          require("telescope").extensions.file_browser.file_browser({
            hidden = true,
            respect_gitignore = false,
            no_ignore = true,
          })
        end,
        mode = { "n", "v", "i" }, 
      },
      {
        "<A-t>",
        function ()
          require("telescope").extensions.file_browser.file_browser({
            cwd = vim.fn.expand("%:h"),
            hidden = true,
            respect_gitignore = false,
            no_ignore = true,
          })
        end,
        mode = { "n", "v", "i" },
      },
      {
        "<leader>gc",
        "<cmd>Telescope git_commits<cr>",
        mode = { "n" },
      },
      {
        "<leader>gs",
        "<cmd>Telescope git_status<cr>",
        mode = { "n" },
      },
    },
    opts = {
      defaults = {
        vimgrep_arguments = {
          "rg",
				  "--color=never",
				  "--no-heading",
				  "--with-filename",
				  "--line-number",
				  "--column",
				  "--smart-case",
				  "--no-ignore",
				  "--hidden"
        },
        prompt_prefix = " ",
			  selection_caret = " ",
			  layout_strategy = "horizontal",
			  layout_config = {
			 	  horizontal = {
			 		  prompt_position = "top",
			 		  preview_width = 0.55,
			 		  results_width = 0.8,
			 	  },
			 	  vertical = {
			 		  mirror = false,
			 	  },
			 	  width = 0.87,
			 	  height = 0.80,
			 	  preview_cutoff = 120,
			  },
        file_ignore_patterns = {
			 	  "node_modules",
			 	  "pnpm-lock.yaml",
			 	  ".git/",
        },
			  path_display = { "absolute" },
        sorting_strategy = "ascending",
			  winblend = 0,
			  border = {},
			  borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
			  color_devicons = true,
			  use_less = true,
			  set_env = { ["COLORTERM"] = "truecolor" },
        extensions = {
          file_browser = {
						theme = "dropdown",
						hidden = { file_browser = true, folder_browser = true },
						hijack_netrw = true,
						mappings = {
							["i"] = {},
							["n"] = {},
						},
					},
        },
        preview = { -- Preview images
          mime_hook = function(filepath, bufnr, opts)
            local ext = (filepath:match("%.(%w+)$") or ""):lower()
            if not image_ext[ext] then
              require("telescope.previewers.utils").set_preview_message(
                bufnr,
                opts and opts.winid,
                "Binary File"
              )
              return
            end

            local win = vim.fn.bufwinid(bufnr)
            local w = win ~= -1 and vim.api.nvim_win_get_width(win) or 60
            local h = win ~= -1 and vim.api.nvim_win_get_height(win) or 30

            vim.system({
              "chafa",
              "--format=symbols",
              "--colors=truecolor",
              "--symbols=block",
              "--align=mid,mid",
              "--view-size", string.format("%dx%d", w, h),
              filepath,
            }, { text = true }, vim.schedule_wrap(function(res)
              if not vim.api.nvim_buf_is_valid(bufnr) or res.code ~= 0 then
                return
              end
              local chan = vim.api.nvim_open_term(bufnr, {})
              vim.api.nvim_chan_send(chan, (res.stdout:gsub("\n", "\r\n")))
            end))
          end
        },
      },
    },
    config = function(_, opts)
      local telescope = require("telescope")

      telescope.setup(opts)
      telescope.load_extension("file_browser")
    end,
    dependencies = {
      'nvim-lua/plenary.nvim',
      "nvim-telescope/telescope-file-browser.nvim",
    }
  }
}