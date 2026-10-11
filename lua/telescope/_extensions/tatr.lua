local telescope = require("telescope")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values

local function project_root()
  local out = vim.fn.systemlist("git rev-parse --show-toplevel")
  if vim.v.shell_error == 0 and out[1] then
    return out[1]
  end
  return vim.uv.cwd() or "."
end

local function tatr_tasks(opts)
  opts = opts or {}
  local query = opts.query or ""
  local root = project_root()

  local cmd = { "tatr", "ls" }
  vim.list_extend(cmd, vim.split(query, "%s+", { trimempty = true }))
  local res = vim.system(cmd, { cwd = root, text = true }):wait()
  local stdout = res.stdout or ""
  if res.code ~= 0 then
    local err = res.stderr
    if not err or err == "" then
      err = stdout
    end
    vim.notify(err, vim.log.levels.ERROR)
    return
  end

  pickers.new(opts, {
    prompt_title = "Tasks" .. (query ~= "" and (" (" .. query .. ")") or ""),
    finder = finders.new_table({
      results = vim.split(res.stdout, "\n", { trimempty = true }),
      entry_maker = function(line)
        local path, lnum, text = line:match("^(.-):(%d+): (.*)$")
        if not path then
          return nil
        end
        path = vim.fs.normalize(root .. "/" .. path:gsub("^%./", ""))
        return {
          value = line,
          display = text,
          ordinal = text,
          filename = path,
          lnum = tonumber(lnum),
        }
      end,
    }),
    sorter = conf.generic_sorter(opts),
    previewer = conf.grep_previewer(opts),
  }):find()
end

return telescope.register_extension({
  exports = {
    tatr = tatr_tasks,
  },
})
