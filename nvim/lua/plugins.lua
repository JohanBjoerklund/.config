local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function()

  use 'wbthomason/packer.nvim'
  use 'jiangmiao/auto-pairs'
  use 'tpope/vim-commentary'
  use 'tpope/vim-surround'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-vinegar'
  use 'junegunn/goyo.vim'
  use 'junegunn/limelight.vim'
  use 'ellisonleao/gruvbox.nvim' 
  use 'nvim-lualine/lualine.nvim'
  use 'hashivim/vim-terraform'
  use 'github/copilot.vim'

  use {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'neovim/nvim-lspconfig'
  }

  use {
    'creativenull/efmls-configs-nvim',
    tag = 'v1.*', -- tag is optional, but recommended
    requires = { 'neovim/nvim-lspconfig' },
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
  }

  use {
    "nvim-treesitter/nvim-treesitter-textobjects",
    after = "nvim-treesitter",
    requires = "nvim-treesitter/nvim-treesitter",
  }

  use {
    "kylechui/nvim-surround",
    tag = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  }

  use {'ms-jpq/coq.thirdparty', requires = {'ms-jpq/coq_nvim' } }

  use {
    'lewis6991/gitsigns.nvim',
    config = function() 
      require('gitsigns').setup()
    end
  }

  use { 
    'puremourning/vimspector',
    run = ':VimspectorInstall vscode-node-debug2 netcoredbg'
  }

  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  use({
    'iamcco/markdown-preview.nvim',
    run = function() vim.fn['mkdp#util#install']() end,
  })

  use 'leafOfTree/vim-svelte-plugin'
  use 'JohanBjoerklund/vim-colemak-dh'

end)