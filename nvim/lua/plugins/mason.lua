return { 
  'mason-org/mason-lspconfig.nvim',
  opts = {
    automatic_installation = true,
    ensure_installed = {
      'eslint',
      'html',
      'ts_ls',
      'tailwindcss',
    },
    automatic_enable = false,
  },
  dependencies = {
    {'mason-org/mason.nvim', opts={}},
    'neovim/nvim-lspconfig',
  },
}
