require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "bashls", "cssls", "cssmodules_ls", "html", "jdtls", "sumneko_lua", "sqls", "marksman", "pyright", "tailwindcss" }
})

local on_attach = function(_, _)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {})
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {})

  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {})
  vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, {})
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
end

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}
require'lspconfig'.bashls.setup{
  on_attach = on_attach,
  flags = lsp_flags,
}
require'lspconfig'.cssls.setup {
  on_attach = on_attach,
  flags = lsp_flags,
}
require'lspconfig'.cssmodules_ls.setup{
  on_attach = on_attach,
  flags = lsp_flags,
}
require'lspconfig'.html.setup {
  on_attach = on_attach,
  flags = lsp_flags,
  configurationSection = { "html", "css", "javascript" },
  embeddedLanguages = {
    css = true,
    javascript = true
  },
  provideFormatter = true
}
require'lspconfig'.jdtls.setup {
  on_attach = on_attach,
  flags = lsp_flags,
  jvm_args = {},
  workspace = "/home/runner/.cache/jdtls/workspace"
}
require'lspconfig'.sumneko_lua.setup {
  on_attach = on_attach,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim', 'beautiful', 'awesome'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.stdpath "config" .. "/lua"] = true,
        },
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}
require('lspconfig').sqls.setup{
  on_attach = on_attach,
  flags = lsp_flags,
}
require('lspconfig').marksman.setup{
  on_attach = on_attach,
  flags = lsp_flags,
}
require'lspconfig'.pyright.setup{
  on_attach = on_attach,
  flags = lsp_flags,
  python = {
    analysis = {
      autoSearchPaths = true,
      diagnosticMode = "workspace",
      useLibraryCodeForTypes = true
    }
  }
}
require'lspconfig'.tailwindcss.setup{
  on_attach = on_attach,
  flags = lsp_flags,
  userLanguages = {
    eelixir = "html-eex",
    eruby = "erb"
  }
}
