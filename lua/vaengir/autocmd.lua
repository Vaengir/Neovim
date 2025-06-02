local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local usercmd = vim.api.nvim_create_user_command

autocmd("TextYankPost", {
  group = augroup("HighlightYank", {}),
  pattern = "*",
  callback = function()
    vim.hl.on_yank({
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

autocmd("FileType", {
  group = augroup("quickfix", {}),
  pattern = { "qf", },
  callback = function(ev)
    local winid = vim.fn.bufwinid(ev.buf)
    local height = math.floor(vim.o.lines / 3)
    vim.api.nvim_win_set_height(winid, height)
  end,
})

autocmd({ "InsertEnter", "CursorMovedI", }, {
  callback = function()
    if vim.api.nvim_get_mode().mode ~= "i" then
      return
    end
    local cmploaded, config = pcall(require, "cmp.config")
    if cmploaded then
      local cursor_column = vim.fn.col(".")
      local current_line_contents = vim.fn.getline(".")
      local character_after_cursor = current_line_contents:sub(cursor_column, cursor_column)
      local should_enable_ghost_text = character_after_cursor == "" or vim.fn.match(character_after_cursor, [[\k]]) == -1
      local current = config.get().experimental.ghost_text
      if current ~= should_enable_ghost_text then
        config.set_global({
          experimental = {
            ghost_text = should_enable_ghost_text,
          },
        })
      end
    end
  end,
})

usercmd("SqlMagic", function()
  require("vaengir.functions").format_dat_sql()
end, {})
