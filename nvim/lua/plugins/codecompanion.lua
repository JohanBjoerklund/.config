return {
  'olimorris/codecompanion.nvim',
  opts = {
    display = {
      action_palette = {
        position = 'bottom',
        width = 95,
        hight = 10,
        provider = 'telescope',
        opts = {
          show_default_actions = true,
          show_default_prompt_library = true
        },
      },
      chat = {
        window = {
        position = 'right',
          width = 0.3,
        },
      },
    },
    extensions = {
      mcphub = {
        callback = 'mcphub.extensions.codecompanion',
        opts = {
          make_vars = true,
          make_slash_commands = true,
          show_results_in_chat = true,
        },  
      },
    },
  },
  keys = {
    {'<leader>ca', '<cmd>CodeCompanionAction<cr>', desc = 'AI [A]ction'},
    {'<leader>cs', '<cmd>CodeCompanionChat<cr>', desc = 'AI [S]tart'},
    {
      '<leader>cc',
      function()
        require('codecompanion').prompt('commit')
      end,
      desc = 'AI [C]ommit'
    },
    {
      '<leader>ce',
      function()
        require('codecompanion').prompt('explain')
      end,
      desc = 'AI [E]xplain'
    },
    {
      '<leader>ct',
      function()
        require('codecompanion').prompt('tests')
      end,
      desc = 'AI [T]ests'
    },
    {
      '<leader>cf',
      function()
        require('codecompanion').prompt('fix')
      end,
      desc = 'AI [F]ix'
    },
  },
  dependencies = {
    {'nvim-lua/plenary.nvim'},
    {'nvim-treesitter/nvim-treesitter'},
    {'ravitemer/mcphub.nvim'},
    {'echasnovski/mini.diff', opts = {}},
  }
}
