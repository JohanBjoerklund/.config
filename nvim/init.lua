require('plugins')
-- Helpers -----------------------------------------------------------------{{{

local set = vim.opt
local setlocal = vim.opt_local
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

vim.cmd [[packadd packer.nvim]]

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
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<C-s>',
      node_incremental = '<C-s>',
      node_decremental = '<bs>'
    }
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ['a='] = { query = '@assignment.outer', desc = 'Select outer part of an assignment' },
        ['i='] = { query = '@assignment.inner', desc = 'Select inner part of an assignment' },
        ['l='] = { query = '@assignment.lhs', desc = 'Select left hand side of an assignment' },
        ['r='] = { query = '@assignment.rhs', desc = 'Select right hand side of an assignment' },

        ['aa'] = { query = '@parameter.outer', desc = 'Select outer part of a parameter/argument' },
        ['ia'] = { query = '@parameter.inner', desc = 'Select inner part of a parameter/argument' },

        ['ai'] = { query = '@conditional.outer', desc = 'Select outer part of a conditional' },
        ['ii'] = { query = '@conditional.inner', desc = 'Select inner part of a conditional' },

        ['al'] = { query = '@loop.outer', desc = 'Select outer part of a loop' },
        ['il'] = { query = '@loop.inner', desc = 'Select inner part of a loop' },

        ['af'] = { query = '@call.outer', desc = 'Select outer part of a function call' },
        ['if'] = { query = '@call.inner', desc = 'Select inner part of a function call' },

        ['am'] = { query = '@function.outer', desc = 'Select outer part of a function' },
        ['im'] = { query = '@function.inner', desc = 'Select inner part of a function' },
      }
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>na'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>pa'] = '@parameter.inner',
      }
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]f"] = { query = "@call.outer", desc = "Next function call start" },
        ["]m"] = { query = "@function.outer", desc = "Next method/function def start" },
        ["]i"] = { query = "@conditional.outer", desc = "Next conditional start" },
        ["]l"] = { query = "@loop.outer", desc = "Next loop start" },

        ["]s"] = { query = "@local.scope", query_group = "locals", desc = "Next scope" },
      },
      goto_next_end = {
        ["]F"] = { query = "@call.outer", desc = "Next function call end" },
        ["]M"] = { query = "@function.outer", desc = "Next method/function def end" },
        ["]I"] = { query = "@conditional.outer", desc = "Next conditional end" },
        ["]L"] = { query = "@loop.outer", desc = "Next loop end" },
      },
      goto_previous_start = {
        ["[f"] = { query = "@call.outer", desc = "Prev function call start" },
        ["[m"] = { query = "@function.outer", desc = "Prev method/function def start" },
        ["[i"] = { query = "@conditional.outer", desc = "Prev conditional start" },
        ["[l"] = { query = "@loop.outer", desc = "Prev loop start" },
      },
      goto_previous_end = {
        ["[F"] = { query = "@call.outer", desc = "Prev function call end" },
        ["[M"] = { query = "@function.outer", desc = "Prev method/function def end" },
        ["[I"] = { query = "@conditional.outer", desc = "Prev conditional end" },
        ["[L"] = { query = "@loop.outer", desc = "Prev loop end" },
      },
    },
  }
}

local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"

-- Repeat movement with ; and ,
-- ensure ; goes forward and , goes backward regardless of the last direction
vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)

-- vim way: ; goes to the direction you were moving.
-- vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
-- vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

-- Optionally, make builtin f, F, t, T also repeatable with ; and ,
vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })
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
require('mason-lspconfig').setup({
  ensure_installed = {
    'ts_ls'
  },
  automatic_installation = true
})
----------------------------------------------------------------------------}}}

-- nvim-ts-autotag ---------------------------------------------------------{{{
require('nvim-ts-autotag').setup()
----------------------------------------------------------------------------}}}

-- LSP ---------------------------------------------------------------------{{{

local lsp = require 'lspconfig'

vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { noremap=true, silent=true })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { noremap=true, silent=true })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { noremap=true, silent=true })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { noremap=true, silent=true })

vim.cmd [[autocmd! ColorScheme * highlight NormalFloat guibg=#1f2335]]
vim.cmd [[autocmd! ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]]

vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]]

lsp.ts_ls.setup({
  -- settings = {
  --   typescript = {
  --     updateImportsOnFileMove = {
  --       enabled = 'always'
  --     },
  --     preferences = {
  --       quoteStyle = 'single',

  --     }
  --   },
  --   javascript = {
  --     updateImportsOnFileMove = {
  --       enabled = 'always'
  --     },
  --     preferences = {
  --       quoteStyle = 'single',
  --     }
  --   }
  -- },
  -- on_attach = function(client, bufnr)
  --   on_attach(client, bufnr)

  --   client.server_capabilities.document_formatting = false
  -- end
})

-- TODO: map keys or use omnisharp.vim, omnisharp_extend?
lsp.omnisharp.setup({
  root_dir = require('lspconfig/util').root_pattern('*.csproj')
})

lsp.eslint.setup({})

lsp.jsonls.setup{}

lsp.svelte.setup({})

lsp.terraformls.setup({})

lsp.jdtls.setup({})

lsp.tailwindcss.setup({
  settings = {
    tailwindCSS = {
      experimental = {
        classRegex = {
          { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
          { "cx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" }
        }
      }
    }
  }
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

lsp.html.setup({})

 local prettier = require('efmls-configs.formatters.prettier')
 local languages = {
   typescript = { prettier },
   typescriptreact = { prettier },
   javascript = { prettier },
   javascriptreact = { prettier },
 }

lsp.efm.setup(vim.tbl_extend(
  'force',
  {
    filetypes = vim.tbl_keys(languages),
    settings = {
      rootMarkers = { '.git/' },
      languages = languages,
    },
    init_options = {
      documentFormatting = true,
      documentRangeFormatting = true,
    },
  },
  {}))

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    signs = true,
    virtual_text = false,
    underline = true
  })

require('sonarlint').setup({
   server = {
      cmd = {
         'sonarlint-language-server',
         -- Ensure that sonarlint-language-server uses stdio channel
         '-stdio',
         '-analyzers',
         -- paths to the analyzers you need, using those for python and java in this example
         vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarhtml.jar"),
         vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarjs.jar"),
         vim.fn.expand("$MASON/share/sonarlint-analyzers/sonariac.jar"),
         vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarlintomnisharp.jar"),
      },
      -- All settings are optional
      settings = {
         sonarlint = {
            rules = {}
         }
      }
   },
   filetypes = {
      'typescript',
      'typescriptreact',
      'javascript',
      'javascriptreact',
      'csharp',
      'html',
   }
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

nmap('<localleader>dl', '<Plug>VimspectorLaunch')
nmap('<localleader>di', '<Plug>VimspectorBalloonEval')
xmap('<localleader>di', '<Plug>VimspectorBalloonEval')
nmap('<localleader>ds', '<Plug>VimspectorStop')
xmap('<localleader>ds', '<Plug>VimspectorStop')
nmap('<localleader>dc', '<Plug>VimspectorContinue')
nmap('<localleader>dt', '<Plug>VimspectorToggleBreakpoint')
nmap('<localleader>dtc', '<Plug>VimspectorToggleConditionalBreakpoint')
nmap('<localleader>dT', '<Plug>VimspectorClearBreakpoints')
nmap('<localleader>dk', '<Plug>VimspectorRestart')
nmap('<localleader>doo', '<Plug>VimspectorStepOut')
nmap('<localleader>dsi', '<Plug>VimspectorStepInto')
nmap('<localleader>dso', '<Plug>VimspectorStepOver')
nmap('<localleader>dtl', '<Plug>VimspectorGoToCurrentLine')
nmap('<localleader>drc', '<Plug>VimspectorRunToCursor')
nmap('<localleader>dq', ':call vimspector#Reset()<CR>')

----------------------------------------------------------------------------}}}

-- Telescope ---------------------------------------------------------------{{{

require('telescope').setup({
  defaults = {
    layout_strategy = 'vertical',
    path_display = { 
      tail = true
    },
    layout_config = {
      vertical = { 
        winblend = 70,
        width = 0.5,
        prompt_position = 'top'
      },
      cursor = {
        layout_strategy = 'cursor',
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
      sorting_strategy = "ascending",
      results_title = false,
      layout_strategy = "cursor",
      layout_config = {
        width = 0.9,
        height = 0.2,
      },
      borderchars = {
        prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
        results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
        preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      },
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
