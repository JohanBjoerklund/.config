return { 
  'nvim-lualine/lualine.nvim',
  opts = {
    options = {
      theme = 'gruvbox'
    },
    sections = {
      lualine_a = {},
      lualine_b = { 
        'branch',
        'diff',
        { 
          'diagnostics',
          enable_icons = false,
          symbols = { 
            error = '✘',
            warn = '✘',
            info = '‼',
            hint = '‼',
          }
        } 
      },
      lualine_c = { 'filename' },
      lualine_x = {},
      lualine_y = {},
      lualine_z = { 'winnr' }
    },
    inactive_sections = {
      lualine_a = { 'filename' },
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = { 'winnr' }
    },
  },
}
