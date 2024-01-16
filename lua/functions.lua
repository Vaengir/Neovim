local M = {}

M.project_files = function()
  local opts = {}
  vim.fn.system("git rev-parse --is-inside-work-tree")
  if vim.v.shell_error == 0 then
    require "telescope.builtin".git_files(opts)
  else
    require "telescope.builtin".find_files(opts)
  end
end

M.toggle_qf = function()
  for _, win in pairs(vim.fn.getwininfo()) do
    if win["quickfix"] == 1 then
      vim.cmd("cclose")
    else
      vim.cmd("copen")
      vim.cmd("wincmd p")
    end
  end
end

return M
