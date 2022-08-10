require('plugins')
-- Helpers -----------------------------------------------------------------{{{

local set = vim.opt
local setlocal = vim.opt_local
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

vim.cmd [[packadd packer.nvim]]
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost init.lua source <afile> | PackerCompile
  augroup end
]])


function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

function nmap(shortcut, command)
  map('n', shortcut, command)
end

function imap(shortcut, command)
  map('i', shortcut, command)
end

function xmap(shortcut, command)
  map('x', shortcut, command)
end

----------------------------------------------------------------------------}}}

-- Mappings ----------------------------------------------------------------{{{

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

nmap('<C-P>', ':lua require("telescope.builtin").find_files()<CR>')
nmap('<BS>', '<C-^>')
nmap('<ESC>', ':noh<CR>')
nmap('<leader>ev', ':vsplit $MYVIMRC<CR>')

----------------------------------------------------------------------------}}}

-- GUI ---------------------------------------------------------------------{{{

set.termguicolors = true
set.relativenumber = true
set.number = true
set.showmode = false
set.colorcolumn = '80'
set.signcolumn = 'yes'
set.showbreak = '↳ ' 
vim.wo.breakindent = true
vim.wo.cursorline = true

vim.g.gruvbox_contrast_dark = 'hard'
vim.g.gruvbox_sign_column = 'bg0'
vim.cmd [[colorscheme gruvbox]]

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

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap = true, silent = true }
  buf_set_keymap('n', '<leader>gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', '<leader>tt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader><space>', '<Cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>fu', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', 'gc', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
end


local eslint = {
  lintCommand = "eslint_d -f unix --stdin --stdin-filename ${INPUT}",
  lintStdin = true,
  lintFormats = {"%f:%l:%c: %m"},
  lintIgnoreExitCode = true,
  formatCommand = "eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}",
  formatStdin = true
}

require("nvim-lsp-installer").setup({
  automatic_installation = true
})

require('lspconfig').tsserver.setup({
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)

    client.resolved_capabilities.document_formatting = false
  end
})

-- TODO: map keys or use omnisharp.vim
require('lspconfig').omnisharp.setup({
  root_dir = require('lspconfig/util').root_pattern('*.csproj'),
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
  end
})

require('lspconfig').efm.setup({
  root_dir = require('lspconfig/util').root_pattern('package.json', '.eslintrc', '.git'),
  settings = {
    languages = {
      javascript = { eslint },
      javascriptreact = { eslint },
      ['javascript.jsx'] = { eslint },
      typescript = { eslint },
      typescriptreact = { eslint },
      ['typescript.tsx'] = { eslint }
    }
  },
  filetypes = {
      'javascript',
      'javascriptreact',
      'javascript.jsx',
      'typescript',
      'typescriptreact',
      'typescript.tsx'
  },
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)

    client.resolved_capabilities.document_formatting = true
    client.resolved_capabilities.goto_defintion = false
  end
})

require('lspconfig').svelte.setup({
  on_attach = on_attach,
})

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    signs = true,
    virtual_text = false,
    underline = true
  })

vim.opt.updatetime = 2000
----------------------------------------------------------------------------}}}

-- Vimspector --------------------------------------------------------------{{{

nmap('<leader>dd', '<Plug>VimspectorLaunch')
nmap('<leader>de', '<Plug>VimspectorReset')
nmap('<leader>dc', '<Plug>VimspectorContinue')
nmap('<leader>dt', '<Plug>VimspectorToggleBreakpoint')
nmap('<leader>dtc', '<Plug>VimspectorToggleConditionalBreakpoint')
nmap('<leader>dT', '<Plug>VimspectorClearBreakpoints')
nmap('<leader>dk', '<Plug>VimspectorResart')
nmap('<leader>doo', '<Plug>VimspectorStepOut')
nmap('<leader>dsi', '<Plug>VimspectorStepInto')
nmap('<leader>dso', '<Plug>VimspectorStepOver')
nmap('<leader>di', '<Plug>VimspectorBalloonEval')
xmap('<leader>di', '<Plug>VimspectorBalloonEval')

----------------------------------------------------------------------------}}}

-- Telescope ---------------------------------------------------------------{{{

require('telescope').setup({
  pickers = {
    find_files = {
      theme = 'dropdown'
    },
    lsp_references = {
      theme = 'dropdown'
    },
    buffers = {
      theme = 'dropdown'
    },
    grep_string = {
      theme = 'get_cursor'
    }
  }
})

nmap('<leader>f', ':lua require("telescope.builtin").find_files()<CR>')
nmap('<leader>fg', ':lua require("telescope.builtin").live_grep()<CR>')
-- nmap('<leader>fg', ':lua require("telescope.builtin").grep_string()<CR>')
nmap('<leader>fb', ':lua require("telescope.builtin").buffers()<CR>')
nmap('<leader>fh', ':lua require("telescope.builtin").help_tags()<CR>')

----------------------------------------------------------------------------}}}

-- Lualine -----------------------------------------------------------------{{{

require('lualine').setup({
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
  }
})

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
autocmd('User', {
  pattern = 'GoyoEnter',
  group = 'md',
  command = ':Limelight'
})
autocmd('User', {
  pattern = 'GoyoLeave',
  group = 'md',
  command = ':Limelight!'
})

----------------------------------------------------------------------------}}}

-- Cursor ------------------------------------------------------------------{{{

-- vim.cmd [[set gcr=a:block]]
-- vim.cmd [[set gcr+=o:hor50-Cursor]]
-- vim.cmd [[set gcr+=n:Cursor]]
-- vim.cmd [[set gcr+=i-ci-sm:InsertCursor]]
-- vim.cmd [[set gcr+=r-cr:ReplaceCursor-hor20]]
-- vim.cmd [[set gcr+=c:CommandCursor]]
-- vim.cmd [[set gcr+=v-ve:VisualCursor]]
-- vim.cmd [[set gcr+=a:blinknon0]]

-- vim.cmd [[hi TermCursor ctermfg=03 ctermbg=07 guibg=#458588 guifg=#ebdbb2]]
-- vim.cmd [[hi Cursor ctermfg=03 ctermbg=07 guibg=#458588 guifg=#ebdbb2]]
-- vim.cmd [[hi iCursor ctermfg=15 ctermbg=04 guibg=#458588 guifg=#ebdbb2]]
-- vim.cmd [[hi InsertCursor ctermfg=15 ctermbg=04 guibg=#458588 guifg=#ebdbb2]]
-- vim.cmd [[hi vCursor ctermfg=15 ctermbg=16]]
-- vim.cmd [[hi VisualCursor ctermfg=15 ctermbg=16]]
-- vim.cmd [[hi CursorIM ctermfg=15 ctermbg=04]]
-- vim.cmd [[hi lCursor ctermfg=15 ctermbg=04]]

----------------------------------------------------------------------------}}}
