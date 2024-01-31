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

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

nmap('<BS>', '<C-^>')
nmap('<ESC>', ':noh<CR>')
nmap('<leader>ev', ':vsplit $MYVIMRC<CR>')

nmap('<leader>zi', ':Goyo<CR>') -- Buffer Zoom In
nmap('<leader>zo', ':Goyo!<CR>') -- Buffer Zoom Out
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

vim.g.gruvbox_contrast_dark = 'hard'
vim.g.gruvbox_sign_column = 'bg0'
vim.cmd [[colorscheme gruvbox]]

----------------------------------------------------------------------------}}}
-- TreeSitter --------------------------------------------------------------{{{
require'nvim-treesitter.configs'.setup {
  auto_install = true,
  highlight = {
    enable = true
  },
  -- textobjects = {
  --   select = {
  --     enable = true,
  --     lookahead = true,
  --     keymaps = {
        
  --     }
  --   }
  -- }
}
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

-- Mason -------------------------------------------------------------------{{{
require('mason').setup()
require('mason-lspconfig').setup()
----------------------------------------------------------------------------}}}

-- Coq ---------------------------------------------------------------------{{{
-- vim.g.coq_settings = {
--  auto_start = true;
-- }

-- require('coq_3p') {
--   { src = 'copilot', short_name = 'COP', accept_key = '<c-f>' }
-- }
-- }}}
-- LSP ---------------------------------------------------------------------{{{

local lsp = require 'lspconfig'
-- local coq = require 'coq'

vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { noremap=true, silent=true })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { noremap=true, silent=true })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { noremap=true, silent=true })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { noremap=true, silent=true })


-- local on_attach = function(client, bufnr)
--   vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

--   local opts = { noremap = true, silent = true, buffer=bufnr }
--   vim.keymap.set('n', '<leader>gD', vim.lsp.buf.declaration, opts)
--   vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, opts)
--   vim.keymap.set('n', '<leader>td', vim.lsp.buf.type_definition, opts)
--   vim.keymap.set('n', '<leader>K', vim.lsp.buf.hover, opts)
--   vim.keymap.set('n', '<leader>gi', vim.lsp.buf.implementation, opts)
--   vim.keymap.set('n', '<leader><C-K>', vim.lsp.buf.signature_help, opts)
--   vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
--   vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
--   vim.keymap.set('n', '<leader>wl', function()
--     print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
--   end, opts)
--   vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
--   vim.keymap.set('n', '<leader><space>', vim.lsp.buf.code_action, opts)
--   vim.keymap.set('n', '<leader>fu', '<cmd>lua require("telescope.builtin").lsp_references()<CR>', opts)
-- end
vim.cmd [[autocmd! ColorScheme * highlight NormalFloat guibg=#1f2335]]
vim.cmd [[autocmd! ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]]

vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]]

-- lsp.tsserver.setup(coq.lsp_ensure_capabilities({
lsp.tsserver.setup({
  settings = {
    typescript = {
      updateImportsOnFileMove = {
        enabled = 'always'
      },
      preferences = {
        importModuleSpecifier = 'relative',
        quoteStyle = 'single',

      }
    },
    javascript = {
      updateImportsOnFileMove = {
        enabled = 'always'
      },
      preferences = {
        importModuleSpecifier = 'relative',
        quoteStyle = 'single',
      }
    }
  },
  -- on_attach = function(client, bufnr)
  --   on_attach(client, bufnr)

  --   client.server_capabilities.document_formatting = false
  -- end
})

-- TODO: map keys or use omnisharp.vim, omnisharp_extend?
-- lsp.omnisharp.setup(coq.lsp_ensure_capabilities({
lsp.omnisharp.setup({
  root_dir = require('lspconfig/util').root_pattern('*.csproj'),
  -- on_attach = function(client, bufnr)
  --   on_attach(client, bufnr)
  -- end
})

lsp.eslint.setup({})

lsp.jsonls.setup{}

lsp.svelte.setup({
  -- on_attach = on_attach,
})

lsp.terraformls.setup({
  -- on_attach = on_attach,
})

-- lsp.jdtls.setup(coq.lsp_ensure_capabilities({ 
lsp.jdtls.setup({ 
  -- on_attach = on_attach 
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
lsp.html.setup({})

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    signs = true,
    virtual_text = false,
    underline = true
  })

vim.opt.updatetime = 2000

autocmd('LspAttach' , {
  group = augroup('UserLspConfig', {}),
  callback = function(ev) 
    vim.api.nvim_buf_set_option(ev.buf, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local opts = { noremap = true, silent = true, buffer=ev.buf }
    vim.keymap.set('n', '<leader>gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', '<leader>td', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<leader>K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<leader>gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<leader><C-K>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader><space>', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<leader>fu', '<cmd>lua require("telescope.builtin").lsp_references()<CR>', opts)
  end
})
----------------------------------------------------------------------------}}}

-- Vimspector --------------------------------------------------------------{{{

nmap('<leader>dd', '<Plug>VimspectorLaunch')
nmap('<leader>di', '<Plug>VimspectorBalloonEval')
xmap('<leader>di', '<Plug>VimspectorBalloonEval')
nmap('<leader>ds', '<Plug>VimspectorStop')
xmap('<leader>ds', '<Plug>VimspectorStop')
nmap('<leader>dc', '<Plug>VimspectorContinue')
nmap('<leader>dt', '<Plug>VimspectorToggleBreakpoint')
nmap('<leader>dtc', '<Plug>VimspectorToggleConditionalBreakpoint')
nmap('<leader>dT', '<Plug>VimspectorClearBreakpoints')
nmap('<leader>dk', '<Plug>VimspectorRestart')
nmap('<leader>doo', '<Plug>VimspectorStepOut')
nmap('<leader>dsi', '<Plug>VimspectorStepInto')
nmap('<leader>dso', '<Plug>VimspectorStepOver')
nmap('<leader>di', '<Plug>VimspectorBalloonEval')
nmap('<leader>dtl', '<Plug>VimspectorGoToCurrentLine')

----------------------------------------------------------------------------}}}

-- Telescope ---------------------------------------------------------------{{{

require('telescope').setup({
  defaults = {
    layout_strategy = 'vertical',
    path_display = { 
      tail = true
      -- shorten = { len = 1, exclude = { 1, -1 } } 
    },
    layout_config = {
      vertical = { 
        winblend = 70,
        width = 0.5,
        prompt_position = 'top'
      },
      cursor = {
        width = 0.5
      },
    },
    mappings = {
      i = {
        ["<esc>"] = require("telescope.actions").close
      },
    },
  },
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
    marks = {
      theme = 'dropdown'
    },
    live_grep = {
      theme = 'dropdown'
    },
    grep_string = {
      theme = 'cursor'
    }
  }
})

nmap('<leader>ff', ':lua require("telescope.builtin").find_files()<CR>')
nmap('<leader>fg', ':lua require("telescope.builtin").live_grep()<CR>')
nmap('<leader>fs', ':lua require("telescope.builtin").grep_string()<CR>')
nmap('<leader>fb', ':lua require("telescope.builtin").buffers()<CR>')
nmap('<leader>fh', ':lua require("telescope.builtin").help_tags()<CR>')
nmap('<leader>fm', ':lua require("telescope.builtin").marks()<CR>')

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

-- Neosnippets -------------------------------------------------------------{{{

----------------------------------------------------------------------------}}}