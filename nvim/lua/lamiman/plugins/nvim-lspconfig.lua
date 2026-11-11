return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },

  config = function()
    -- Mason setup
    require("mason").setup()

    require("mason-lspconfig").setup({
      ensure_installed = {
        "rust_analyzer",
        "lua_ls",
        "jdtls",
        "marksman",
        "texlab",
      },
      automatic_enable = true,
    })

    -- Completion capabilities
    local capabilities =
      require("cmp_nvim_lsp").default_capabilities()

    -- Apply capabilities to all LSP servers
    vim.lsp.config("*", {
      capabilities = capabilities,
    })

    -- Lua
    vim.lsp.config("lua_ls", {
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

    -- Rust
    vim.lsp.config("rust_analyzer", {
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

    -- C / C++
    vim.lsp.config("clangd", {
      cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
      },
      filetypes = { "c", "cpp", "objc", "objcpp" },
      root_markers = {
        "compile_commands.json",
        "compile_flags.txt",
        ".git",
      },
    })

    -- Zig
    vim.lsp.config("zls", {})

    -- Python
    vim.lsp.config("pyright", {
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

    -- Java
    vim.lsp.config("jdtls", {
      cmd = { "jdtls" },
    })

    -- Go
    vim.lsp.config("gopls", {
      settings = {
        gopls = {
          analyses = {
            unusedparams = true,
          },
          staticcheck = true,
        },
      },
    })

    -- Markdown
    vim.lsp.config("marksman", {})

    -- Enable the configured servers.
    -- Mason also automatically enables its installed servers.
    vim.lsp.enable({
      "lua_ls",
      "rust_analyzer",
      "clangd",
      "zls",
      "pyright",
      "jdtls",
      "gopls",
      "marksman",
      "texlab",
    })

    -- LSP keybindings
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {
        clear = true,
      }),
      callback = function(ev)
        local opts = {
          buffer = ev.buf,
          silent = true,
        }

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

    -- Diagnostic signs
    local signs = {
      Error = "危",
      Warn = "警",
      Hint = "助",
      Info = "情",
    }

    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, {
        text = icon,
        texthl = hl,
        numhl = "",
      })
    end
  end,
}

