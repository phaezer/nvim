-- WTF
-- NOTE: helps work out what the fudge that diagnostic means and how to fix it
return {
  'piersolenski/wtf.nvim',
  dependencies = {
    'MunifTanjim/nui.nvim',
  },

  opts = {
    openai_model_id = 'gpt-4o',
    language = 'english',
    search_engine = 'google',
    additional_instructions = [[
      Be concise and to the point. Provide examples and code snippets when appropriate. Offer multiple solutions when appropriate.
      If the provided diagnostics and code is not clear, or does not provide enough context, ask for more information.]],
  },

  keys = {
    {
      '<leader>?a',
      function() require('wtf').ai() end,
      desc = 'Debug diagnostic with AI',
      mode = { 'n', 'x' },
    },
    {
      '<leader>?s',
      function() require('wtf').search() end,
      desc = 'Search diagnostic with Google',
    },
    {
      '<leader>?h',
      function() require('wtf').history() end,
      desc = 'Populate the quickfix list with previous chat history',
    },
    {
      '<leader>?g',
      function() require('wtf').grep_history() end,
      desc = 'Grep previous chat history with Telescope',
    },
  },
}
