return {
  "mason-org/mason.nvim",
  dependencies = { "mason-org/mason-lspconfig.nvim", },
  version = "*",
  config = function()
    require("mason").setup()

    require("mason-lspconfig").setup({
      automatic_enable = false,
      ensure_installed = {
        "bashls",
        "cssls",
        "harper_ls",
        "html",
        "jdtls",
        "kotlin_language_server",
        "lua_ls",
        "marksman",
        "pyright",
        "rust_analyzer",
        "texlab",
        "ts_ls",
        "zls",
      },
    })
  end,
}
