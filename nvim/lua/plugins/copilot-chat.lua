return { 
  'CopilotC-Nvim/CopilotChat.nvim',
  dependencies = { 
    { 'nvim-lua/plenary.nvim' },
    { 'github/copilot.vim'},
    { 'nvim-telescope/telescope.nvim' },
  },
  opts = {
    window = {
      layout = 'float',
    },
  },
  -- config = function()
  --   local actions = require('CopilotChat.actions')
  --   local integrations = require('CopilotChat.integrations.telescope')

  --   vim.keymap.set({ 'n', 'v' }, '<leader>pp', function()
  --     integrations.pick(actions.prompt_actions())
  --   end)
  -- end,
}
