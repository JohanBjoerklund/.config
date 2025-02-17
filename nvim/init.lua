require("config.lazy")

-- Helpers -----------------------------------------------------------------{{{

local set = vim.opt
local setlocal = vim.opt_local
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

function nmap(shortcut, command)
  map('n', shortcut, command)
end

function vmap(shortcut, command)
  map('v', shortcut, command)
end

function imap(shortcut, command)
  map('i', shortcut, command)
end

function xmap(shortcut, command)
  map('x', shortcut, command)
end

function omap(shortcut, command)
  map('o', shortcut, command)
end
----------------------------------------------------------------------------}}}

-- Mappings ----------------------------------------------------------------{{{

nmap('<BS>', '<C-^>')
nmap('<ESC>', ':noh<CR>')
nmap('<leader>ev', ':vsplit $MYVIMRC<CR>')

nmap('<leader>zi', ':Goyo<CR>') -- Buffer Zoom In
nmap('<leader>zo', ':Goyo!<CR>') -- Buffer Zoom Out

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

-- GUI ---------------------------------------------------------------------{{{
set.completeopt = 'longest,menuone'
set.termguicolors = true
set.relativenumber = true
set.number = true
set.showmode = false
set.colorcolumn = '80'
set.signcolumn = 'yes'
set.showbreak = '↳ ' 
vim.wo.breakindent = true
vim.wo.cursorline = true

----------------------------------------------------------------------------}}}

local actions = require('CopilotChat.actions')
local integrations = require('CopilotChat.integrations.telescope')

vim.keymap.set({ 'n', 'v' }, '<leader>pp', function()
  integrations.pick(actions.prompt_actions())
end)


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
set.foldenable = false
set.foldnestmax = 1
set.foldmethod = 'indent'

----------------------------------------------------------------------------}}}

-- Misc --------------------------------------------------------------------}}}

set.autoread = true
set.shiftwidth = 2
set.softtabstop = 2
set.copyindent = true
set.swapfile = false
set.expandtab = true

if vim.fn.executable('rg') then
  set.grepprg='rg --no-heading --smart-case --color=never'
end

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

-- Telescope ---------------------------------------------------------------{{{


vim.api.nvim_set_keymap('n', 'Q', ':Telescope cmdline<CR>', { noremap = true, desc = 'Cmdline' })
nmap('<leader>ff', ':lua require("telescope.builtin").find_files()<CR>')
nmap('<leader>fg', ':lua require("telescope.builtin").live_grep()<CR>')
nmap('<leader>fs', ':lua require("telescope.builtin").grep_string()<CR>')
nmap('<leader>fb', ':lua require("telescope.builtin").buffers()<CR>')
nmap('<leader>fh', ':lua require("telescope.builtin").help_tags()<CR>')
nmap('<leader>fm', ':lua require("telescope.builtin").marks()<CR>')

----------------------------------------------------------------------------}}}


-- Navigation --------------------------------------------------------------{{{

local winnr = 1
while(winnr <= 9)
do
  nmap('<leader>'..winnr, ':'..winnr..'wincmd w<CR>')
  winnr = winnr + 1
end

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

----------------------------------------------------------------------------}}}
