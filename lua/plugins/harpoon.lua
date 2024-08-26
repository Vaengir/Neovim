return {
  "vaengir/harpoon",
  version = "*",
  dependencies = { { "nvim-lua/plenary.nvim", }, },
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup({
      settings = {
        save_on_toggle = true,
      },
    })
  end,
  keys = {
    { "<leader>hh", function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end, desc = "Quick Menu", },
    { "<leader>hm", function() require("harpoon"):list():add() end,                                    desc = "Mark File", },
    { "<leader>hf", function() require("harpoon"):list():select(1) end,                                desc = "Go To File 1", },
    { "<leader>hd", function() require("harpoon"):list():select(2) end,                                desc = "Go To File 2", },
    { "<leader>hs", function() require("harpoon"):list():select(3) end,                                desc = "Go To File 3", },
    { "<leader>ha", function() require("harpoon"):list():select(4) end,                                desc = "Go To File 4", },
  },
}
