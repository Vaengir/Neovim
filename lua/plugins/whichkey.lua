return {
  whi
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  config = function()
    local which_key = require("which-key")
    local harpoon = require("harpoon")

    which_key.setup({
      plugins = {
        marks = false,
        registers = true,
        spelling = {
          enabled = false,
          suggestions = 20,
        },
        presets = {
          operators = false,
          motions = true,
          text_objects = true,
          windows = true,
          nav = true,
          z = true,
          g = true,
        },
      },
      key_labels = {},
      icons = {
        breadcrumb = "»",
        separator = "➜",
        group = "+",
      },
      popup_mappings = {
      },
      window = {
        border = "single",
        position = "bottom",
        margin = { 1, 0, 1, 0, },
        padding = { 2, 2, 2, 2, },
        winblend = 0,
      },
      layout = {
        height = { min = 4, max = 25, },
        width = { min = 20, max = 50, },
        spacing = 3,
        align = "left",
      },
      ignore_missing = true,
      hidden = { "<silent>", "<cmd>", "<Cmd>", "<cr>", "call", "lua", "^:", "^ ", },
      show_help = true,
      show_keys = true,
      triggers = "auto",
      triggers_blacklist = {
        i = { "j", "k", },
        v = { "j", "k", },
      },
      disable = {
        buftypes = {},
        filetypes = { "TelescopePrompt", },
      },
    })

    local opts = {
      mode = "n",
      prefix = "<leader>",
      buffer = nil,
      silent = true,
      noremap = true,
      nowait = true,
    }

    local mappings = {
      ["["] = { "<cmd>call append(line('.')-1, repeat([''], v:count1))<cr>", "Insert Blank Line above", },
      ["]"] = { "<cmd>call append(line('.'), repeat([''], v:count1))<cr>", "Insert Blank Line below", },
      ["c"] = { "<cmd>bd<cr>", "Close Buffer", },
      ["d"] = { "\"_d", "Delete to void register", },
      ["e"] = { "<cmd>Oil<cr>", "Explorer", },
      g = {
        name = "Git",
        d = { "<cmd>Git pull --rebase<cr>", "Pull remote Changes", },
        g = { "<cmd>Ge:<cr>", "Open Fugitive", },
        h = { "<cmd>Gitsigns preview_hunk<cr>", "Preview Git Hunk", },
        p = { "<cmd>Git push<cr>", "Push local Changes", },
        s = { "<cmd>Git submodule update --remote<cr>", "Update submodules", },
        t = { "<cmd>Gitsigns toggle_current_line_blame<cr>", "Preview Git Hunk", },
      },
      ["m"] = { "<cmd>MarkdownPreviewToggle<cr>", "Markdown Preview", },
      o = {
        name = "Obsidian",
        ["b"] = { "<cmd>ObsidianBacklinks<cr>", "Location List of References", },
        ["d"] = { "<cmd>ObsidianToday<cr>", "Daily Note", },
        ["f"] = { "<cmd>ObsidianQuickSwitch<cr>", "Find Notes", },
        ["l"] = { "<cmd>ObsidianFollowLink<cr>", "Follow Link", },
        ["n"] = { "<cmd>ObsidianNew<cr>", "Create new Note", },
        ["o"] = { "<cmd>ObsidianOpen<cr>", "Open Note in Obsidian app", },
        ["s"] = { "<cmd>ObsidianSearch<cr>", "Find Text in Notes", },
        ["t"] = { "<cmd>ObsidianTemplate<cr>", "Insert Template", },
      },
      ["q"] = { "<cmd>q!<cr>", "Quit", },
      ["r"] = { "<cmd>LspRestart<cr>", "Restart Lsp Servers", },
      ["t"] = {
        name = "TODOs",
        f = { "<cmd>TodoTelescope<cr>", "Show TODOs", },
        n = { "<cmd>lua require('todo-comments').jump_next()<cr>", "Jump to next TODO", },
        p = { "<cmd>lua require('todo-comments').jump_prev()<cr>", "Jump to previous TODO", },
        q = { "<cmd>TodoQuickFix<cr>", "Send TODOs to Quickfix", },
      },
      ["u"] = { "<cmd>UndotreeToggle<cr>", "UndoTree", },
      ["w"] = { "<cmd>w!<cr>", "Save", },
      ["z"] = { "<cmd>ZenMode<cr>", "ZenMode", },
      f = {
        name = "Telescope",
        b = { "<cmd>Telescope buffers<cr>", "Show Buffers", },
        d = { "<cmd>Telescope git_status<cr>", "Show Git Diff", },
        f = { "<cmd>lua require('functions').project_files()<cr>", "Find Project Files", },
        h = { "<cmd>Telescope find_files hidden=true<cr>", "Find Hidden Files", },
        j = { "<cmd>Telescope jumplist<cr>", "Jumplist", },
        q = { "<cmd>Telescope quickfix<cr>", "Quickfixlist", },
        r = { "<cmd>Telescope lsp_references<cr>", "References", },
        s = { "<cmd>Telescope live_grep<cr>", "Find Strings", },
        v = { "<cmd>Telescope help_tags<cr>", "Find Help Entries", },
        w = { function()
          local word = vim.fn.expand("<cword>")
          require("telescope.builtin").grep_string({ search = word, })
        end, "Find word", },
        W = { function()
          local word = vim.fn.expand("<cWORD>")
          require("telescope.builtin").grep_string({ search = word, })
        end, "Find WORD", },
      },
      h = {
        name = "Harpoon",
        h = { function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, "Quick Menu", },
        m = { function() harpoon:list():append() end, "Mark File", },
        f = { function() harpoon:list():select(1) end, "Go To File 1", },
        d = { function() harpoon:list():select(2) end, "Go To File 2", },
        s = { function() harpoon:list():select(3) end, "Go To File 3", },
        a = { function() harpoon:list():select(4) end, "Go To File 4", },
      },
      l = {
        name = "VimTex",
        i = { "<cmd>VimtexInfo<cr>", "VimTex Info", },
        l = { "<cmd>VimtexCompile<cr>", "VimTex Compile", },
        s = { "<cmd>VimtexCompileSS<cr>", "VimTex Compile Once", },
      },
    }

    which_key.register(mappings, opts)
  end,
}
