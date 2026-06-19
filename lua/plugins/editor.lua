return {
{
  "Pocco81/auto-save.nvim",
  event = "BufReadPre",
  config = function()
    require("auto-save").setup {
      enabled = true,
      debounce_delay = 1000, -- 1 second delay, adjust as needed
      execution_message = {
        message = function()
          return ("AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"))
        end,
        dim = 0.18,
        cleaning_interval = 1250,
      },
      trigger_events = {"InsertLeave", "TextChanged"},
      condition = function(buf)
        local fn = vim.fn
        local utils = require("auto-save.utils.data")
        if fn.getbufvar(buf, "&modifiable") == 1 and utils.not_in(fn.getbufvar(buf, "&filetype"), {}) then
          return true
        end
        return false
      end,
      write_all_buffers = false,
      callbacks = {
        after_saving = function()
          vim.cmd("silent! FormatWrite")
        end,
      },
    }
  end,
},

	{
		enabled = false,
		"folke/flash.nvim",
		---@type Flash.Config
		opts = {
			search = {
				forward = true,
				multi_window = false,
				wrap = false,
				incremental = true,
			},
		},
	},

	{
		"brenoprata10/nvim-highlight-colors",
		event = "BufReadPre",
		opts = {
			render = "background",
			enable_hex = true,
			enable_short_hex = true,
			enable_rgb = true,
			enable_hsl = true,
			enable_hsl_without_function = true,
			enable_ansi = true,
			enable_var_usage = true,
			enable_tailwind = true,
		},
	},

	{
		"dinhhuy258/git.nvim",
		event = "BufReadPre",
		opts = {
			keymaps = {
				-- Open blame window
				blame = "<Leader>gb",
				-- Open file/folder in git repository
				browse = "<Leader>go",
			},
		},
	},

	{
		"nvim-telescope/telescope.nvim",
		enabled = false,
	},

	{
		"bassamsdata/namu.nvim",
		opts = {
			namu_symbols = {
				enable = true,
				options = {
					display = { mode = "icon", padding = 2 },
					row_position = "top10",
					window = {
						auto_size = true,
						border = "none",
						title_pos = "left",
						show_footer = true,
					},
					icon = "󱠦",
				},
			},
			workspace = {
				enable = true,
				options = {
					display = { mode = "icon", padding = 2 },
					row_position = "center",
					window = {
						auto_size = true,
						border = "none",
						title_pos = "left",
					},
				},
			},
			diagnostics = {
				enable = true,
				options = {
					display = { mode = "icon", padding = 2 },
					row_position = "center",
					window = {
						auto_size = true,
						border = "none",
					},
				},
			},
			watchtower = {
				enable = true,
				options = {
					display = { mode = "icon", padding = 2 },
					window = { border = "none", auto_size = true },
				},
			},
			selecta = {
				enable = true,
				options = {
					window = {
						border = "none",
						auto_size = true,
						title_pos = "left",
						show_footer = true,
					},
					display = { mode = "icon", padding = 1 },
				},
			},
		},
		keys = {
			{ "<leader>ns", ":Namu symbols<cr>", desc = "LSP Symbols", silent = true },
			{ "<leader>nw", ":Namu workspace<cr>", desc = "Workspace Symbols", silent = true },
			{ "<leader>nd", ":Namu diagnostics<cr>", desc = "Diagnostics", silent = true },
			{ "<leader>nb", ":Namu watchtower<cr>", desc = "All Buffers Symbols", silent = true },
			{ "<leader>nt", ":Namu treesitter<cr>", desc = "Treesitter Symbols", silent = true },
		},
	},

	{
		"saghen/blink.cmp",
		opts = {
			completion = {
				menu = {
					winblend = vim.o.pumblend,
				},
			},
			signature = {
				window = {
					winblend = vim.o.pumblend,
				},
			},
			sources = {
				default = { "lsp", "path", "snippets", "buffer", "copilot" },
				providers = {
					copilot = {
						name = "copilot",
						module = "blink-copilot",
						score_offset = 100,
						async = true,
					},
				},
			},
		},
	},
}
