local M = {}

M.project_files = function()
  local opts = {}
  vim.fn.system("git rev-parse --is-inside-work-tree")
  if vim.v.shell_error == 0 then
    require("telescope.builtin").git_files(opts)
  else
    require("telescope.builtin").find_files(opts)
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

M.qf_infos = function()
  local qfwinnr = vim.fn.getqflist({ winid = 0, }).winid
  local qf_list = vim.fn.getqflist()
  local valid_idx = {}
  for idx, item in ipairs(qf_list) do
    if item.valid == 1 then
      table.insert(valid_idx, idx)
    end
  end
  if next(valid_idx) == nil then
    print("Quickfix list is empty")
    return nil
  end
  return { valid_idx, qfwinnr, }
end

return M
