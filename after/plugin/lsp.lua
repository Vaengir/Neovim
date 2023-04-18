local status_ok, lspzero = pcall(require, "lsp-zero")
if not status_ok then
  return
end

local status_ok, whichkey = pcall(require, "which-key")
if not status_ok then
  return
end

require "fidget".setup {}
require("luasnip/loaders/from_vscode").lazy_load()

vim.g.markdown_recommended_style = 0
vim.g.python_recommended_style = 0

local lsp = require('lsp-zero')

lsp.preset('recommended')

lsp.ensure_installed({
  "bashls",
  "cssls",
  "eslint",
  "html",
  "jdtls",
  "lua_ls",
  "marksman",
  "pyright",
  "texlab",
  "tsserver",
})

-- Preferences
lsp.set_preferences({
  sign_icons = {
    error = " ",
    warn = " ",
    hint = " ",
    info = " ",
  },
  set_lsp_keymaps = false,
})

-- Lua LSP Setup
lsp.configure('lua_ls', {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = { 'vim', 'beautiful', 'awesome', 'client', },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.stdpath "config" .. "/lua"] = true,
        },
      },
      format = {
        enable = true,
        defaultConfig = {
          indent_style = "space",
          indent_size = "2",
          max_line_length = "unset",
          trailing_table_separator = "always",
        },
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
})

-- Java LSP Setup
lsp.configure('jdtls', {
  settings = {
    java = {
      format = {
        settings = { url = "~/.config/nvim/lua/weiberle/jdtls/formatter.xml", },
      },
    },
  },
})

--   פּ ﯟ   some other good icons
local kind_icons = {
  Text = "",
  Method = "m",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "",
  Interface = "",
  Module = "",
  Property = "",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = "",
}

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select, }
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<C-y>'] = cmp.mapping.confirm({ select = true, }),
})

-- disable completion with tab
-- this helps with copilot setup
cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil
cmp_mappings['<CR>'] = nil

lsp.setup_nvim_cmp({
  mapping = cmp_mappings,
  sources = {
    { name = "nvim_lsp", },
    { name = "luasnip", },
    { name = "buffer", },
    { name = "path", },
  },
  formatting = {
    fields = { "kind", "abbr", "menu", },
    format = function(entry, vim_item)
      -- Kind icons
      vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
      -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
      vim_item.menu = ({
        nvim_lsp = "[LSP]",
        luasnip = "[Snippet]",
        buffer = "[Buffer]",
        path = "[Path]",
      })[entry.source.name]
      return vim_item
    end,
  },
  window = {
    documentation = {
      border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│", },
    },
  },
})

-- TODO: Update Keymaps with whichkey
lsp.on_attach(function(client, bufnr)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { buffer = bufnr, remap = false, desc = "Rename using LSP" })
  vim.keymap.set('n', 'ga', vim.lsp.buf.code_action, { buffer = bufnr, remap = false, desc = "Code Action" })
  vim.keymap.set('n', 'gn', vim.diagnostic.goto_next, { buffer = bufnr, remap = false, desc = "Goto next LSP Diagnostic" })
  vim.keymap.set('n', 'gp', vim.diagnostic.goto_prev, { buffer = bufnr, remap = false, desc = "Goto previous LSP Diagnostic" })
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr, remap = false, desc = "Open LSP Definition" })
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { buffer = bufnr, remap = false, desc = "Open LSP Implementation" })
  vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, { buffer = bufnr, remap = false, desc = "Show LSP References" })
  vim.keymap.set('n', 'gt', "<cmd>Telescope diagnostics<cr>", { buffer = bufnr, remap = false, desc = "Show LSP Diagnostics" })
  vim.keymap.set('n', 'B', vim.lsp.buf.hover, { buffer = bufnr, remap = false, desc = "Show LSP Info" })
end)

lsp.setup()

vim.diagnostic.config({
  virtual_text = true,
})
