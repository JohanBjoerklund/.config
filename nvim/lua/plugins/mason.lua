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
    {
      'mason-org/mason.nvim', 
      opts = {
        registries = {
          'github:Crashdummyy/mason-registry',
          'github:mason-org/mason-registry',
        },
        ensure_installed = {
          'roslyn',
        },
      },
    },
    'neovim/nvim-lspconfig',
  },
}
