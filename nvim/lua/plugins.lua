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

  use {
    'williamboman/nvim-lsp-installer',
    'neovim/nvim-lspconfig'
  }

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
end)
