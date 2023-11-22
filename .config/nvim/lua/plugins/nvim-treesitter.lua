return {
	'nvim-treesitter/nvim-treesitter',
	build = function()
		vim.cmd('TSUpdate')
	end,
	main = 'nvim-treesitter.configs',
	opts = {
		highlight = {
			enable = true,
		},
		indent = {
			enable = true,
		},
	},
}
