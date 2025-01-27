return {
  "echasnovski/mini.pairs",
  event = "VeryLazy", -- Load on a lazy event
  opts = {
    modes = { insert = true, command = true, terminal = false },
    skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
    skip_ts = { "string" },
    skip_unbalanced = true,
    markdown = true,
  },
  config = function(_, opts)
    -- Ensure mini.pairs is loaded and set up with the provided options
    local ok, mini_pairs = pcall(require, 'mini.pairs')
    if not ok then
      vim.notify('mini.pairs is not installed!', vim.log.levels.ERROR)
      return
    end
    mini_pairs.setup(opts)
  end,
}
