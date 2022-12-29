local status_ok, lspzero = pcall(require, "lsp-zero")
if not status_ok then
  return
end

require "fidget".setup {}

local lsp = require('lsp-zero')

lsp.preset('recommended')

lsp.ensure_installed({
  "bashls",
  "cssls",
  "cssmodules_ls",
  "html",
  "jdtls",
  "sumneko_lua",
  "sqls",
  "marksman",
  "pyright",
  "tailwindcss"
})

-- Preferences
lsp.set_preferences({
  sign_icons = {
    error = " ",
    warn = " ",
    hint = " ",
    info = " "
  },
  set_lsp_keymaps = false,
})

-- Lua LSP Setup
lsp.configure('sumneko_lua', {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = { 'vim', 'beautiful', 'awesome', 'client' },
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
        }
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    }
  }
})

-- Java LSP Setup
lsp.configure('jdtls', {
  settings = {
    java = {
      format = {
        settings = { url = "~/.config/nvim/lua/weiberle/jdtls/formatter.xml" }
      }
    }
  }
})

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<C-y>'] = cmp.mapping.confirm({ select = true }),
  ["<C-Space>"] = cmp.mapping.complete(),
})

-- disable completion with tab
-- this helps with copilot setup
cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
  mapping = cmp_mappings
})

lsp.on_attach(function(client, bufnr)
  local opts = { buffer = bufnr, remap = false }
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
  vim.keymap.set('n', 'ga', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', 'gn', vim.diagnostic.goto_next, opts)
  vim.keymap.set('n', 'gp', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
  vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, opts)
  vim.keymap.set('n', 'gt', "<cmd>Telescope diagnostics<cr>", opts)
  vim.keymap.set('n', 'B', vim.lsp.buf.hover, opts)
end)

lsp.setup()

vim.diagnostic.config({
  virtual_text = true,
})
