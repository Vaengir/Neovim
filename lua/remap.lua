local keymap = vim.keymap.set
local opts = { noremap = true, silent = true, }

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
keymap("n", "<A-j>", "<cmd>bn<cr>", opts)
keymap("n", "<A-k>", "<cmd>bp<cr>", opts)

-- Quickfix list
keymap("n", "<C-j>", function()
  local valid_idx, qfwinnr = unpack(require("functions").qf_infos())
  if (vim.fn.getqflist({ idx = 0, }).idx == valid_idx[#valid_idx] and #valid_idx ~= 1) or #valid_idx == 0 then
    print("Already on last item of Quickfix list")
    return nil
  else
    print(#valid_idx)
    if #valid_idx == 1 then
      vim.cmd(".cc")
      vim.cmd("normal! zz")
      return nil
    else
      vim.cmd("cn")
      vim.cmd("normal! zz")
      vim.api.nvim_win_call(qfwinnr, function()
        vim.cmd("normal! zt")
      end)
    end
  end
end, opts)
keymap("n", "<C-k>", function()
  local valid_idx, qfwinnr = unpack(require("functions").qf_infos())
  if vim.fn.getqflist({ idx = 0, }).idx == valid_idx[1] or #valid_idx == 0 then
    print("Already on first item of Quickfix list")
    return nil
  else
    vim.cmd("cp")
    vim.cmd("normal! zz")
    vim.api.nvim_win_call(qfwinnr, function()
      vim.cmd("normal! zt")
    end)
  end
end, opts)

-- Append lines but keep cursor position
keymap("n", "S", "mzJ`z", opts)

-- Better Movements
keymap({ "n", "o", "x", }, "<S-h>", "^", opts)
keymap({ "n", "o", "x", }, "<S-l>", "g_", opts)
keymap({ "n", "o", "x", }, "<S-m>", "%", opts)
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)

-- Whole file keymaps
keymap("n", "yig", ":%y<CR>", opts)
keymap("n", "vig", "ggVG", opts)
keymap("n", "cig", ":%d<CR>i", opts)

-- Allow Ctrl+Backslash to delete entire words
keymap("i", "<C-H>", "<C-W>", opts)

-- Stay in indent mode
keymap("x", "<", "<gv", opts)
keymap("x", ">", ">gv", opts)

-- Keep yanked Text after pasting over
keymap("x", "p", "P", opts)

-- Delete single character without copying into register
keymap("n", "x", "\"_x", opts)

-- Yank to system clipboard
keymap({ "n", "x", }, "<leader>y", "\"+y", opts)

-- Paste to system clipboard
keymap({ "n", "x", }, "<leader>p", "\"+p", opts)

-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv=gv", opts)
keymap("x", "K", ":move '<-2<CR>gv=gv", opts)

-- Adds relative jumps of more than 3 lines to the jumplist
keymap("n", "j", "(v:count >= 3 ? 'm`' . v:count: '') . 'j'", opts)
keymap("n", "k", "(v:count >= 3 ? 'm`' . v:count: '') . 'k'", opts)

-- Easier macros
keymap("n", "Q", "@qj", opts)
keymap("x", "Q", ":norm @q<cr>", opts)
