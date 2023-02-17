local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

configs.setup({
  ensure_installed = {
    "bash",
    "bibtex",
    "css",
    "html",
    "java",
    "javascript",
    "lua",
    "latex",
    "markdown",
    "php",
    "python",
    "svelte",
    "typescript",
    "vim",
  },
  highlight = {
    enable = true, -- false will disable the whole extension
  },
  autopairs = {
    enable = true,
  },
  indent = { enable = true, disable = {}, },
  additional_vim_regex_highlighting = false,
})
