return {
  "karb94/neoscroll.nvim",
  event = "BufReadPre",
  opts = {
    -- Enable all typical scroll keys
    mappings = { '<C-u>', '<C-d>', '<C-b>', '<C-f>', '<C-y>', '<C-e>', 'zt', 'zz', 'zb' },
    hide_cursor = true,        -- Hide cursor while scrolling
    stop_eof = true,           -- Stop at <EOF> when scrolling downwards
    respect_scrolloff = true,  -- Respect your scrolloff setting
    cursor_scrolls_alone = true,
    easing = 'quadratic',      -- Smoother easing
    performance_mode = false,  -- Set true for very large files if perf is bad
  },
}