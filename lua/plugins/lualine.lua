return {
  "nvim-lualine/lualine.nvim",
  dependencies = "letieu/harpoon-lualine",
  config = function()
    local lualine = require("lualine")

    local hide_in_width = function()
      return vim.fn.winwidth(0) > 80
    end

    --- @param trunc_width number trunctates component when screen width is less then trunc_width
    --- @param trunc_len number truncates component to trunc_len number of chars
    --- @param hide_width number | nil hides component when window width is smaller then hide_width
    --- @param no_ellipsis boolean whether to disable adding '...' at end after truncation
    --- return function that can format the component accordingly
    local function trunc(trunc_width, trunc_len, hide_width, no_ellipsis)
      return function(str)
        local win_width = vim.fn.winwidth(0)
        if hide_width and win_width < hide_width then
          return ""
        elseif trunc_width and trunc_len and win_width < trunc_width and #str > trunc_len then
          return str:sub(1, trunc_len) .. (no_ellipsis and "" or "...")
        end
        return str
      end
    end

    local diagnostics = {
      "diagnostics",
      sources = { "nvim_diagnostic", },
      sections = { "error", "warn", },
      symbols = { error = " ", warn = " ", },
      colored = false,
      update_in_insert = false,
      always_visible = false,
    }

    local diff = {
      "diff",
      colored = false,
      symbols = { added = " ", modified = " ", removed = " ", },
      cond = hide_in_width,
    }

    local mode = {
      "mode",
      fmt = function(str)
        return "-- " .. str .. " --"
      end,
    }

    local function getGuiFont()
      return vim.api.nvim_get_option_value("guifont", {})
    end

    local filetype = {
      "filetype",
      icons_enabled = true,
      icon = nil,
    }

    local branch = {
      "branch",
      icons_enabled = true,
      icon = "",
      fmt = trunc(120, 6, nil, true),
    }

    local cursor_position = {
      "location",
      padding = 1,
    }
    local progress = function()
      local current_line = vim.fn.line(".")
      local total_lines = vim.fn.line("$")
      local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██", }
      local line_ratio = current_line / total_lines
      local index = math.ceil(line_ratio * #chars)
      return chars[index]
    end

    lualine.setup({
      options = {
        icons_enabled = true,
        theme = "onenord",
        component_separators = { left = "", right = "", },
        section_separators = { left = "", right = "", },
        disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline", },
        always_divide_middle = true,
      },
      sections = {
        lualine_a = { branch, diagnostics, },
        lualine_b = { mode, },
        lualine_c = { { "filename", separator = "", }, { "%=", separator = "", }, { "harpoon2", separator = " ", }, },
        -- lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_x = { --[[ {getGuiFont}, diff, ]] "encoding", filetype, },
        lualine_y = { cursor_position, },
        lualine_z = { progress, },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = { "location", getGuiFont, },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      extensions = {},
    })
  end,
}
