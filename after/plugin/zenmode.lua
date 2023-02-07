local status_ok, zenmode = pcall(require, "zen-mode")
if not status_ok then
  return
end

require("zen-mode").setup {
  window = {
    width = 120, -- width of the Zen window
    height = 0.9, -- height of the Zen window
    options = {
      scrolloff = 999,
      -- signcolumn = "no", -- disable signcolumn
      -- number = false, -- disable number column
      -- relativenumber = false, -- disable relative numbers
      -- cursorline = false, -- disable cursorline
      -- cursorcolumn = false, -- disable cursor column
      -- foldcolumn = "0", -- disable fold column
      -- list = false, -- disable whitespace characters
    },
  },
  plugins = {
    options = {
      enabled = true,
    },
    gitsigns = { enabled = false }, -- disables git signs
  },
  -- callback where you can add custom code when the Zen window opens
  on_open = function()
    vim.wo.wrap = true
  end,
  -- callback where you can add custom code when the Zen window closes
  on_close = function()
    vim.wo.wrap = false
  end,
}
