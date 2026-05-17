return {
	-- tools
	{
		"mason-org/mason.nvim",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, {
				"stylua",
				"selene",
				"luacheck",
				"shellcheck",
				"shfmt",
				"tailwindcss-language-server",
				"typescript-language-server",
				"css-lsp",
				"rust-analyzer",
				"clangd", -- C++ LSP
				"gopls", -- Go LSP
				-- React Native/Expo tools
				"emmet-ls", -- HTML/CSS completion
				"json-lsp", -- JSON support
			})
		end,
	},

	-- mason-lspconfig
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {
			ensure_installed = { "rust_analyzer" },
		},
	},

	-- lsp servers
	{
		"neovim/nvim-lspconfig",
		opts = {
			inlay_hints = { enabled = false },
			---@type lspconfig.options
			servers = {
				cssls = {},
				tailwindcss = {
					root_dir = function(...)
						return require("lspconfig.util").root_pattern(".git")(...)
					end,
				},
				tsserver = {
				-- Increase Node memory for tsserver to avoid OOM crashes
				on_new_config = function(new_config)
					new_config.cmd_env = new_config.cmd_env or {}
					new_config.cmd_env.NODE_OPTIONS = '--max-old-space-size=8192'
				end,
					root_dir = function(...)
						return require("lspconfig.util").root_pattern(".git")(...)
					end,
					single_file_support = false,
					settings = {
						typescript = {
							format = {
								semicolons = "remove"
							},
							inlayHints = {
								includeInlayParameterNameHints = "literal",
								includeInlayParameterNameHintsWhenArgumentMatchesName = false,
								includeInlayFunctionParameterTypeHints = true,
								includeInlayVariableTypeHints = false,
								includeInlayPropertyDeclarationTypeHints = true,
								includeInlayFunctionLikeReturnTypeHints = true,
								includeInlayEnumMemberValueHints = true,
							},
							suggest = {
								includeCompletionsForImportStatements = true,
								includeCompletionsForModuleExports = true,
								includeAutomaticOptionalChainCompletions = true,
								includeCompletionsWithSnippetText = true,
							},
						},
						javascript = {
							format = {
								semicolons = "remove"
							},
							inlayHints = {
								includeInlayParameterNameHints = "all",
								includeInlayParameterNameHintsWhenArgumentMatchesName = false,
								includeInlayFunctionParameterTypeHints = true,
								includeInlayVariableTypeHints = true,
								includeInlayPropertyDeclarationTypeHints = true,
								includeInlayFunctionLikeReturnTypeHints = true,
								includeInlayEnumMemberValueHints = true,
							},
							suggest = {
								includeCompletionsForImportStatements = true,
								includeCompletionsForModuleExports = true,
								includeAutomaticOptionalChainCompletions = true,
								includeCompletionsWithSnippetText = true,
							},
						},
						completions = {
							completeFunctionCalls = true,
						},
					},
				},
				html = {},
				emmet_ls = {
					filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
				},
				yamlls = {
					settings = {
						yaml = {
							keyOrdering = false,
						},
					},
				},
				lua_ls = {
					-- enabled = false,
					single_file_support = true,
					settings = {
						Lua = {
							workspace = {
								checkThirdParty = false,
							},
							completion = {
								workspaceWord = true,
								callSnippet = "Both",
							},
							misc = {
								parameters = {
									-- "--log-level=trace",
								},
							},
							hint = {
								enable = true,
								setType = false,
								paramType = true,
								paramName = "Disable",
								semicolon = "Disable",
								arrayIndex = "Disable",
							},
							doc = {
								privateName = { "^_" },
							},
							type = {
								castNumberToInteger = true,
							},
							diagnostics = {
								disable = { "incomplete-signature-doc", "trailing-space" },
								-- enable = false,
								groupSeverity = {
									strong = "Warning",
									strict = "Warning",
								},
								groupFileStatus = {
									["ambiguity"] = "Opened",
									["await"] = "Opened",
									["codestyle"] = "None",
									["duplicate"] = "Opened",
									["global"] = "Opened",
									["luadoc"] = "Opened",
									["redefined"] = "Opened",
									["strict"] = "Opened",
									["strong"] = "Opened",
									["type-check"] = "Opened",
									["unbalanced"] = "Opened",
									["unused"] = "Opened",
								},
								unusedLocalExclude = { "_*" },
							},
							format = {
								enable = false,
								defaultConfig = {
									indent_style = "space",
									indent_size = "2",
									continuation_indent_size = "2",
								},
							},
						},
					},
				},
				rust_analyzer = {
					settings = {
						["rust-analyzer"] = {
							cargo = {
								allFeatures = true,
							},
							checkOnSave = {
								command = "clippy",
							},
							diagnostics = {
								enable = true,
							},
							inlayHints = {
								enable = true,
								showParameterNames = true,
								parameterHintsPrefix = "<- ",
								otherHintsPrefix = "=> ",
							},
						},
					},
				},
        clangd = {
					cmd = {
						vim.fn.expand("~/.local/share/nvim/mason/bin/clangd"),
						"--background-index",
						"--clang-tidy",
						"--header-insertion=iwyu",
						"--completion-style=detailed",
						"--function-arg-placeholders",
						"--fallback-style=llvm",
					},
					init_options = {
						usePlaceholders = true,
						completeUnimported = true,
						clangdFileStatus = true,
					},
				},
				gopls = {
					settings = {
						gopls = {
							analyses = {
								unusedparams = true,
								shadow = true,
							},
							staticcheck = true,
							gofumpt = true,
							usePlaceholders = true,
							completeUnimported = true,
							symbolMatcher = "fuzzy",
							experimentalPostfixCompletions = true,
						},
					},
				},
			},
			setup = {},
		},
	},

	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				["*"] = {
					keys = {
						{
							"gd",
							function()
								-- DO NOT RESUSE WINDOW
								require("telescope.builtin").lsp_definitions({ reuse_win = false })
							end,
							desc = "Goto Definition",
							has = "definition",
						},
					},
				},
			},
		},
	},
}