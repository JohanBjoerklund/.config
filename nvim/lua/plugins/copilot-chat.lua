return { 
  'CopilotC-Nvim/CopilotChat.nvim',
  dependencies = { 
    { 'nvim-lua/plenary.nvim' },
    { 'github/copilot.vim'},
    { 'nvim-telescope/telescope.nvim' },
  },
  config = function()
    local chat = require('CopilotChat')
    local select = require('CopilotChat.select')

    chat.setup({
      window = {
        layout = 'float',
        relative = 'cursor',
      },
      answer_header = ' ' .. '❗' .. ' ',
      question_header = ' ' .. '❓' .. ' ',
      selection = function(source)
        return select.visual(source) or select.buffer(source)
      end,
      prompts = {
        Explain = {
            mapping = '<leader>ae',
            description = 'AI Explain',
            prompt = 'Write an explanation for the selected code as paragraphs of text.',
            system_prompt = 'COPILOT_EXPLAIN',
        },
        Review = {
            mapping = '<leader>ar',
            description = 'AI Review',
            prompt = 'Review the selected code.',
            system_prompt = 'COPILOT_REVIEW',
        },
        Tests = {
            mapping = '<leader>at',
            prompt = 'Please generate tests for my code.',
            description = 'AI Tests',
        },
        Fix = {
            mapping = '<leader>af',
            prompt = 'There is a problem in this code. Identify the issues and rewrite the code with fixes. Explain what was wrong and how your changes address the problems.',
            description = 'AI Fix',
        },
        Optimize = {
            mapping = '<leader>ao',
            prompt = 'Optimize the selected code to improve performance and readability. Explain your optimization strategy and the benefits of your changes.',
            description = 'AI Optimize',
        },
        Docs = {
            mapping = '<leader>ad',
            prompt = 'Please add documentation comments to the selected code.',
            description = 'AI Documentation',
        },
        Commit = {
            mapping = '<leader>ac',
            description = 'AI Generate Commit',
            prompt = 'Write commit message for the change with commitizen convention. Keep the title under 50 characters and wrap message at 72 characters. Format as a gitcommit code block.',
            selection = 'git:staged',
        },
      },
    })

    local actions = require('CopilotChat.actions')
    local integrations = require('CopilotChat.integrations.telescope')

    vim.keymap.set({ 'n', 'v' }, '<leader>ap', function()
      integrations.pick(actions.prompt_actions())
    end)

    vim.api.nvim_create_autocmd('BufEnter', {
        pattern = 'copilot-*',
        callback = function()
            -- Set buffer-local options
            vim.opt_local.relativenumber = false
            vim.opt_local.number = false
            vim.opt_local.conceallevel = 0
        end
    })

  end,
}
