return {
  "lervag/vimtex",
  lazy = false,
  init = function()
    vim.g.vimtex_quickfix_open_on_warning = 0
    vim.g.vimtex_mappings_enabled = false
    vim.g.vimtex_format_enabled = false
  end,
  keys = {
    { "<leader>li", "<cmd>VimtexInfo<cr>",      desc = "VimTeX Info", },
    { "<leader>ll", "<cmd>VimtexCompile<cr>",   desc = "VimTeX Compile", },
    { "<leader>ls", "<cmd>VimtexCompileSS<cr>", desc = "VimTeX Compile Once", },
  },
}
