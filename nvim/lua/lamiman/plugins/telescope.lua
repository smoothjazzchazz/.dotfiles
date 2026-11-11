return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },

  config = function()
    require("telescope").setup {
      defaults = {

        -- Set the prompt position to the top
        prompt_position = "top",
        -- Set the prefix for the prompt
        prompt_prefix = "> ",
        -- Set the sorting strategy to ascending
        sorting_strategy = "ascending",

        -- Customize the layout (optional)

        layout_strategy = "horizontal",
        layout_config = {
          width = 0.75,
          preview_width = 0.6,
        },
      },
      pickers = {
        find_files = {
          -- Customize the default file picker behavior
          theme = "dropdown",  -- Use a dropdown theme for the file finder
        },
        live_grep = {
          theme = "dropdown",  -- Use a dropdown theme for live grep
        },
      },
    }
    -- Key mappings for Telescope
    vim.api.nvim_set_keymap("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<leader>fb", "<cmd>Telescope file_browser<CR>", { noremap = true, silent = true })
  end
}
