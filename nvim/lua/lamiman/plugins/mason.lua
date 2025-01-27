return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    -- Error handling for required modules
    local status_mason, mason = pcall(require, "mason")
    if not status_mason then
      vim.notify("Failed to load mason", vim.log.levels.ERROR)
      return
    end

    local status_mason_lspconfig, mason_lspconfig = pcall(require, "mason-lspconfig")
    if not status_mason_lspconfig then
      vim.notify("Failed to load mason-lspconfig", vim.log.levels.ERROR)
      return
    end

    -- Setup Mason with custom UI icons
    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    -- Ensure specific LSP servers are installed, including Go
    mason_lspconfig.setup({
      ensure_installed = {
        "rust_analyzer",     -- Rust
        "clangd",            -- C/C++
        "zls",               -- Zig
        "pyright",           -- Python
        "lua_ls",            -- Lua
        "marksman",          -- Markdown
      },
      automatic_installation = true, -- Automatically install LSP servers if not already installed
    })
  end,
}
