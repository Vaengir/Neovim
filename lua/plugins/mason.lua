return {
  "williamboman/mason.nvim",
  dependencies = { "williamboman/mason-lspconfig.nvim", },
  opts = function(_, opts)
    vim.list_extend(opts.ensure_installed, {
      "bashls",
      "cssls",
      "html",
      "jdtls",
      "kotlin_language_server",
      "lua_ls",
      "marksman",
      "pyright",
      "rust_analyzer",
      "texlab",
      "tsserver",
    })
  end,
}
