return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "williamboman/mason.nvim",           -- Ensure Mason is installed
    "williamboman/mason-lspconfig.nvim", -- Ensure Mason LSPConfig is installed
    -- Add other dependencies here if needed
  },
  config = function()
    local lspconfig = require("lspconfig")
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")

    -- Initialize Mason
    mason.setup()

    -- Ensure the listed servers are installed
    mason_lspconfig.setup({
      ensure_installed = {
        "rust_analyzer",     -- Rust
        "clangd",            -- C/C++
        "zls",               -- Zig
        "pyright",           -- Python
        "lua_ls",            -- Lua
        "jdtls",             -- Java
        "marksman",          -- Markdown
        "texlab",
      },
      automatic_installation = true,
    })

    -- For autocompletion capabilities
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Keybindings set when LSP attaches to a buffer
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        local opts = { buffer = ev.buf, silent = true }

        -- LSP-related keymaps
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
        vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
        vim.keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
      end,
    })

    -- Set diagnostic symbols
    local signs = { Error = "危", Warn = "警", Hint = "助", Info = "情" }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    -- Setup handlers for servers installed by Mason
    mason_lspconfig.setup_handlers({
      -- Default handler for all servers that aren't specifically configured
      function(server_name)
        lspconfig[server_name].setup({
          capabilities = capabilities,
          on_attach = function(client, bufnr)
            -- Additional on_attach logic can be added here if needed
          end,
        })
      end,
      -- Special configuration for Lua
      ["lua_ls"] = function()
        lspconfig["lua_ls"].setup({
          capabilities = capabilities,
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" },
              },
              completion = {
                callSnippet = "Replace",
              },
            },
          },
        })
      end,
      -- Special configuration for Rust
      ["rust_analyzer"] = function()
        lspconfig["rust_analyzer"].setup({
          capabilities = capabilities,
          settings = {
            ["rust-analyzer"] = {
              assist = {
                importGranularity = "module",
                importPrefix = "by_self",
              },
              cargo = {
                loadOutDirsFromCheck = true,
              },
              procMacro = {
                enable = true,
              },
            },
          },
        })
      end,
      -- Special configuration for C/C++
      ["clangd"] = function()
        lspconfig["clangd"].setup({
          capabilities = capabilities,
          cmd = { "clangd", "--background-index", "--clang-tidy" },
          filetypes = { "c", "cpp", "objc", "objcpp" },
          root_dir = lspconfig.util.root_pattern("compile_commands.json", "compile_flags.txt", ".git"),
        })
      end,
      -- Special configuration for Zig
      ["zls"] = function()
        lspconfig["zls"].setup({
          capabilities = capabilities,
          -- Add any specific settings for Zig here
        })
      end,
      -- Special configuration for Python
      ["pyright"] = function()
        lspconfig["pyright"].setup({
          capabilities = capabilities,
          settings = {
            python = {
              analysis = {
                autoSearchPaths = true,
                typeCheckingMode = "basic",
                useLibraryCodeForTypes = true,
              },
            },
          },
        })
      end,
      -- Special configuration for Java
      ["jdtls"] = function()
        -- jdtls typically requires a separate setup process
        -- You might need to configure it outside of lspconfig
        -- Here's a basic setup, but refer to jdtls documentation for full setup
        local jdtls_config = {
          cmd = { "jdtls" },
          capabilities = capabilities,
          on_attach = function(client, bufnr)
            -- Java-specific on_attach settings
          end,
          -- Add more configurations as needed
        }
        lspconfig["jdtls"].setup(jdtls_config)
      end,
      -- Special configuration for Go
      ["gopls"] = function()
        lspconfig["gopls"].setup({
          capabilities = capabilities,
          settings = {
            gopls = {
              analyses = {
                unusedparams = true,
              },
              staticcheck = true,
            },
          },
        })
      end,
      -- Special configuration for Markdown
      ["marksman"] = function()
        lspconfig["marksman"].setup({
          capabilities = capabilities,
          -- Add any specific settings for Marksman here
        })
      end,
    })
  end,
}
