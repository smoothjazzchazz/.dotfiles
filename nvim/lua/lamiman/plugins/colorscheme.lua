return {
  {
    "rebelot/kanagawa.nvim",  -- Fixed typo in repository name
    name = "kanagawa",
    lazy = false,
    priority = 1000,
    config = function()
      require('kanagawa').setup({
        compile = false,
        undercurl = true,
        commentStyle = { italic = true },
        keywordStyle = { italic = true},
        statementStyle = { bold = true },
        transparent = false,
        dimInactive = false,
        terminalColors = true,
        theme = "wave",
        background = {
            dark = "wave",
            light = "lotus"
        },
      })
      vim.cmd("colorscheme kanagawa")
    end,
  },
}
