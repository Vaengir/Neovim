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
keymap("n", "<S-j>", ":bn<CR>", opts)
keymap("n", "<S-k>", ":bp<CR>", opts)

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
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Keep yanked Text after pasting over
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)

-- Unmap q to test if that is what causes weird jk and esc functionality
keymap("", "q", "<Nop>", opts)
