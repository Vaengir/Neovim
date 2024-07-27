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
  end
  return { valid_idx, qfwinnr, }
end

local run_formatter = function(text)
  text = text:gsub("`", "")
  local split = vim.split(text, "\n")
  local result = table.concat(split, "\n")

  local j = require("plenary.job"):new {
    command = "sleek",
    args = { "-U", "-i", "2", },
    writer = { result, },
  }
  return j:sync()
end

M.format_dat_sql = function(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()

  local queries = {
    sql =
    [[
((statement) @sql)
    ]],
    typescript =
    [[
((template_string) @sql)
    ]],
  }

  if not queries[vim.bo[bufnr].filetype] then
    vim.notify("This command can only be used for configured filetypes - Typescript, SQL")
    return
  end

  local parser = vim.treesitter.get_parser()
  local tree = parser:parse()[1]
  local root = tree:root()
  local lang = parser:lang()

  local query = queries[lang]
  local embedded_sql = vim.treesitter.query.parse(
    lang,
    query
  )

  local changes = {}
  for id, node in embedded_sql:iter_captures(root, bufnr) do
    local name = embedded_sql.captures[id]
    if name == "sql" then
      -- { start row, start col, end row, end col }
      local range = { node:range(), }
      local indentation = string.rep(" ", range[2])

      -- Run the formatter, based on the node text
      local formatted = run_formatter(vim.treesitter.get_node_text(node, bufnr))

      -- Add some indentation (can be anything you like!)
      for idx, line in ipairs(formatted) do
        if idx ~= 1 and line ~= "" then
          formatted[idx] = indentation .. line
        end
      end

      -- Keep track of changes
      --    But insert them in reverse order of the file,
      --    so that when we make modifications, we don't have
      --    any out of date line numbers
      if lang == "typescript" then
        table.insert(changes, 1, {
          start_row = range[1],
          start_col = range[2] + 1,
          end_row = range[3],
          end_col = range[4] - 1,
          formatted = formatted,
        })
      elseif lang == "sql" then
        table.insert(changes, 1, {
          start_row = range[1],
          start_col = range[2],
          end_row = range[3],
          end_col = range[4],
          formatted = formatted,
        })
      end
    end
  end

  for _, change in ipairs(changes) do
    vim.api.nvim_buf_set_text(bufnr, change.start_row, change.start_col, change.end_row, change.end_col, change.formatted)
  end
end

vim.api.nvim_create_user_command("SqlMagic", function()
  M.format_dat_sql()
end, {})

return M
