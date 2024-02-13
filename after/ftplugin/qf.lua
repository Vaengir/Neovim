vim.opt_local.scrolloff = 0
vim.cmd("let &l:winheight = &lines / 3")

local augroup = vim.api.nvim_create_augroup
local WeiberleGroup = augroup("WeiberleGroup", {})
local autocmd = vim.api.nvim_create_autocmd

autocmd("CursorMoved", {
  group = WeiberleGroup,
  buffer = 0,
  callback = function()
    vim.cmd("normal! zt")
  end,
})
