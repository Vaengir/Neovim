local options = {
  backup = false,			                  -- creates a backup file
  clipboard = "unnamedplus",		        -- allows neovim to access the system clipboard
  cmdheight = 2,			                  -- more space in the neovim command line for displaying messages
  fileencoding = "utf-8",		            -- the encoding written to a file
  hlsearch = true,			                -- highlight all matches on previous search pattern
  ignorecase = true,			              -- ignore case in search patterns
  pumheight = 10,			                  -- pop up menu height
  showmode = false,			                -- hide things like -- INSERT -- not needed because of lualine
  showtabline = 2,                      -- always show tabs
  smartcase = true,                     -- smart case
  smartindent = true,                   -- make indenting smarter again
  splitbelow = true,                    -- force all horizontal splits to go below current window
  splitright = true,                    -- force all vertical splits to go to the right of current window
  swapfile = false,                     -- prevent swap file
  termguicolors = true,                 -- set term gui colors (most terminals support this)
  timeoutlen = 100,                     -- time to wait for a mapped sequence to complete (in milliseconds)
  undofile = true,                      -- enable persistent undo
  updatetime = 300,                     -- faster completion (4000ms default)
  writebackup = false,                  -- if file is edited somewhere else it is not allowed to be edited
  expandtab = true,                     -- convert tabs to spaces
  shiftwidth = 2,                       -- the number of spaces inserted for each indentation
  tabstop = 2,                          -- insert 2 spaces for a tab
  cursorline = true,                    -- highlight the current line
  number = true,                        -- set numbered lines
  relativenumber = true,                -- set relative numbered lines
  numberwidth = 4,                      -- set number column width to 2 {default 4}
  signcolumn = "yes",                   -- always show the sign column, otherwise it would shift the text each time
  wrap = false,                         -- display lines as one long line
  scrolloff = 8,                        -- minimal number of screen lines above and below cursor
  sidescrolloff = 8,                    -- minimal number of screen columns right and left of cursor
  guifont = "monospace:h17",            -- the font used in graphical neovim applications
  guicursor = "n-v-c-i:block",          -- have cursor always as a block
}

for k, v in pairs(options) do
	vim.opt[k] = v
end
