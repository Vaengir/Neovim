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

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins.lua source <afile> | PackerSync
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
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
	-- My plugins here

	use({ "wbthomason/packer.nvim" }) -- packer manage itself
	use({ "windwp/nvim-autopairs" }) -- Autopairs, integrates with both cmp and treesitter
	use({ "numToStr/Comment.nvim",
        config = function()
          require('Comment').setup()
        end
      }) -- Comment out lines
	use({ "jdhao/better-escape.vim", event = "InsertEnter" }) -- Allows jk to exit insert mode
	use({ "folke/which-key.nvim" }) -- Allows <leader> keymap menu
	use({ "nvim-tree/nvim-tree.lua", requires = { "nvim-tree/nvim-web-devicons" } }) -- Explorer
	use({ "akinsho/toggleterm.nvim" }) -- Integrated terminal
	use({ "nvim-lua/plenary.nvim" }) -- Dependencies of other plugins
	use({ "kyazdani42/nvim-web-devicons" })
	use({ "goolord/alpha-nvim" })
	use({ "nvim-lualine/lualine.nvim" })
	use({ "lewis6991/gitsigns.nvim" })
  use({ "lukas-reineke/indent-blankline.nvim" })
  use({ "mbbill/undotree" })
  use({ "junegunn/goyo.vim" })
	--  use({ "tpope/vim-fugitive" })

	-- Completion plugins
	use({ "hrsh7th/nvim-cmp" })
	use({ "hrsh7th/cmp-buffer" }) -- buffer completions
	use({ "hrsh7th/cmp-path" }) -- path completions
	use({ "saadparwaiz1/cmp_luasnip" }) -- snippet completions
	use({ "hrsh7th/cmp-nvim-lsp" })
	use({ "hrsh7th/cmp-nvim-lua" })

	-- snippets
	use({ "L3MON4D3/LuaSnip" }) --snippet engine
	use({ "rafamadriz/friendly-snippets" }) -- a bunch of snippets to use

	-- Colorschemes
	use({ "rmehri01/onenord.nvim" })
	use({ "Shatur/neovim-ayu" })

	-- Telescope
	use({ "nvim-telescope/telescope.nvim" })

	-- Treesitter
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
  use({ 'nvim-treesitter/nvim-treesitter-context' })

	-- LSP
	use({ "neovim/nvim-lspconfig" })
	use({ "williamboman/mason.nvim" })
	use({ "williamboman/mason-lspconfig.nvim" })
	use({ "mhartington/formatter.nvim" })
	use({ "mfussenegger/nvim-lint" })
	use({ "mfussenegger/nvim-dap" })
  use({ "mfussenegger/nvim-jdtls" })

  -- VimBeGood
  use({ "ThePrimeagen/vim-be-good"})

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
