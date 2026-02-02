local discipline = require("craftzdog.discipline")

discipline.cowboy()

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Do things without affecting the registers
keymap.set("n", "x", '"_x')
keymap.set("n", "<Leader>p", '"0p')
keymap.set("n", "<Leader>P", '"0P')
keymap.set("v", "<Leader>p", '"0p')
keymap.set("n", "<Leader>c", '"_c')
keymap.set("n", "<Leader>C", '"_C')
keymap.set("v", "<Leader>c", '"_c')
keymap.set("v", "<Leader>C", '"_C')
keymap.set("n", "<Leader>d", '"_d')
keymap.set("n", "<Leader>D", '"_D')
keymap.set("v", "<Leader>d", '"_d')
keymap.set("v", "<Leader>D", '"_D')

-- Increment/decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

-- Delete a word backwards
keymap.set("n", "dw", 'vb"_d')

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- Save with root permission (not working for now)
--vim.api.nvim_create_user_command('W', 'w !sudo tee > /dev/null %', {})

-- Disable continuations
keymap.set("n", "<Leader>o", "o<Esc>^Da", opts)
keymap.set("n", "<Leader>O", "O<Esc>^Da", opts)

-- Jumplist
keymap.set("n", "<C-m>", "<C-i>", opts)

-- New tab
keymap.set("n", "te", ":tabedit")
keymap.set("n", "<tab>", ":tabnext<Return>", opts)
keymap.set("n", "<s-tab>", ":tabprev<Return>", opts)
-- Split window
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)
-- Move window
keymap.set("n", "sh", "<C-w>h")
keymap.set("n", "sk", "<C-w>k")
keymap.set("n", "sj", "<C-w>j")
keymap.set("n", "sl", "<C-w>l")

-- Resize window
keymap.set("n", "<C-w><left>", "<C-w><")
keymap.set("n", "<C-w><right>", "<C-w>>")
keymap.set("n", "<C-w><up>", "<C-w>+")
keymap.set("n", "<C-w><down>", "<C-w>-")

-- Diagnostics
keymap.set("n", "<C-j>", function()
	vim.diagnostic.goto_next()
end, opts)

keymap.set("n", "<leader>r", function()
	require("craftzdog.hsl").replaceHexWithHSL()
end)

-- Terminal
keymap.set("n", "<leader>t", ":vsplit | terminal<Return>", opts)
keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", opts)
keymap.set("n", "<leader>T", ":q<Return>", opts)

-- Copilot keybindings
keymap.set("i", "<C-l>", 'copilot#Accept("<CR>")', { expr = true, replace_keycodes = false })
keymap.set("i", "<C-]>", "<Plug>(copilot-next)")
keymap.set("i", "<C-[>", "<Plug>(copilot-previous)")

-- Function to start rust-analyzer
function _G.start_rust_analyzer()
	local clients = vim.lsp.get_clients({ name = "rust_analyzer" })
	if #clients > 0 then
		vim.notify("rust-analyzer is already running", vim.log.levels.INFO)
		return
	end

	require("lspconfig").rust_analyzer.setup({
		settings = {
			["rust-analyzer"] = {
				cargo = { allFeatures = true },
				checkOnSave = { command = "clippy" },
				diagnostics = { enable = true },
				inlayHints = {
					enable = true,
					showParameterNames = true,
					parameterHintsPrefix = "<- ",
					otherHintsPrefix = "=> "
				}
			}
		}
	})
	local success = vim.lsp.start(require("lspconfig").rust_analyzer)
	if success then
		vim.notify("rust-analyzer started successfully", vim.log.levels.INFO)
	else
		vim.notify("Failed to start rust-analyzer", vim.log.levels.ERROR)
	end
end

-- Function to start clangd (C++)
function _G.start_clangd()
	local clients = vim.lsp.get_clients({ name = "clangd" })
	if #clients > 0 then
		vim.notify("clangd is already running", vim.log.levels.INFO)
		return
	end

	require("lspconfig").clangd.setup({
		cmd = {
			"clangd",
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
	})
	local success = vim.lsp.start(require("lspconfig").clangd)
	if success then
		vim.notify("clangd started successfully", vim.log.levels.INFO)
	else
		vim.notify("Failed to start clangd", vim.log.levels.ERROR)
	end
end

-- Function to start gopls (Go)
function _G.start_gopls()
	local clients = vim.lsp.get_clients({ name = "gopls" })
	if #clients > 0 then
		vim.notify("gopls is already running", vim.log.levels.INFO)
		return
	end

	require("lspconfig").gopls.setup({
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
	})
	local success = vim.lsp.start(require("lspconfig").gopls)
	if success then
		vim.notify("gopls started successfully", vim.log.levels.INFO)
	else
		vim.notify("Failed to start gopls", vim.log.levels.ERROR)
	end
end

-- LSP keybindings
keymap.set("n", "<leader>rs", start_rust_analyzer, { desc = "Start rust-analyzer LSP" })
keymap.set("n", "<leader>cc", _G.start_clangd, { desc = "Start clangd LSP (C++)" })
keymap.set("n", "<leader>go", _G.start_gopls, { desc = "Start gopls LSP (Go)" })
