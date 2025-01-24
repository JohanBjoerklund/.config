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
}
