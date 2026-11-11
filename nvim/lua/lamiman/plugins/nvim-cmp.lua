return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-buffer",   -- source for text in buffer
    "hrsh7th/cmp-path",     -- source for file system paths
    {
      "L3MON4D3/LuaSnip",
    },
    "saadparwaiz1/cmp_luasnip", -- for snippet autocompletion
    "rafamadriz/friendly-snippets", -- useful snippets
    "onsails/lspkind.nvim", -- vs-code like pictograms
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    -- load vscode style snippets from friendly-snippets
    require("luasnip.loaders.from_vscode").lazy_load()


    cmp.setup({
      completion = {
        completeopt = "menu,menuone,preview,noselect",
      },
      snippet = {

        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,

      },
      mapping = cmp.mapping.preset.insert({
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()

          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)

          else
            fallback()
          end
        end, { "i", "s" }),
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
      }),
      sources = cmp.config.sources({

        { name = "nvim_lsp",        max_item_count = 10 },
        { name = "luasnip",         max_item_count = 10 },
        { name = "buffer",          max_item_count = 10 },
        { name = "path",            max_item_count = 10 },
        { name = "render-markdown", max_item_count = 10 },

      }),
      experimental = {

        ghost_text = true,
      },
      formatting = {
        fields = { "kind", "abbr", "menu" },
        expandable_indicator = true,
        format = function(entry, vim_item)
          local source_icons = {
            nvim_lsp = "",  -- LSP
            luasnip = "",   -- Snippet
            buffer = "",    -- Buffer
            path = "",      -- Path
          }
          vim_item.menu = source_icons[entry.source.name] or ""
          return vim_item
        end,
      },
    })
  end,
}
