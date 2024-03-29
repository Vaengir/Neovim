return {
  "epwalsh/obsidian.nvim",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "private",
        path = "~/personal/PersonalVault",
      },
      -- {
      --   name = "work",
      --   path = "~/work/obsidian",
      -- },
    },
    notes_subdir = "98-Inbox",
    log_level = vim.log.levels.INFO,
    daily_notes = {
      folder = "05-Daily",
      date_format = "%Y-%m-%d",
      template = "Daily.md",
    },
    -- Needs to be here, otherwise it interferes with whichkey
    mappings = {},
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
  },
}
