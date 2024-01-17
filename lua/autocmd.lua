local augroup = vim.api.nvim_create_augroup
local WeiberleGroup = augroup("WeiberleGroup", {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup("HighlightYank", {})

autocmd("TextYankPost", {
  group = yank_group,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch",
      timeout = 100,
    })
  end,
})

autocmd("BufWritePre", {
  group = WeiberleGroup,
  pattern = "*",
  command = "%s/\\s\\+$//e",
})

autocmd("BufWritePre", {
  group = WeiberleGroup,
  callback = function(opts)
    if vim.bo[opts.buf].filetype == 'rust' then
      vim.cmd("compiler cargo")
    end
  end,
})
