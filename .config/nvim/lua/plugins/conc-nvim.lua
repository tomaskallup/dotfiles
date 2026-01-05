return {
  dir = '~/Projects/Me/conc.nvim',
  opts = {},
  dependencies = {
    'lewis6991/async.nvim',
  },
  keys = {
    { '<leader>C', "<cmd>lua require('conc').open()<cr>", desc = 'Open Conc' },
  },
}
