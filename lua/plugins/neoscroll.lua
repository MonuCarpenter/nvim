return {
  "karb94/neoscroll.nvim",
  event = "BufReadPre",
  config = function()
    local neoscroll = require("neoscroll")
    neoscroll.setup({
      hide_cursor = true,
      stop_eof = true,
      respect_scrolloff = true,
      cursor_scrolls_alone = true,
      performance_mode = false,
      mappings = {},
    })

    local map = function(keys, fn)
      vim.keymap.set({ "n", "x", "v" }, keys, fn, { silent = true, noremap = true })
    end

    map("<C-u>", function() neoscroll.ctrl_u({ duration = 200 }) end)
    map("<C-d>", function() neoscroll.ctrl_d({ duration = 200 }) end)
    map("<C-b>", function() neoscroll.ctrl_b({ duration = 400 }) end)
    map("<C-f>", function() neoscroll.ctrl_f({ duration = 400 }) end)
    map("<C-y>", function() neoscroll.scroll(-1, { move_cursor = false, duration = 120, easing = "sine" }) end)
    map("<C-e>", function() neoscroll.scroll(1, { move_cursor = false, duration = 120, easing = "sine" }) end)
    map("zt", function() neoscroll.zt({ half_win_duration = 250 }) end)
    map("zz", function() neoscroll.zz({ half_win_duration = 250 }) end)
    map("zb", function() neoscroll.zb({ half_win_duration = 250 }) end)

    -- Mouse wheel: smooth animated scrolling
    map("<ScrollWheelDown>", function()
      neoscroll.scroll(3, { move_cursor = false, duration = 60, easing = "sine" })
    end)
    map("<ScrollWheelUp>", function()
      neoscroll.scroll(-3, { move_cursor = false, duration = 60, easing = "sine" })
    end)
  end,
}