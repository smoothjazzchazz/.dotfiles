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
        transparent = true,
        dimInactive = false,
        terminalColors = true,
        theme = "lotus",
        background = {
            dark = "dragon",
            light = "lotus"
        },
      })
      vim.cmd("colorscheme kanagawa")
    end,
  },
}
