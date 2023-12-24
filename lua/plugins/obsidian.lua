return {
  "epwalsh/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,
  cmd = { "ObsidianBacklinks", "ObsidianToday", "ObsidianQuickSwitch", "ObsidianNew", "ObsidianOpen", "ObsidianSearch", "ObsidianTemplate", },
  event = {
    "BufReadPre " .. vim.fn.expand "~" .. "/personal/obsidian/**.md",
    "BufNewFile " .. vim.fn.expand "~" .. "/personal/obsidian/**.md",
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "personal",
        path = "~/personal/obsidian",
      },
      {
        name = "work",
        path = "~/work/obsidian",
      },
    },
    notes_subdir = "Inbox",
    detect_cwd = false,
    log_level = vim.log.levels.INFO,
    daily_notes = {
      folder = "Daily",
      date_format = "%Y-%m-%d",
      template = "Daily.md",
    },
    completion = {
      nvim_cmp = true,
      min_chars = 2,
      new_notes_location = "notes_subdir",
    },
    -- Needs to be here, otherwise it interferes with whichkey
    mappings = {},
    note_id_func = function(title)
      local suffix = ""
      if title ~= nil then
        return title
      else
        suffix = "Note"
        return tostring(os.date('%Y-%m-%d %H-%M')) .. "-" .. suffix
      end
    end,
    disable_frontmatter = false,
    note_frontmatter_func = function(note)
      local out = { id = note.id, tags = note.tags, date = os.date('%Y-%m-%d %H:%M'), }
      if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
        for k, v in pairs(note.metadata) do
          out[k] = v
        end
      end
      return out
    end,
    templates = {
      subdir = "Templates",
      date_format = "%Y-%m-%d",
      time_format = "%H:%M",
    },
    follow_url_func = function(url)
      vim.fn.jobstart({ "open", url, }) -- Mac OS
    end,
    use_advanced_uri = true,
    open_app_foreground = false,
    finder = "telescope.nvim",
    ui = {
      enable = true,
      update_debounce = 200,
      checkboxes = {
        [" "] = { char = "󰄱", hl_group = "ObsidianTodo", },
        ["x"] = { char = "", hl_group = "ObsidianDone", },
        [">"] = { char = "", hl_group = "ObsidianRightArrow", },
        ["~"] = { char = "󰰱", hl_group = "ObsidianTilde", },
      },
      external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon", },
      reference_text = { hl_group = "ObsidianRefText", },
      highlight_text = { hl_group = "ObsidianHighlightText", },
      tags = { hl_group = "ObsidianTag", },
      hl_groups = {
        ObsidianTodo = { bold = true, fg = "#f78c6c", },
        ObsidianDone = { bold = true, fg = "#89ddff", },
        ObsidianRightArrow = { bold = true, fg = "#f78c6c", },
        ObsidianTilde = { bold = true, fg = "#ff5370", },
        ObsidianRefText = { underline = true, fg = "#c792ea", },
        ObsidianExtLinkIcon = { fg = "#c792ea", },
        ObsidianTag = { italic = true, fg = "#89ddff", },
        ObsidianHighlightText = { bg = "#75662e", },
      },
    },
  },
}
