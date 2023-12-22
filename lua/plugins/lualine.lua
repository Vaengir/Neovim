return {
  "nvim-lualine/lualine.nvim",
  config = function()
    local lualine = require("lualine")

    local hide_in_width = function()
      return vim.fn.winwidth(0) > 80
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
      symbols = { added = " ", modified = " ", removed = " ", }, -- changes diff symbols
      cond = hide_in_width,
    }

    local mode = {
      "mode",
      fmt = function(str)
        return "-- " .. str .. " --"
      end,
    }

    local function getGuiFont()
      return vim.api.nvim_get_option("guifont")
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
    }

    local cursor_position = {
      "location",
      padding = 1,
    }

    -- cool function for progress
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
        component_separators = { left = '', right = '', },
        section_separators = { left = '', right = '', },
        disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline", },
        always_divide_middle = true,
      },
      sections = {
        lualine_a = { branch, diagnostics, },
        lualine_b = { mode, },
        lualine_c = { "filename", },
        -- lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_x = { --[[ {getGuiFont}, ]] diff, "encoding", filetype, },
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
