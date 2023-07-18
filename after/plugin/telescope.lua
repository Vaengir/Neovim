local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local actions = require "telescope.actions"

require('telescope').setup {
  defaults = {
    prompt_prefix = " ",
    selection_caret = " ",
    path_display = { "smart", },

    mappings = {
      i = {
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["jk"] = actions.close,
        ["<C-h>"] = "which_key",
      },
    },
  },
}

local M = {}

-- call via:
-- :lua require"telescope-config".project_files()
M.project_files = function()
  local opts = {} -- define here if you want to define something
  vim.fn.system('git rev-parse --is-inside-work-tree')
  if vim.v.shell_error == 0 then
    require "telescope.builtin".git_files(opts)
  else
    require "telescope.builtin".find_files(opts)
  end
end

return M
