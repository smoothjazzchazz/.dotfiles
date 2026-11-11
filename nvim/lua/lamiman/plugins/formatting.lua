return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        -- C / C++
        c = { "clang_format" },
        cpp = { "clang_format" },
        objc = { "clang_format" },

        -- Python
        python = { "ruff_organize_imports", "ruff_format" },

        -- Lua
        lua = { "stylua" },

        -- JavaScript / TypeScript / Web
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        json = { "prettier" },
        jsonc = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        graphql = { "prettier" },

        -- SQL
        sql = { "sql_formatter" },

        -- LaTeX
        tex = { "tex-fmt" },
        plaintex = { "tex-fmt" },

        -- Verilog / SystemVerilog
        verilog = { "verible" },
        systemverilog = { "verible" },

        -- VHDL
        vhdl = { "vsg" },

        -- Shell scripts
        sh = { "shfmt" },
        bash = { "shfmt" },

        -- Other useful formats
        toml = { "taplo" },
        rust = { "rustfmt" },
        go = { "gofmt" },
        make = { "bake" },

        -- Clean up trailing whitespace for otherwise
        -- unsupported filetypes
        ["_"] = { "trim_whitespace" },
      },
    },
  },
}
