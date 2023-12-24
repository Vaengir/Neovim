return {
  "williamboman/mason.nvim",
  dependencies = { "williamboman/mason-lspconfig.nvim", },
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
        "texlab",
        "tsserver",
      },
    })
  end,
}
