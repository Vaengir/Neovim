local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  print("Installing packer close and reopen Neovim...")
  vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the packer.lua file
vim.cmd([[
  augroup packer_user_config
  autocmd!
  autocmd BufWritePost packer.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded", })
    end,
  },
})

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  -- Have Packer manage itself
  use({ "wbthomason/packer.nvim", })

  -- Telescope
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.1',
    requires = { { 'nvim-lua/plenary.nvim', }, },
  }

  -- Colorscheme
  use({
    'rmehri01/onenord.nvim',
    as = 'onenord',
    config = function()
      vim.cmd('colorscheme onenord')
    end,
  })

  -- Treesitter
  use({ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', })
  use('nvim-treesitter/playground')
  use 'nvim-treesitter/nvim-treesitter-context'

  -- Nvim-Tree
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons',
    },
  }

  -- JK to exit Insert Mode
  use({ "jdhao/better-escape.vim", event = "InsertEnter", })

  -- LSP Setup
  use {
    'VonHeikemen/lsp-zero.nvim',
    requires = {
      -- LSP Support
      { 'neovim/nvim-lspconfig', },
      { 'williamboman/mason.nvim', },
      { 'williamboman/mason-lspconfig.nvim', },

      -- Autocompletion
      { 'hrsh7th/nvim-cmp', },
      { 'hrsh7th/cmp-buffer', },
      { 'hrsh7th/cmp-path', },
      { 'saadparwaiz1/cmp_luasnip', },
      { 'hrsh7th/cmp-nvim-lsp', },
      { 'hrsh7th/cmp-nvim-lua', },

      -- Snippets
      { 'L3MON4D3/LuaSnip', },
      { 'rafamadriz/friendly-snippets', },
    },
  }

  -- Startscreen for Vim
  use({ "goolord/alpha-nvim", })

  -- Custom Statusbar
  use({ "nvim-lualine/lualine.nvim", })

  -- Gitsigns
  use({ "lewis6991/gitsigns.nvim", })

  -- Show indented blanklines
  use({ "lukas-reineke/indent-blankline.nvim", })

  -- Undotree
  use({ "mbbill/undotree", })

  -- Zen mode
  use { "folke/zen-mode.nvim", }

  -- Harpoon
  use { "theprimeagen/harpoon", }

  -- Comments
  use({
    "numToStr/Comment.nvim",
    config = function()
      require('Comment').setup()
    end,
  })

  -- TODOs
  -- Lua
  use {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup {
      }
    end,
  }

  -- Autopairs
  use {
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end,
  }
  -- Vim Fugitive
  use({ "tpope/vim-fugitive", })

  -- LSP Status
  use({ "j-hui/fidget.nvim", })

  -- Markdown Preview
  use({
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    setup = function() vim.g.mkdp_filetypes = { "markdown", } end,
    ft = { "markdown", },
  })

  -- LaTeX Setup
  use({
    "lervag/vimtex",
    config = function()
      vim.g.vimtex_quickfix_open_on_warning = 0
      vim.g.vimtex_mappings_enabled = false
    end,
  })

  -- Better Scrolloff
  use({ 'Aasim-A/scrollEOF.nvim', })

  -- Whichkey
  use({ "folke/which-key.nvim", })

  -- VimBeGood
  use({ "ThePrimeagen/vim-be-good", })

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
