local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local setup = {
  plugins = {
    marks = false,      -- shows a list of your marks on ' and `
    registers = true,   -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = false,  -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = false,   -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = true,      -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows = true,      -- default bindings on <c-w>
      nav = true,          -- misc bindings to work with windows
      z = true,            -- bindings for folds, spelling and others prefixed with z
      g = true,            -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  -- operators = { gc = "Comments" },
  key_labels = {
    -- override the label used to display some keys. It doesn't effect WK in any other way.
    -- For example:
    -- ["<space>"] = "SPC",
    -- ["<cr>"] = "RET",
    -- ["<tab>"] = "TAB",
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+",      -- symbol prepended to a group
  },
  popup_mappings = {
  },
  window = {
    border = "none",           -- none, single, double, shadow
    position = "bottom",       -- bottom, top
    margin = { 1, 0, 1, 0, },  -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2, }, -- extra window padding [top, right, bottom, left]
    winblend = 0,
  },
  layout = {
    height = { min = 4, max = 25, },                                             -- min and max height of the columns
    width = { min = 20, max = 50, },                                             -- min and max width of the columns
    spacing = 3,                                                                 -- spacing between columns
    align = "left",                                                              -- align columns left, center or right
  },
  ignore_missing = true,                                                         -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ ", }, -- hide mapping boilerplate
  show_help = true,                                                              -- show help message on the command line when the popup is visible
  show_keys = true,                                                              -- show the currently pressed key and its label as a message in the command line
  triggers = "auto",                                                             -- automatically setup triggers
  -- triggers = {"<leader>"} -- or specify a list manually
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { "j", "k", },
    v = { "j", "k", },
  },
  -- disable the WhichKey popup for certain buf types and file types.
  -- Disabled by deafult for Telescope
  disable = {
    buftypes = {},
    filetypes = { "TelescopePrompt", },
  },
}

local opts = {
  mode = "n",     -- NORMAL mode
  prefix = "<leader>",
  buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true,  -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true,  -- use `nowait` when creating keymaps
}

local mappings = {
  ["["] = { "<cmd>call append(line('.')-1, repeat([''], v:count1))<CR>", "Insert Blank Line above", },
  ["]"] = { "<cmd>call append(line('.'), repeat([''], v:count1))<CR>", "Insert Blank Line below", },
  ["c"] = { "<cmd>bd<CR>", "Close Buffer", },
  ["d"] = { "<cmd>pu=strftime('%d %b %Y')<CR>", "Insert Date", },
  ["e"] = { "<cmd>Oil<cr>", "Explorer", },
  g = {
    name = "Git",
    d = { "<cmd>Git pull<cr>", "Pull remote Changes", },
    g = { "<cmd>Ge:<cr>", "Open Fugitive", },
    p = { "<cmd>Git push<cr>", "Push local Changes", },
    s = { "<cmd>Git submodule update --remote<cr>", "Update submodules", },
  },
  ["m"] = { "<cmd>MarkdownPreviewToggle<cr>", "Markdown Preview", },
  ["q"] = { "<cmd>q!<CR>", "Quit", },
  ["u"] = { "<cmd>UndotreeToggle<CR>", "UndoTree", },
  ["w"] = { "<cmd>w!<CR>", "Save", },
  ["z"] = { "<cmd>ZenMode | IndentBlanklineToggle<cr>", "ZenMode", },
  f = {
    name = "Telescope",
    b = { "<cmd>Telescope buffers<cr>", "Show Buffers", },
    f = { "<cmd>Telescope find_files<cr>", "Find Files", },
    g = { "<cmd>Telescope git_status<cr>", "Git Status", },
    h = { "<cmd>Telescope find_files hidden=true<cr>", "Find Hidden Files", },
    j = { "<cmd>Telescope jumplist<cr>", "Jumplist", },
    q = { "<cmd>Telescope quickfix<cr>", "Quickfixlist", },
    r = { "<cmd>Telescope lsp_references<cr>", "References", },
    s = { "<cmd>Telescope live_grep<cr>", "Find Strings", },
    t = { "<cmd>TodoTelescope<cr>", "Show TODOs", },
  },
  h = {
    name = "Harpoon",
    h = { "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", "Quick Menu", },
    m = { "<cmd>lua require('harpoon.mark').add_file()<cr>", "Mark File", },
    d = { "<cmd>lua require('harpoon.mark').rm_file()<cr>", "Remove File", },
    w = { "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", "Go To File 1", },
    c = { "<cmd>lua require('harpoon.ui').nav_file(2)<cr>", "Go To File 2", },
    o = { "<cmd>lua require('harpoon.ui').nav_file(3)<cr>", "Go To File 3", },
    p = { "<cmd>lua require('harpoon.ui').nav_file(4)<cr>", "Go To File 4", },
  },
  l = {
    name = "VimTex",
    i = { "<cmd>VimtexInfo<cr>", "VimTex Info", },
    l = { "<cmd>VimtexCompile<cr>", "VimTex Compile", },
    s = { "<cmd>VimtexCompileSS<cr>", "VimTex Compile Once", },
  },
}

which_key.setup(setup)
which_key.register(mappings, opts)
