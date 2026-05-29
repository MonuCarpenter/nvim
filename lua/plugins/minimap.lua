return {
  {
    "Isrothy/neominimap.nvim",
    lazy = true,
    event = "BufReadPre",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    init = function()
      vim.g.neominimap = {
        auto_enable = true,
        layout = "split",
        split = {
          direction = "right",
          minimap_width = 10,
          fix_width = true,
        },
        diagnostic = {
          enabled = true,
        },
        git = {
          enabled = true,
        },
        treesitter = {
          enabled = true,
        },
        click = {
          enabled = true,
        },
        sync_cursor = true,
      }
    end,
  },
}
