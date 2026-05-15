return {
  {
    "ahmedkhalf/project.nvim",
    event = "VeryLazy",
    opts = {
      detection_methods = { "lsp", "pattern" },
      patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },
      show_hidden = false,
      silent_chdir = true,
      scope_chdir = "global",
    },
    config = function(_, opts)
      require("project_nvim").setup(opts)
      pcall(function()
        require("telescope").load_extension("projects")
      end)
    end,
    keys = {
      {
        "<leader>fp",
        function()
          pcall(function()
            require("telescope").load_extension("projects")
          end)
          vim.cmd("Telescope projects")
        end,
        desc = "Find Project",
      },
    },
  },
}
