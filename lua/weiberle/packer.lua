local function bootstrap_pckr()
  local pckr_path = vim.fn.stdpath("data") .. "/pckr/pckr.nvim"

  if not vim.loop.fs_stat(pckr_path) then
    vim.fn.system({
      'git',
      'clone',
      "--filter=blob:none",
      'https://github.com/lewis6991/pckr.nvim',
      pckr_path,
    })
  end

  vim.opt.rtp:prepend(pckr_path)
end

bootstrap_pckr()

-- Install your plugins here
require("pckr").add {

  -- Telescope
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.4',
    requires = { { 'nvim-lua/plenary.nvim', }, },
  },

  -- Colorscheme
  {
    'rmehri01/onenord.nvim',
    as = 'onenord',
    config = function()
      vim.cmd('colorscheme onenord')
    end,
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    after = "nvim-treesitter",
    requires = "nvim-treesitter/nvim-treesitter",
    run = ':TSUpdate',
  },
  { 'nvim-treesitter/nvim-treesitter-context', },

  -- Oil.nvim
  {
    'stevearc/oil.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', },
  },

  -- JK to exit Insert Mode
  {
    "max397574/better-escape.nvim",
    config = function()
      require("better_escape").setup()
    end,
  },

  -- LSP Setup
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
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
    },
  },

  -- Startscreen for Vim
  { "goolord/alpha-nvim", },

  -- Custom Statusbar
  { "nvim-lualine/lualine.nvim", },

  -- Gitsigns
  { "lewis6991/gitsigns.nvim", },

  -- Show indented blanklines
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("ibl").setup {
        scope = { enabled = false, },
      }
    end,
  },

  -- Undotree
  {
    "mbbill/undotree",
    config = function()
      vim.g.undotree_WindowLayout = 2
      vim.g.undotree_SetFocusWhenToggle = 1
    end,
  },

  -- Zen mode
  { "folke/zen-mode.nvim", },

  -- Harpoon
  { "theprimeagen/harpoon", },

  -- Comments
  {
    "numToStr/Comment.nvim",
    config = function()
      require('Comment').setup()
    end,
  },

  -- TODOs
  {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup {
      }
    end,
  },

  -- Autopairs
  {
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end,
  },

  -- Vim Fugitive
  { "tpope/vim-fugitive", },

  -- LSP Status
  { "j-hui/fidget.nvim",  tag = 'legacy', },

  -- Markdown Preview
  {
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    setup = function() vim.g.mkdp_filetypes = { "markdown", } end,
    ft = { "markdown", },
  },

  -- LaTeX Setup
  {
    "lervag/vimtex",
    config = function()
      vim.g.vimtex_quickfix_open_on_warning = 0
      vim.g.vimtex_mappings_enabled = false
      vim.g.vimtex_format_enabled = false
    end,
  },

  { "epwalsh/obsidian.nvim", },

  -- Better Scrolloff
  { 'Aasim-A/scrollEOF.nvim', },

  -- Whichkey
  { "folke/which-key.nvim", },

  -- Hardtime
  { "m4xshen/hardtime.nvim", },

  -- VimBeGood
  { "ThePrimeagen/vim-be-good", },

}
