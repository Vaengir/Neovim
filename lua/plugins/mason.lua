return {
  "williamboman/mason.nvim",
  dependencies = { "williamboman/mason-lspconfig.nvim", },
  version = "*",
  config = function()
    require("mason").setup()

    require("mason-lspconfig").setup({
      ensure_installed = {
        "bashls",
        "cssls",
        "html",
        "jdtls",
        "kotlin_language_server",
        "lua_ls",
        "marksman",
        "pyright",
        "rust_analyzer",
        "stylua",
        "texlab",
        "tsserver",
      },
    })
  end,
}
