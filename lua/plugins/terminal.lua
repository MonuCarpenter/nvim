return {
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require('dashboard').setup({
        theme = 'hyper',
        config = {
          week_header = { enable = true },
          project = {
            enable = true,
            limit = 8,
            icon = ' ',
            label = 'Projects:',
            action = 'Telescope find_files cwd=',
          },
          shortcut = {
            { desc = 'Projects', group = '@property', action = 'Telescope projects', key = 'p' },
            { desc = 'Files', group = '@property', action = 'Telescope find_files', key = 'f' },
          }
        }
      })
      require('telescope').load_extension('projects')
    end
  },
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup {}
    end
  },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        direction = "float",
        open_mapping = [[<c-->]],
        float_opts = { border = "curved" },
        insert_mappings = true,
        terminal_mappings = true,
      })

      -- Terminal mode keymaps
      function _G.set_terminal_keymaps()
        local opts = { buffer = 0 }
        vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
        vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
        vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
        vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
        vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
        vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
      end
      vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

      -- Multi-terminal tab flow (VS Code-like)
      local map = vim.keymap.set
      map("n", "<leader>tn", "<cmd>TermNew<CR>", { desc = "New Terminal Tab" })
      map("n", "<leader>tl", "<cmd>TermSelect<CR>", { desc = "List Terminal Tabs" })
      map("n", "<leader>t1", "<cmd>1ToggleTerm<CR>", { desc = "Terminal 1" })
      map("n", "<leader>t2", "<cmd>2ToggleTerm<CR>", { desc = "Terminal 2" })
      map("n", "<leader>t3", "<cmd>3ToggleTerm<CR>", { desc = "Terminal 3" })
      map("n", "<leader>t4", "<cmd>4ToggleTerm<CR>", { desc = "Terminal 4" })
    end,
  }
}