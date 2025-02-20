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

-- LSP ---------------------------------------------------------------------{{{

-- local lsp = require 'lspconfig'

-- vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { noremap=true, silent=true })
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { noremap=true, silent=true })
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { noremap=true, silent=true })
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { noremap=true, silent=true })

-- vim.cmd [[autocmd! ColorScheme * highlight NormalFloat guibg=#1f2335]]
-- vim.cmd [[autocmd! ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]]

-- vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]]


-- require('sonarlint').setup({
--    server = {
--       cmd = {
--          'sonarlint-language-server',
--          -- Ensure that sonarlint-language-server uses stdio channel
--          '-stdio',
--          '-analyzers',
--          -- paths to the analyzers you need, using those for python and java in this example
--          vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarhtml.jar"),
--          vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarjs.jar"),
--          vim.fn.expand("$MASON/share/sonarlint-analyzers/sonariac.jar"),
--          vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarlintomnisharp.jar"),
--       },
--       -- All settings are optional
--       settings = {
--          sonarlint = {
--             rules = {}
--          }
--       }
--    },
--    filetypes = {
--       'typescript',
--       'typescriptreact',
--       'javascript',
--       'javascriptreact',
--       'csharp',
--       'html',
--    }
-- })

-- vim.opt.updatetime = 2000

-- autocmd('LspAttach' , {
--   group = augroup('UserLspConfig', {}),
--   callback = function(ev) 
--     vim.api.nvim_buf_set_option(ev.buf, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

--     local opts = { noremap = true, silent = true, buffer=ev.buf }
--     vim.keymap.set('n', '<leader>gD', vim.lsp.buf.declaration, opts)
--     vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, opts)
--     vim.keymap.set('n', '<leader>td', vim.lsp.buf.type_definition, opts)
--     vim.keymap.set('n', '<leader>K', vim.lsp.buf.hover, opts)
--     vim.keymap.set('n', '<leader>gi', vim.lsp.buf.implementation, opts)
--     vim.keymap.set('n', '<leader><C-K>', vim.lsp.buf.signature_help, opts)
--     vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
--     vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
--     vim.keymap.set('n', '<leader>wl', function()
--       print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
--     end, opts)
--     vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
--     vim.keymap.set('n', '<leader><space>', vim.lsp.buf.code_action, opts)
--     vim.keymap.set('n', '<leader>fu', '<cmd>lua require("telescope.builtin").lsp_references()<CR>', opts)
--   end
-- })
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
