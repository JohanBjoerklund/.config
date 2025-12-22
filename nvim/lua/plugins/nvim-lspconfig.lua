return { 
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()

    vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { noremap=true, silent=true })
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { noremap=true, silent=true })
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { noremap=true, silent=true })
    vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { noremap=true, silent=true })

    vim.cmd [[autocmd! ColorScheme * highlight NormalFloat guibg=#1f2335]]
    vim.cmd [[autocmd! ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]]

    vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]]

    vim.lsp.enable('ts_ls', {})

    vim.lsp.config('roslyn', {
      settings = {
      ["csharp|inlay_hints"] = {
            csharp_enable_inlay_hints_for_implicit_object_creation = true,
            csharp_enable_inlay_hints_for_implicit_variable_types = true,

            csharp_enable_inlay_hints_for_lambda_parameter_types = true,
            csharp_enable_inlay_hints_for_types = true,
            dotnet_enable_inlay_hints_for_indexer_parameters = true,
            dotnet_enable_inlay_hints_for_literal_parameters = true,
            dotnet_enable_inlay_hints_for_object_creation_parameters = true,
            dotnet_enable_inlay_hints_for_other_parameters = true,
            dotnet_enable_inlay_hints_for_parameters = true,
            dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
            dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
            dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
          },
          ["csharp|code_lens"] = {
            dotnet_enable_references_code_lens = true,
          },
        }
    })
    vim.lsp.enable('roslyn')

    vim.lsp.enable('dockerls', {})

    vim.lsp.enable('eslint', { 
      experimental = { useFlatConfig = true},
      root_dir = require('lspconfig/util').root_pattern('package.json')
    })

    vim.lsp.enable('jsonls', {})

    vim.lsp.enable('svelte', {})

    vim.lsp.enable('terraformls', {})

    vim.lsp.enable('jdtls', {})

    vim.lsp.enable('tailwindcss', {
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

    vim.lsp.enable('html', {})

    local prettier = require('efmls-configs.formatters.prettier')
    local languages = {
      typescript = { prettier },
      typescriptreact = { prettier },
      javascript = { prettier },
      javascriptreact = { prettier },
    }

    vim.lsp.enable('efm', vim.tbl_extend(
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
          local opts = { noremap = true, silent = true, buffer=ev.buf }
          vim.keymap.set('n', '<leader>gD', vim.lsp.buf.declaration, opts)
          vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', '<leader>td', vim.lsp.buf.type_definition, opts)
          vim.keymap.set('n', '<leader>K', vim.lsp.buf.hover, opts)

          vim.keymap.set('n', '<leader>gi', vim.lsp.buf.implementation, opts)
          -- TODO: what shortcut?
          -- vim.keymap.set('n', '<leader>', '<cmd>lua require("telescope.builtin").lsp_diagnostics()<CR>', opts)
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
