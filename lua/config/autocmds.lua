-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd("InsertLeave", {
	pattern = "*",
	command = "set nopaste",
})

-- Disable the concealing in some file formats
-- The default conceallevel is 3 in LazyVim
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "json", "jsonc", "markdown" },
	callback = function()
		vim.opt.conceallevel = 0
	end,
})

-- Open images with snacks
vim.api.nvim_create_autocmd("BufRead", {
	pattern = {"*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif"},
	callback = function()
		require("snacks").image.open()
	end,
})
