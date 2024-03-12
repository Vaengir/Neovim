local M = {}

-- TODO: Remove obsidian part
-- create function for qflist here
M.project_files = function()
  local opts = {}
  local obsidian = os.execute("ls -la | grep -q .obsidian")
  local git = os.execute("git rev-parse --is-inside-work-tree")
  if obsidian == 0 then
    vim.cmd("ObsidianQuickSwitch")
  elseif git == 0 then
    require "telescope.builtin".git_files(opts)
  else
    require "telescope.builtin".find_files(opts)
  end
end

M.toggle_qf = function()
  if vim.fn.getqflist({ winid = 0, }).winid ~= 0 then
    vim.cmd("cclose")
  else
    vim.cmd("copen")
    vim.cmd("wincmd p")
  end
end

return M
