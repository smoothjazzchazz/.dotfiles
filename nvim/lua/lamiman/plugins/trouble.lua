return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons", "folke/todo-comments.nvim" },
  opts = {
    focus = true,
  },
  cmd = "Trouble",
  keys = {
    { "<leader>cs", "<cmd>Trouble lsp_document_symbols toggle<CR>", desc = "Symbols (Trouble)" },
    { "<leader>cS", "<cmd>Trouble lsp_references toggle<CR>",       desc = "LSP references/definitions/... (Trouble)" },
    { "<leader>xL", "<cmd>Trouble loclist toggle<CR>",              desc = "Location List (Trouble)" },
    { "<leader>xQ", "<cmd>Trouble quickfix toggle<CR>",             desc = "Quickfix List (Trouble)" },
    { "<leader>xx", "<cmd>Trouble diagnostics toggle<CR>",          desc = "Diagnostics (Trouble)" },
    { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", desc = "Buffer Diagnostics (Trouble)" },
    { "[q",          "<cmd>Trouble previous<CR>",                   desc = "Previous Trouble/Quickfix Item" },
    { "]q",          "<cmd>Trouble next<CR>",                       desc = "Next Trouble/Quickfix Item" },
  },
}
