return { 
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local lsp = require('lspconfig')
    local mason = require('mason')

    vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { noremap=true, silent=true })
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { noremap=true, silent=true })
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { noremap=true, silent=true })
    vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { noremap=true, silent=true })

    vim.cmd [[autocmd! ColorScheme * highlight NormalFloat guibg=#1f2335]]
    vim.cmd [[autocmd! ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]]

    vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]]

    mason.setup({})

    lsp.ts_ls.setup({})

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

      local autocmd = vim.api.nvim_create_autocmd
      local augroup = vim.api.nvim_create_augroup

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

    end,
}
