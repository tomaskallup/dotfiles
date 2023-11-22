return {
	'nvim-tree/nvim-tree.lua',
	version = '*',
	lazy = true,
	cmd = 'NvimTree',
	keys = {
		{ '<leader>mt', '<cmd>NvimTreeToggle<cr>', desc = 'NvimTree toggle' },
		{ '<leader>mf', '<cmd>NvimTreeFindFileToggle<cr>', desc = 'NvimTree find file or toggle' },
	},
	dependencies = {
		'nvim-tree/nvim-web-devicons',
	},
	opts = {
		sync_root_with_cwd = true,
		respect_buf_cwd = true,
		update_focused_file = {
			enable = true,
			update_root = true,
		},
    view = {
      width = 50,
    },
	},
}
