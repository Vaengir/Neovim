return {
  "L3MON4D3/LuaSnip",
  version = "*",
  build = "make install_jsregexp",
  dependencies = {
    {
      "kawre/neotab.nvim",
      opts = {
        tabkey = "",
        act_as_tab = false,
      },
    },
  },
  event = "InsertEnter",
  config = function()
    local ls = require("luasnip")
    local types = require("luasnip.util.types")

    ls.setup({
      keep_roots = true,
      link_roots = false,
      link_children = true,
      update_events = "TextChanged,TextChangedI",
      delete_check_events = "TextChanged",
      ext_opts = {
        [types.choiceNode] = {
          active = {
            virt_text = { { " ●", "Define", }, },
          },
        },
        [types.insertNode] = {
          active = {
            virt_text = { { " ●", "Include", }, },
          },
        },
      },
      ext_base_prio = 300,
      ext_prio_increase = 1,
      enable_autosnippets = true,
    })

    require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/lua/snippets", })

    vim.keymap.set({ "i", "s", }, "<c-k>", function()
      if ls.expand_or_jumpable() then
        ls.expand_or_jump()
      else
        require("neotab").tabout()
      end
    end, { silent = true, })

    vim.keymap.set({ "i", "s", }, "<c-j>", function()
      if ls.jumpable(-1) then
        ls.jump(-1)
      end
    end, { silent = true, })

    vim.keymap.set({ "i", "s", }, "<c-l>", function()
      if ls.choice_active() then
        ls.change_choice(1)
      end
    end)
  end,
}
