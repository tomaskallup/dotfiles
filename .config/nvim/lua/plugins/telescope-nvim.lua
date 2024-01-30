return {
  'nvim-telescope/telescope.nvim',
  dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope-fzy-native.nvim' },
  keys = {
    { '<leader>ff', '<cmd>Telescope find_files<cr>',   { desc = 'Telescope find files' } },
    { '<leader>fg', '<cmd>Telescope live_grep<cr>',    { desc = 'Telescope live grep' } },
    { '<leader>fb', '<cmd>Telescope buffers<cr>',      { desc = 'Telescope search buffers' } },
    { '<leader>fB', '<cmd>Telescope file_browser<cr>', { desc = 'Telescope file browser' } },
    { '<leader>fq', '<cmd>Telescope quickfix<cr>',     { desc = 'Telescope search quickfix' } },
    -- Grep in specific directory (defaults to current buffer dir)
    {
      '<leader>fG',
      function()
        vim.ui.input(
          { prompt = 'Enter directory: ', completion = 'dir', default = vim.fn.expand('%:h') },
          function(input)
            if input ~= nil then
              require('telescope.builtin').live_grep({ search_dirs = { input } })
            end
          end
        )
      end,
      { desc = 'Telescope live grep in directory' },
    },

    -- Find files in specific directory (defaults to current buffer dir)
    {
      '<leader>fF',
      function()
        vim.ui.input(
          { prompt = 'Enter directory: ', completion = 'dir', default = vim.fn.expand('%:h') },
          function(input)
            if input ~= nil then
              require('telescope.builtin').find_files({ cwd = input })
            end
          end
        )
      end,
      { desc = 'Telescope find files in directory' },
    },
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
