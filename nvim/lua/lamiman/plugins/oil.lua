return {
  'stevearc/oil.nvim',
  opts = {},
  dependencies = { "echasnovski/mini.icons" },
  lazy = false,
  -- Add this keybind:
  keys = {
    { "-", "<cmd>Oil<CR>", desc = "Open Oil file explorer" },
  },
}
