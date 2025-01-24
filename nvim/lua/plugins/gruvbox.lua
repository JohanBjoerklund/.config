return {
  'ellisonleao/gruvbox.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    vim.g.gruvbox_contrast_dark = 'hard'
    vim.g.gruvbox_sign_column = 'bg0'
    vim.cmd([[colorscheme gruvbox]])
  end,
}
