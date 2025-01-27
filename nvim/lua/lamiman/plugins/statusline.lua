return {
  "nvim-lualine/lualine.nvim",
  dependencies = { 
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local lualine = require("lualine")
    local lazy_status = require("lazy.status")

    -- Kanagawa Wave color palette with solid background
    local kanagawa_theme = (function()
      local colors = {
        blue = "#7E9CD8",
        green = "#98BB6C",
        peach = "#FFA066",
        mauve = "#957FB8",
        red = "#E46876",
        surface0 = "#24242D",    -- Darker background
        base = "#1F1F28",        -- Base background (main window bg)
        text = "#DCD7BA",        -- Default text
        overlay0 = "#727169",    -- Comments/inactive text
      }

      local theme = {
        normal = {
          a = { bg = colors.blue, fg = colors.base, gui = "bold" },
          b = { bg = colors.surface0, fg = colors.blue },
          c = { bg = colors.base, fg = colors.text },
        },
        insert = {
          a = { bg = colors.green, fg = colors.base, gui = "bold" },
          b = { bg = colors.surface0, fg = colors.green },
        },
        terminal = {
          a = { bg = colors.green, fg = colors.base, gui = "bold" },
          b = { bg = colors.surface0, fg = colors.green },
        },
        command = {
          a = { bg = colors.peach, fg = colors.base, gui = "bold" },
          b = { bg = colors.surface0, fg = colors.peach },
        },
        visual = {
          a = { bg = colors.mauve, fg = colors.base, gui = "bold" },
          b = { bg = colors.surface0, fg = colors.mauve },
        },
        replace = {
          a = { bg = colors.red, fg = colors.base, gui = "bold" },
          b = { bg = colors.surface0, fg = colors.red },
        },
        inactive = {
          a = { bg = colors.base, fg = colors.blue },
          b = { bg = colors.base, fg = colors.surface0, gui = "bold" },
          c = { bg = colors.base, fg = colors.overlay0 },
        },
      }

      return theme
    end)()

    lualine.setup({
      options = {
        theme = kanagawa_theme,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_x = {
          {
            lazy_status.updates,
            cond = lazy_status.has_updates,
            color = { fg = "#FFA066" },
          },
          { "encoding" },
          { "filetype" },
        },
      },
    })
  end,
}
