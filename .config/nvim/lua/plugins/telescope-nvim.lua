return {
  'nvim-telescope/telescope.nvim',
  dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope-fzy-native.nvim' },
  keys = {
    { '<leader>ff', '<cmd>Telescope find_files<cr>', { desc = 'Telescope find files' } },
    { '<leader>fg', '<cmd>Telescope live_grep<cr>',  { desc = 'Telescope live grep' } },
    { '<leader>fb', '<cmd>Telescope buffers<cr>',    { desc = 'Telescope search buffers' } },
    { '<leader>fq', '<cmd>Telescope quickfix<cr>',   { desc = 'Telescope search quickfix' } },
  },
  config = function()
    local telescope = require('telescope')
    telescope.setup({
      defaults = {
        vimgrep_arguments = {
          'rg',
          '--color=never',
          '--no-heading',
          '--with-filename',
          '--line-number',
          '--column',
          '--smart-case',
          '--hidden',
        },
      },
      pickers = { buffers = { mappings = { i = { ['<c-d>'] = 'delete_buffer' } } } },
    })

    telescope.load_extension('fzy_native')
  end,
}
