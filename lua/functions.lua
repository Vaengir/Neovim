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

---@return { empty_qflist: boolean, multiple_valid_idx: boolean, qfwinnr: number }
M.qf_infos = function()
  ---@type number
  local qfwinnr = vim.fn.getqflist({ winid = 0, }).winid
  local qf_list = vim.fn.getqflist()
  local valid_idx = {}
  for idx, item in ipairs(qf_list) do
    if item.valid == 1 then
      table.insert(valid_idx, idx)
    end
  end
  local empty_qflist = next(valid_idx) == nil
  local multiple_valid_idx = #valid_idx > 1
  return { empty_qflist, multiple_valid_idx, qfwinnr, }
end

M.custom_cn = function()
  local qf_infos = require("functions").qf_infos()
  if qf_infos[1] then
    vim.notify("Quickfix list is empty\n", vim.log.levels.WARN)
    return nil
  end
  if not qf_infos[2] then
    vim.cmd(".cc")
    vim.cmd("normal! zz")
    return nil
  else
    local ok, _ = pcall(vim.cmd.cn)
    if not ok then
      vim.notify("Already on last item of Quickfix list\n", vim.log.levels.WARN)
      return nil
    end
    vim.cmd("normal! zz")
    vim.api.nvim_win_call(qf_infos[3], function()
      vim.cmd("normal! zt")
    end)
  end
end

M.custom_cp = function()
  local qf_infos = require("functions").qf_infos()
  if qf_infos[1] then
    vim.notify("Quickfix list is empty\n", vim.log.levels.WARN)
    return nil
  end
  local ok, _ = pcall(vim.cmd.cp)
  if not ok then
    vim.notify("Already on first item of Quickfix list\n", vim.log.levels.WARN)
    return nil
  end
  vim.cmd("normal! zz")
  vim.api.nvim_win_call(qf_infos[3], function()
    vim.cmd("normal! zt")
  end)
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
    rust_with_rstml =
    [[
(call_expression
  function: (field_expression
    value: (macro_invocation
      macro: (scoped_identifier
        path: (identifier) @path (#eq? @path "sqlx")
        name: (identifier) @name (#eq? @name "query_as")))))
  (token_tree
    (raw_string_literal
      (string_content) @sql))
      ]],
    rust =
    [[
(macro_invocation
  (scoped_identifier
    path: (identifier) @path (#eq? @path "sqlx")
    name: (identifier) @name (#eq? @name "query_as"))

  (token_tree
    (raw_string_literal
      (string_content) @sql)))
      ]],
    sql =
    [[
((statement) @sql)
    ]],
    typescript =
    [[
((template_string) @sql)
    ]],
  }

  if not queries[vim.bo[bufnr].filetype] and not queries["rust_with_rstml"] then
    vim.notify("This command can only be used for configured filetypes:\n - Typescript\n- SQL\n- Rust\n- rust_with_rstml((using the tree-sitter-rstml)[https://github.com/rayliwell/tree-sitter-rstml])\n", vim.log.levels.ERROR)
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
      else
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

return M
