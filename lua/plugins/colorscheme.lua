return {
	-- {
	-- 	"craftzdog/solarized-osaka.nvim",
	-- 	lazy = true,
	-- 	priority = 1000,
	-- 	opts = function()
	-- 		return {
	-- 			transparent = true,
	-- 		}
	-- 	end,
	-- },
	{
		"lunacookies/vim-colors-xcode",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("xcode")
			-- Zed-like: minimal line numbers, subtle cursorline
			vim.opt.relativenumber = false
			vim.opt.cursorline = true
			-- Zed uses subtle grey selection
			vim.api.nvim_set_hl(0, "Visual", { bg = "#d0d0d0" })
		end,
	},
}