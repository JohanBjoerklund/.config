require("config.settings")
require("config.lazy")
require("config.keymaps")

-- Helpers -----------------------------------------------------------------{{{

local setlocal = vim.opt_local
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

----------------------------------------------------------------------------}}}

-- Mappings ----------------------------------------------------------------{{{

-- Fix for colemak.vim keymap collision. tpope/vim-fugitive's maps y<C-G>
-- and colemak.vim maps 'y' to 'w' (word). In combination this stalls 'y'
-- because Vim must wait to see if the user wants to press <C-G> as well.
augroup('RemoveFugitiveMappingForColemak', { clear = true })
autocmd('BufEnter', { 
  pattern = '*',
  callback = function()
    vim.api.nvim_buf_set_keymap(0, 'n', 'y<C-G>', '<silent> y<C-G>', { noremap = true })
  end
})
----------------------------------------------------------------------------}}}

-- Folding -----------------------------------------------------------------}}}

augroup('vim', { clear = true })
autocmd('FileType', {
  group = 'vim',
  pattern = { '*.vim', 'init.lua' },
  callback = function(opts)
    setlocal.modelines = 1
    setlocal.foldmethod = 'marker'
    vim.api.nvim_buf_set_keymap(opts.buf, 'n', '<leader>s', ':w | source %')
  end
})

----------------------------------------------------------------------------}}}

-- HTML --------------------------------------------------------------------{{{

augroup('html', { clear = true })
autocmd('FileType', {
  group = 'html',
  pattern =  'html',
  callback = function(opts)
    setlocal.tabstop = 4
    setlocal.shiftwidth = 4
  end
})

----------------------------------------------------------------------------}}}

-- CS ----------------------------------------------------------------------{{{

augroup('csharp', { clear = true })
autocmd('FileType', {
  group = 'csharp',
  pattern = 'cs',
  callback = function(opts)
    setlocal.tabstop = 4
    setlocal.softtabstop = 4
    setlocal.shiftwidth = 4
  end
})

----------------------------------------------------------------------------}}}

-- MD ----------------------------------------------------------------------{{{

augroup('md', { clear = true })
autocmd('BufEnter', {
  group = 'md',
  pattern = { '*.md', '*.markdown' },
  command = ':Goyo'
})
autocmd('BufLeave', {
  group = 'md',
  pattern = { '*.md', '*.markdown' },
  command = ':Goyo!'
})
autocmd('BufEnter', {
  group = 'md',
  pattern = { '*.md', '*.markdown' },
  command = ':Limelight'
})
autocmd('BufLeave', {
  group = 'md',
  pattern = { '*.md', '*.markdown' },
  command = ':Limelight!'
})
autocmd('User', {
  pattern = 'GoyoEnter',
  group = 'md',
  callback = require("lualine").hide
})

vim.api.nvim_set_keymap('n', '<leader>zi', ':Goyo<CR>', { noremap = true, silent = true }) -- Buffer Zoom In
vim.api.nvim_set_keymap('n', '<leader>zo', ':Goyo!<CR>', { noremap = true, silent = true }) -- Buffer Zoom Out

----------------------------------------------------------------------------}}}
