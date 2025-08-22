return {
  'nvim-telescope/telescope.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {
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
        theme = 'dropdown',
        path_display = { 'filename_first' }
      },
      lsp_references = {
        theme = 'dropdown',
        path_display = { 'filename_first' }
      },
      buffers = {
        theme = 'dropdown'
      },
      marks = {
        theme = 'dropdown'
      },
      live_grep = {
        theme = 'dropdown',
        path_display = { 'filename_first' }
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
    },
    extensions = {
      cmdline = {
        picker = {
          layout_config = {
            width = 120,
            height = 25,
          },
        },
        mappings = {
          complete = '<Tab>',
          run_selection = '<C-CR>',
          run_input = '<CR>',
        },
      }
    }
  },
  keys = {
    { '<leader>ff', '<cmd>Telescope find_files<cr>', desc = '[F]ind [F]iles' },
    { '<leader>fg', '<cmd>Telescope live_grep<cr>', desc = '[F]ind with [G]rep' },
    { '<leader>fib', '<cmd>Telescope current_buffer_fuzzy_find<cr>', desc = '[F]ind [I]n current [B]uffer' },
    { '<leader>fs', '<cmd>Telescope grep_string<cr>', desc = '[F]ind [S]tring with grep' },
    { '<leader>fb', '<cmd>Telescope buffers<cr>', desc = '[F]ind [B]uffers' },
    { '<leader>fh', '<cmd>Telescope help_tags<cr>', desc = '[F]ind [H]elp Tags' },
    { '<leader>fm', '<cmd>Telescope marks<cr>', desc = '[F]ind [M]arks' },
    { '<leader>fws', '<cmd>Telescope lsp_workspace_symbols<cr>', desc = '[F]ind [W]orkspace [S]ymbols' },
    { '<leader>gc', '<cmd>Telescope git_bcommits<cr>', desc = '[G]it Buffer [C]ommits' },
    { '<leader>gC', '<cmd>Telescope git_commits<cr>', desc = '[G]it [C]ommits' },
    { 'Q', '<cmd>Telescope cmdline<cr>', desc = 'Command Line'},
    { '<leader>jl', '<cmd>Telescope jumplist<cr>', desc = '[J]ump [L]ist' },
    { '<leader>le', '<cmd>Telescope diagnostics<cr>', desc = '[L]ist [E]rrors' },
  }
}
