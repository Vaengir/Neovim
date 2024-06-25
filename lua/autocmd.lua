local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local usercmd = vim.api.nvim_create_user_command
local functions = require("functions")

autocmd("TextYankPost", {
  group = augroup("HighlightYank", {}),
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch",
      timeout = 100,
    })
  end,
})

autocmd("BufWritePre", {
  group = augroup("TrailingWhitespace", {}),
  pattern = "*",
  command = "%s/\\s\\+$//e",
})

autocmd("CursorMoved", {
  group = augroup("auto-hlsearch", {}),
  callback = function()
    if vim.v.hlsearch == 1 and vim.fn.searchcount().exact_match == 0 then
      vim.schedule(function() vim.cmd.nohlsearch() end)
    end
  end,
})

-- Disable 'o' adding a comment
autocmd("FileType", {
  group = augroup("format_options", {}),
  pattern = { "*", },
  callback = function()
    vim.opt.formatoptions:remove({ "o", })
  end,
})

usercmd("SqlMagic", function()
  functions.format_dat_sql()
end, {})
