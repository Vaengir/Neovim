return {
  "goolord/alpha-nvim",
  dependencies = { "nvim-tree/nvim-web-devicons", },
  cmd = "Alpha",
  event = function()
    if vim.fn.argc() == 0 then
      return "VimEnter"
    end
  end,
  config = function()
    local alpha = require("alpha")

    local dashboard = require("alpha.themes.dashboard")
    dashboard.section.header.val = {
      [[                                                 ]],
      [[███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗]],
      [[████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║]],
      [[██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║]],
      [[██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║]],
      [[██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║]],
      [[╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
      [[                                                  ]],
    }
    --
    -- [[ ██╗       ██╗███████╗██╗██████╗ ███████╗██████╗ ██╗     ███████╗]],
    -- [[ ██║  ██╗  ██║██╔════╝██║██╔══██╗██╔════╝██╔══██╗██║     ██╔════╝]],
    -- [[ ╚██╗████╗██╔╝█████╗  ██║██████╦╝█████╗  ██████╔╝██║     █████╗  ]],
    -- [[  ████╔═████║ ██╔══╝  ██║██╔══██╗██╔══╝  ██╔══██╗██║     ██╔══╝  ]],
    -- [[  ╚██╔╝ ╚██╔╝ ███████╗██║██████╦╝███████╗██║  ██║███████╗███████╗]],
    -- [[   ╚═╝   ╚═╝  ╚══════╝╚═╝╚═════╝ ╚══════╝╚═╝  ╚═╝╚══════╝╚══════╝]],
    -- }

    dashboard.section.buttons.val = {
      dashboard.button("f", "󰈞  Find file", "<cmd>lua require'telescope-function'.project_files()<cr>"),
      dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
      dashboard.button("r", "󰄉  Recently used files", ":Telescope oldfiles <CR>"),
      dashboard.button("t", "󰊄  Find text", ":Telescope live_grep <CR>"),
      dashboard.button("l", "󰒲  Lazy", ":Lazy<CR>"),
      dashboard.button("m", "󰒋  Mason", ":Mason<CR>"),
      dashboard.button("c", "  Configuration", ":e ~/.config/nvim/<CR>"),
      dashboard.button("q", "󰅚  Quit Neovim", ":qa<CR>"),
    }

    local function footer()
      return "Weiberle17"
    end

    dashboard.section.footer.val = footer()

    dashboard.section.footer.opts.hl = "Type"
    dashboard.section.header.opts.hl = "Include"
    dashboard.section.buttons.opts.hl = "Keyword"

    dashboard.opts.opts.noautocmd = true
    alpha.setup(dashboard.opts)
  end,
};
