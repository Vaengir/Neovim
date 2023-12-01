local opts = { noremap = true, silent = true, }

local term_opts = { silent = true, }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

-- Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Normal --
-- Better window navigation
keymap("n", "<Left>", "<C-w>h", opts)
keymap("n", "<Down>", "<C-w>j", opts)
keymap("n", "<Up>", "<C-w>k", opts)
keymap("n", "<Right>", "<C-w>l", opts)

-- Navigate buffers
keymap("n", "<S-Tab>", ":bn<CR>", opts)

-- Append lines but keep cursor position
keymap("n", "S", "mzJ`z", opts)

-- Better Movements
keymap("n", "H", "^", opts)
keymap("n", "L", "$", opts)
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)

-- Clear Searches
keymap("n", "<CR>", "<cmd>nohl<cr>", opts)

-- Insert --
-- Allow Ctrl+Backslash to delete entire words
keymap("i", "<C-H>", "<C-W>", opts)

-- Visual --
-- Stay in indent mode
keymap("x", "<", "<gv", opts)
keymap("x", ">", ">gv", opts)

-- Keep yanked Text after pasting over
keymap("x", "p", "P", opts)

-- Yank to system clipboard
keymap("n", "<leader>y", "\"+y", opts)
keymap("x", "<leader>y", "\"+y", opts)

-- Paste to system clipboard
keymap("n", "<leader>p", "\"+p", opts)
keymap("x", "<leader>p", "\"+p", opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv=gv", opts)
keymap("x", "K", ":move '<-2<CR>gv=gv", opts)

-- Vimscript
-- Adds relative jumps of more than 3 lines to the jumplist
keymap("n", "j", "(v:count >= 3 ? 'm`' . v:count: '') . 'j'", opts)
keymap("n", "k", "(v:count >= 3 ? 'm`' . v:count: '') . 'k'", opts)
