return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-calc",
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

    local confirm = function(entry)
      local behavior = cmp.ConfirmBehavior.Replace
      if entry then
        local completion_item = entry.completion_item
        local newText = ""
        if completion_item.textEdit then
          newText = completion_item.textEdit.newText
        elseif type(completion_item.insertText) == "string" and completion_item.insertText ~= "" then
          newText = completion_item.insertText
        else
          newText = completion_item.word or completion_item.label or ""
        end
        local diff_after = math.max(0, entry.replace_range["end"].character + 1) - entry.context.cursor.col
        if entry.context.cursor_after_line:sub(1, diff_after) ~= newText:sub(-diff_after) then
          behavior = cmp.ConfirmBehavior.Insert
        end
      end
      cmp.confirm({ select = true, behavior = behavior, })
    end

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
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select, }),
        ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select, }),
        ["<C-y>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            local entry = cmp.get_selected_entry()
            confirm(entry)
          else
            fallback()
          end
        end, { "i", "s", }),
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
        { name = "calc", },
      }),
      formatting = {
        format = function(entry, vim_item)
          vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
          vim_item.menu = ({
            nvim_lsp = "[LSP]",
            luasnip = "[Snippet]",
            buffer = "[Buffer]",
            nvim_lua = "[Lua]",
            path = "[Path]",
          })[entry.source.name]
          return vim_item
        end,
      },
      completion = {
        completeopt = "menuone,noselect,noinsert,fuzzy",
      },
      preselect = cmp.PreselectMode.None,
      window = {
        completion = cmp.config.window.bordered({
          scrollbar = false,
        }),
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
        { name = "luasnip", },
      },
    })
  end,
}
