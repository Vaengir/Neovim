local options = {
  autoindent = true,                                                                     -- auto indent lines
  backup = false,                                                                        -- creates a backup file
  cmdheight = 2,                                                                         -- more space in the neovim command line for displaying messages
  fileencoding = "utf-8",                                                                -- the encoding written to a file
  hlsearch = true,                                                                       -- highlight all matches on previous search pattern
  incsearch = true,                                                                      -- highlight all matches incrementally
  ignorecase = true,                                                                     -- ignore case in search patterns
  pumheight = 10,                                                                        -- pop up menu height
  showmode = false,                                                                      -- hide things like -- INSERT -- not needed because of lualine
  smartcase = true,                                                                      -- smart case
  smartindent = true,                                                                    -- make indenting smarter again
  splitbelow = true,                                                                     -- force all horizontal splits to go below current window
  splitright = true,                                                                     -- force all vertical splits to go to the right of current window
  swapfile = false,                                                                      -- prevent swap file
  termguicolors = true,                                                                  -- set term gui colors (most terminals support this)
  timeoutlen = 500,                                                                      -- time to wait for a mapped sequence to complete (in milliseconds)
  undofile = true,                                                                       -- enable persistent undo
  updatetime = 300,                                                                      -- faster completion (4000ms default)
  writebackup = false,                                                                   -- if file is edited somewhere else it is not allowed to be edited
  expandtab = true,                                                                      -- convert tabs to spaces
  shiftwidth = 2,                                                                        -- the number of spaces inserted for each indentation
  tabstop = 2,                                                                           -- insert 2 spaces for a tab
  cursorline = true,                                                                     -- highlight the current line
  number = true,                                                                         -- set numbered lines
  relativenumber = true,                                                                 -- set relative numbered lines
  numberwidth = 4,                                                                       -- set number column width to 2 {default 4}
  signcolumn = "yes",                                                                    -- always show the sign column, otherwise it would shift the text each time
  wrap = false,                                                                          -- display lines as one long line
  colorcolumn = "120",                                                                   -- display a vertical line at 120 characters
  scrolloff = 10,                                                                        -- minimal number of screen lines above and below cursor
  sidescrolloff = 10,                                                                    -- minimal number of screen columns right and left of cursor
  guifont = "Hack NFM:H12",                                                              -- the font used in graphical neovim applications
  guicursor = "n-v-c-i:block",                                                           -- have cursor always as a block
  messagesopt = "wait:2000,history:500",                                                 -- disable 'Hit-Enter' Message
  conceallevel = 1,                                                                      -- allow concealment
  undodir = os.getenv("HOME") .. "/.config/nvim/undodir",                                -- allows undotree to have access to old undos
  diffopt = "internal,filler,closeoff,indent-heuristic,linematch:60,algorithm:histogram", -- configure diffview
}

vim.opt.nrformats:append({ "alpha", }) -- Allows letter incrementation
vim.g.markdown_recommended_style = 0   -- Disable default markdown style
vim.g.python_recommended_style = 0     -- Disable default python style

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.opt.list = true
vim.opt.listchars:append {
  leadmultispace = "▷ ",
  -- leadmultispace = "» ",
  trail = "·",
  multispace = "·",
  extends = "◣",
  precedes = "◢",
  nbsp = "○",
  eol = "↵",
}

vim.opt.foldenable = true
vim.opt.foldlevel = 99
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldtext = ""
vim.opt.foldcolumn = "0"
vim.opt.fillchars:append({ fold = " ", })
