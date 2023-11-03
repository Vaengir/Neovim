require("weiberle")

local augroup = vim.api.nvim_create_augroup
local WeiberleGroup = augroup('WeiberleGroup', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

autocmd('TextYankPost', {
  group = yank_group,
  pattern = '*',
  callback = function()
    vim.highlight.on_yank({
      higroup = 'IncSearch',
      timeout = 40,
    })
  end,
})

autocmd({ "BufWritePre", }, {
  group = WeiberleGroup,
  pattern = "*",
  command = "%s/\\s\\+$//e",
})
