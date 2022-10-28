-- Utilities for creating configurations
local util = require "weiberle.formatter.util"

-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
require("formatter").setup {
  -- Enable or disable logging
  logging = true,
  -- Set the log level
  log_level = vim.log.levels.WARN,
  -- All formatter configurations are opt-in
  filetype = {
    java = { require("weiberle.formatter.filetypes.any")},
    css = { require("weiberle.formatter.filetypes.css")},
    html = { require("weiberle.formatter.filetypes.html")},
    lua = { require("weiberle.formatter.filetypes.lua").stylua },
    markdown = { require("weiberle.formatter.filetypes.markdown")},
    php = { require("weiberle.formatter.filetypes.php")},
    python = { require("weiberle.formatter.filetypes.python")},
    sql = { require("weiberle.formatter.filetypes.sql")},
    -- Use the special "*" filetype for defining formatter configurations on
    -- any filetype
    ["*"] = {
      -- "formatter.filetypes.any" defines default configurations for any
      -- filetype
      require("formatter.filetypes.any").remove_trailing_whitespace
    }
  }
}
