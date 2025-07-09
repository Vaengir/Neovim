return {
  "nvim-lualine/lualine.nvim",
  dependencies = "letieu/harpoon-lualine",
  config = function()
    local lualine = require("lualine")

    local filename = {
      "filename",
      path = 1,
      fmt = function(str)
        str = str:sub(-28)
        local pos = str:find("/")
        if pos and #str >= 27 then
          str = str:sub(pos + 1)
        end
        return str
      end,
      color = { bg = "", },
      padding = { left = 10, right = 1, },
    }

    local diagnostics = {
      "diagnostics",
      sources = { "nvim_diagnostic", },
      sections = { "error", "warn", },
      symbols = { error = " ", warn = " ", },
      colored = false,
      update_in_insert = false,
      always_visible = false,
      color = { bg = "", },
    }


    local harpoon = {
      "harpoon2",
      _separator = " ",
      icon = "",
      indicators = { " 1 ", " 2 ", " 3 ", " 4 ", },
      active_indicators = { "[1]", "[2]", "[3]", "[4]", },
      no_harpoon = "",
      padding = { left = 30, right = 50, },
      color = { fg = "#88c0d0", },
      cond = function()
        return vim.fn.winwidth(0) > 100
      end,
    }

    local cursor_position = {
      "location",
      color = { bg = "", },
      padding = { left = 10, right = 1, },
    }

    local progress = function()
      local current_line = vim.fn.line(".")
      local total_lines = vim.fn.line("$")
      local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██", }
      local line_ratio = current_line / total_lines
      local index = math.ceil(line_ratio * #chars)
      return chars[index]
    end

    local progress_widget = {
      progress,
      color = { bg = "", fg = "#88c0d0", },
      padding = { left = 1, right = 10, },
    }

    local function getGuiFont()
      return vim.api.nvim_get_option_value("guifont", {})
    end

    lualine.setup({
      options = {
        icons_enabled = true,
        theme = "onenord",
        component_separators = "",
        section_separators = "",
        disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline", },
        always_divide_middle = true,
      },
      sections = {
        lualine_a = {},
        lualine_b = { filename, diagnostics, },
        lualine_c = {},
        lualine_x = { harpoon, },
        lualine_y = { cursor_position, },
        lualine_z = { progress_widget, },
      },
      inactive_sections = {
        lualine_a = { filename, diagnostics, },
        lualine_b = {},
        lualine_c = {},
        lualine_x = { cursor_position, getGuiFont, },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      extensions = {},
    })
  end,
}
