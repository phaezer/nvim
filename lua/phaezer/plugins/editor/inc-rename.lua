-- NOTE: adds visual feedback when renaming symbols
return {
  'smjonas/inc-rename.nvim',
  command = { 'IncRename' },
  opts = {
    input_buffer_type = 'snacks',
  },
}
