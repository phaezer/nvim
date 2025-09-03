-- NOTE: adds additional mappings to CTRL-A, CTRL-X for toggling booleans and more
-- by default this includes boolean true / false, yes / no, on / off, enabled / disabledj
return {
  'nat-418/boole.nvim',
  lazy = false,
  opts = {
    mappings = {
      increment = '<C-a>',
      decrement = '<C-x>',
    },
  },
}
