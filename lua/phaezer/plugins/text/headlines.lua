local highlights = require 'phaezer.config.highlights'

-- NOTE: highlights headlines in markdwon, org, and other files
return {
  'lukas-reineke/headlines.nvim',
  enabled = false,
  ft = { 'markdown', 'org', 'norg', 'rmd' },
  dependencies = 'nvim-treesitter/nvim-treesitter',
  opts = {
    markdwon = {
      headline_highlights = highlights.rainbow.names.headlines,
    },
    rmd = {
      headline_highlights = highlights.rainbow.names.headlines,
    },
    norg = {
      headline_highlights = highlights.rainbow.names.headlines,
    },
    org = {
      headline_highlights = highlights.rainbow.names.headlines,
    },
  },
}
