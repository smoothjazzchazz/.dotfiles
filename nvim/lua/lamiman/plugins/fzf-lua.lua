return {
  "ibhagwan/fzf-lua",
  cmd = "FzfLua",
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- optional for icon support
  opts = function()
    local config = require("fzf-lua.config")
    local actions = require("fzf-lua.actions")

    -- Key mappings for fzf
    config.defaults.keymap.fzf["ctrl-q"] = "select-all+accept"
    config.defaults.keymap.fzf["ctrl-u"] = "half-page-up"
    config.defaults.keymap.fzf["ctrl-d"] = "half-page-down"
    config.defaults.keymap.fzf["ctrl-x"] = "jump"
    config.defaults.keymap.fzf["ctrl-f"] = "preview-page-down"
    config.defaults.keymap.fzf["ctrl-b"] = "preview-page-up"
    config.defaults.keymap.builtin["<c-f>"] = "preview-page-down"
    config.defaults.keymap.builtin["<c-b>"] = "preview-page-up"

    -- Toggle root dir / cwd with ctrl-r
    config.defaults.actions.files["ctrl-r"] = function(_, ctx)
      local cwd = vim.fn.getcwd()
      local home = vim.loop.os_homedir()

      -- Toggle between home directory and previous directory
      if cwd == home then
        vim.cmd("cd -") -- Switch to the previous directory
      else
        vim.cmd("cd " .. home) -- Switch to the home directory
      end

      -- Reopen fzf-lua picker with updated directory
      require("fzf-lua").files({ cwd = vim.fn.getcwd() })
    end

    -- Image previewer setup
    local img_previewer
    for _, v in ipairs({
      { cmd = "ueberzug", args = {} },
      { cmd = "chafa", args = { "{file}", "--format=symbols" } },
      { cmd = "viu", args = { "-b" } },
    }) do
      if vim.fn.executable(v.cmd) == 1 then
        img_previewer = vim.list_extend({ v.cmd }, v.args)
        break
      end
    end

    return {
      fzf_opts = {
        ["--no-scrollbar"] = true,
      },
      defaults = {
        formatter = "path.dirname_first",
      },
      previewers = {
        builtin = {
          extensions = {
            ["png"] = img_previewer,
            ["jpg"] = img_previewer,
            ["jpeg"] = img_previewer,
            ["gif"] = img_previewer,
            ["webp"] = img_previewer,
          },
          ueberzug_scaler = "fit_contain",
        },
      },
      files = {
        cwd_prompt = false,
        actions = {
          ["alt-i"] = { actions.toggle_ignore },
          ["alt-h"] = { actions.toggle_hidden },
        },
      },
      grep = {
        actions = {
          ["alt-i"] = { actions.toggle_ignore },
          ["alt-h"] = { actions.toggle_hidden },
        },
      },
      lsp = {
        symbols = {
          symbol_hl = function(s)
            return "TroubleIcon" .. s
          end,
          symbol_fmt = function(s)
            return s:lower() .. "\t"
          end,
        },
      },
    }
  end,
  config = function(_, opts)
    require("fzf-lua").setup(opts)
  end,
  keys = {
    { "<leader><space>", "<cmd>FzfLua files<cr>", desc = "Find Files" },
    { "<leader>/", "<cmd>FzfLua live_grep<cr>", desc = "Live Grep" },
    { "<leader>,", "<cmd>FzfLua buffers<cr>", desc = "Buffers" },
    { "<leader>fr", "<cmd>FzfLua oldfiles<cr>", desc = "Recent Files" },
    { "<leader>gc", "<cmd>FzfLua git_commits<CR>", desc = "Git Commits" },
    { "<leader>gs", "<cmd>FzfLua git_status<CR>", desc = "Git Status" },
  },
}
