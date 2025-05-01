vim.cmd("compiler zig_build")
vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4

vim.opt_local.listchars:append {
  leadmultispace = "▷   ",
  -- leadmultispace = "»   ",
}
