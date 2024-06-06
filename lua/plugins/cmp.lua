return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lua",
    "saadparwaiz1/cmp_luasnip",
    "kristijanhusak/vim-dadbod-completion",
  },
  event = { "InsertEnter", "CmdlineEnter", },
  config = function()
    local cmp = require("cmp")

    local kind_icons = {
      Text = "󰉿",
      Method = "m",
      Function = "󰊕",
      Constructor = "",
      Field = "",
      Variable = "󰆧",
      Class = "󰌗",
      Interface = "",
      Module = "",
      Property = "",
      Unit = "",
      Value = "󰎠",
      Enum = "",
      Keyword = "󰌋",
      Snippet = "",
      Color = "󰏘",
      File = "󰈙",
      Reference = "",
      Folder = "󰉋",
      EnumMember = "",
      Constant = "󰇽",
      Struct = "",
      Event = "",
      Operator = "󰆕",
      TypeParameter = "󰊄",
    }

    cmp.setup({
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
      mapping = {
        ["<TAB>"] = nil,
        ["<S-TAB>"] = nil,
        ["<CR>"] = nil,
        ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select, }),
        ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select, }),
        ["<C-y>"] = cmp.mapping.confirm({ select = true, }),
      },
      sources = cmp.config.sources({
        { name = "luasnip", },
        { name = "nvim_lsp", },
        { name = "nvim_lua", },
        { name = "nvim_lsp_signature_help", },
        {
          name = "buffer",
          option = {
            keyword_pattern = [[\K\k*]],
          },
        },
        { name = "path", },
      }),
      formatting = {
        fields = { "kind", "abbr", "menu", },
        format = function(entry, vim_item)
          vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
          vim_item.menu = ({
            nvim_lsp = "[LSP]",
            luasnip = "[Snippet]",
            buffer = "[Buffer]",
            path = "[Path]",
          })[entry.source.name]
          return vim_item
        end,
      },
      completion = {
        completeopt = "menu,menuone,noselect,noinsert",
      },
      preselect = cmp.PreselectMode.None,
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      experimental = {
        native_menu = false,
        ghost_text = true,
      },
    })

    cmp.setup.filetype({ "sql", }, {
      sources = {
        { name = "vim-dadbod-completion", },
        { name = "buffer", },
      },
    })
  end,
}
