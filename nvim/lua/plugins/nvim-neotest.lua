return {
  'nvim-neotest/neotest',
  requires = {
    { 'Issafalcon/neotest-dotnet', lazy = false },
  },
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
    { 'Issafalcon/neotest-dotnet', lazy = false },
  },
  config = function()
    require('neotest').setup({
      adapters = {
        require('neotest-dotnet')
      },
    })
  end,
  keys = {
    { 
      '<leader>dt',
      function() require'neotest'.run.run({ strategy = 'dap'}) end,
    } 
  }
}
