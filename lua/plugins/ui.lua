return {
	-- disable bufferline (top bar tabs)
	{ "romgrk/bufferline.nvim", enabled = false },
	-- messages, cmdline and the popupmenu
	{
		"folke/noice.nvim",
		opts = function(_, opts)
			table.insert(opts.routes, {
				filter = {
					event = "notify",
					find = "No information available",
				},
				opts = { skip = true },
			})
			table.insert(opts.routes, {
				filter = {
					event = "notify",
					kind = "error",
				},
				opts = { skip = true },
			})
			local focused = true
			vim.api.nvim_create_autocmd("FocusGained", {
				callback = function()
					focused = true
				end,
			})
			vim.api.nvim_create_autocmd("FocusLost", {
				callback = function()
					focused = false
				end,
			})
			table.insert(opts.routes, 1, {
				filter = {
					cond = function()
						return not focused
					end,
				},
				view = "notify_send",
				opts = { stop = false },
			})

			opts.commands = {
				all = {
					-- options for the message history that you get with `:Noice`
					view = "split",
					opts = { enter = true, format = "details" },
					filter = {},
				},
			}

			vim.api.nvim_create_autocmd("FileType", {
				pattern = "markdown",
				callback = function(event)
					vim.schedule(function()
						require("noice.text.markdown").keys(event.buf)
					end)
				end,
			})

			opts.presets.lsp_doc_border = true
		end,
	},

	{
		"rcarriga/nvim-notify",
		opts = {
			timeout = 5000,
		},
	},

	{
		"snacks.nvim",
		opts = {
			scroll = { enabled = false },
        dashboard = {
            preset = {
                header = [[
 ███╗░░░███╗░█████╗░███╗░░██╗██╗░░░██╗
 ████╗░████║██╔══██╗████╗░██║██║░░░██║
 ██╔████╔██║██║░░██║██╔██╗██║██║░░░██║
 ██║╚██╔╝██║██║░░██║██║╚████║██║░░░██║
 ██║░╚═╝░██║╚█████╔╝██║░╚███║╚██████╔╝
 ╚═╝░░░░░╚═╝░╚════╝░╚═╝░░╚══╝░╚═════╝░
]],
            },
            sections = {
                { section = "header" },
                {
                    section = "keys",
                    gap = 1,
                    padding = 1,
                    keys = {
                        { icon = " ", key = "f", desc = "Find File", action = ":Telescope find_files" },
                        { icon = " ", key = "g", desc = "Find Text", action = ":Telescope live_grep" },
                        { icon = " ", key = "r", desc = "Recent Files", action = ":Telescope oldfiles" },
                        { icon = " ", key = "p", desc = "Projects", action = ":Telescope projects" },
                        { icon = " ", key = "q", desc = "Quit", action = ":qa" },
                    },
                },
                { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
                { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
                { section = "startup" },
            },
        },
			image = {
				bo = { modified = false },
			},
			picker = {
				sources = {
					explorer = {
						hidden = true,
						ignored = true,
					},
				},
				previewers = {
					image = {},
				},
			},
			explorer = {
				config = function(opts, defaults)
					vim.api.nvim_set_hl(0, "SnacksExplorer", { bg = "#3c3c3c" })
					opts.win = opts.win or {}
					opts.win.wo = opts.win.wo or {}
					opts.win.wo.winhighlight = "Normal:SnacksExplorer"
				end,
			},
		},
		keys = {},
	},

	-- statusline
	{
		"nvim-lualine/lualine.nvim",
		opts = function(_, opts)
			local LazyVim = require("lazyvim.util")

			local function branch_picker()
				require("telescope.builtin").git_branches()
			end

			local function project_picker()
				pcall(require("telescope").load_extension, "projects")
				vim.cmd("Telescope projects")
			end

			local function finder_open()
				local folder = vim.fn.system(
					"osascript -e 'tell application \"Finder\" to set folderPath to POSIX path of (choose folder)' 2>/dev/null"
				)
				if vim.v.shell_error ~= 0 then
					return
				end
				folder = vim.fn.trim(folder)
				if folder ~= "" then
					vim.api.nvim_set_current_dir(folder)
					vim.cmd("e .")
				end
			end

			opts.options.component_separators = { left = "", right = "" }
			opts.options.section_separators = { left = "", right = "" }
			opts.sections.lualine_a = { "mode" }
			opts.sections.lualine_b = {
				{
					"branch",
					on_click = branch_picker,
				},
				{
					function()
						local ok, project = pcall(require("project_nvim").get_current_project_name)
						if ok and project then
							return " " .. project
						end
						return " " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":~")
					end,
					on_click = function()
						vim.ui.select({
							{ text = "Recent Projects", action = "projects" },
							{ text = "Open from Finder", action = "finder" },
						}, {
							prompt = "Switch Project",
							format_item = function(item)
								return item.text
							end,
						}, function(choice)
							if choice then
								if choice.action == "projects" then
									project_picker()
								else
									finder_open()
								end
							end
						end)
					end,
				},
			}
			opts.sections.lualine_c = { { "filename", path = 1 } }
			opts.sections.lualine_x = { "filetype", "encoding" }
			opts.sections.lualine_y = { "progress" }
			opts.sections.lualine_z = { "location" }
		end,
	},

	{
		"folke/zen-mode.nvim",
		cmd = "ZenMode",
		opts = {
			plugins = {
				gitsigns = true,
				tmux = true,
				kitty = { enabled = false, font = "+2" },
			},
		},
		keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
	},

	{
		"MeanderingProgrammer/render-markdown.nvim",
		enabled = false,
	},

  -- Todo comments
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },

  -- Trouble for diagnostics
  {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },
}
