return {
  "obsidian-nvim/obsidian.nvim",
  version = "*",
  opts = {
    workspaces = {
      {
        name = "private",
        path = "~/Documents/Obsidian",
      },
    },
    notes_subdir = "98-Inbox",
    log_level = vim.log.levels.INFO,
    daily_notes = {
      folder = "05-Daily",
      date_format = "%Y-%m-%d",
      template = "Daily.md",
    },
    note_id_func = function(title)
      local suffix = ""
      if title ~= nil then
        return title
      else
        suffix = "Note"
        return tostring(os.date("%Y-%m-%d %H-%M")) .. "-" .. suffix
      end
    end,
    wiki_link_func = "prepend_note_id",
    note_frontmatter_func = function(note)
      local out = { id = note.id, tags = note.tags, date = os.date("%Y-%m-%d %H:%M"), }
      if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
        for k, v in pairs(note.metadata) do
          out[k] = v
        end
      end
      return out
    end,
    templates = {
      subdir = "99-Templates",
      date_format = "%Y-%m-%d",
      time_format = "%H:%M",
    },
    follow_url_func = function(url)
      vim.fn.jobstart({ "open", url, })
    end,
    use_advanced_uri = true,
    callbacks = {
      leave_note = function(client, note)
        vim.api.nvim_buf_call(note.bufnr or 0, function()
          vim.cmd "silent w"
        end)
      end,
    },
    -- Disable legacy commands message
    legacy_commands = false,
  },
  keys = {
    { "<leader>fo", "<cmd>Obsidian quick_switch<cr>", desc = "Find Notes", },
    { "<leader>ob", "<cmd>Obsidian backlinks<cr>",    desc = "Location List of References", },
    { "<leader>od", "<cmd>Obsidian today<cr>",        desc = "Daily Note", },
    { "<leader>of", "<cmd>Obsidian quick_switch<cr>", desc = "Find Notes", },
    { "<leader>ol", "<cmd>Obsidian follow_link<cr>",  desc = "Follow Link", },
    { "<leader>on", "<cmd>Obsidian new<cr>",          desc = "Create new Note", },
    { "<leader>oo", "<cmd>Obsidian open<cr>",         desc = "Open Note in Obsidian app", },
    { "<leader>os", "<cmd>Obsidian search<cr>",       desc = "Find Text in Notes", },
    { "<leader>ot", "<cmd>Obsidian template<cr>",     desc = "Insert Template", },
  },
}
