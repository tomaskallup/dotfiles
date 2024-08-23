return {
  'stevearc/oil.nvim',
	keys = {
		{ '<leader>mt', '<cmd>Oil<cr>', desc = 'Open Oil' },
		{ '<leader>mf', '<cmd>Oil --float<cr>', desc = 'Open Oil in a floating window' },
	},
  opts = {
    float = {
      padding = 10,
      max_width = 100,
      max_height = 60,
    }
  },
  -- Optional dependencies
  dependencies = { 'nvim-tree/nvim-web-devicons' },
}
