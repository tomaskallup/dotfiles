return {
	'folke/snacks.nvim',
	priority = 1000,
	lazy = false,
	keys = {
		{
			'<leader>ff',
			function()
				Snacks.picker.files()
			end,
			{ desc = 'Find files' },
		},
		{
			'<leader>fg',
			function()
				Snacks.picker.grep()
			end,
			{ desc = 'Telescope live grep' },
		},
		{
			'<leader>fb',
			function()
				Snacks.picker.buffers()
			end,
			{ desc = 'Search buffers' },
		},
		{
			'<leader>fB',
			function()
				Snacks.picker.grep_buffers()
			end,
			{ desc = 'Grep buffers' },
		},
		{
			'<leader>fq',
			function()
				Snacks.picker.qflist()
			end,
			{ desc = 'Search quickfix' },
		},
		-- Grep in specific directory (defaults to current buffer dir)
		{
			'<leader>fG',
			function()
				vim.ui.input(
					{ prompt = 'Enter directory: ', completion = 'dir', default = vim.fn.expand('%:h') },
					function(input)
						if input ~= nil then
							Snacks.picker.grep({ dirs = { input } })
						end
					end
				)
			end,
			{ desc = 'Live grep in directory' },
		},

		-- Find files in specific directory (defaults to current buffer dir)
		{
			'<leader>fF',
			function()
				vim.ui.input(
					{ prompt = 'Enter directory: ', completion = 'dir', default = vim.fn.expand('%:h') },
					function(input)
						if input ~= nil then
							Snacks.picker.files({ dirs = { input } })
						end
					end
				)
			end,
			{ desc = 'Find files in directory' },
		},
		{
			'<leader>fn',
			function()
				Snacks.picker.files({ dirs = { '~/Notes' } })
			end,
			{ desc = 'Find files in Notes' },
		},
	},
	---@type snacks.Config
	opts = {
		indent = { enabled = true },
		input = { enabled = true },
		picker = {
			enabled = true,
			sources = {
				buffers = {
					win = {
						input = {
							keys = {
								['<c-d>'] = { 'bufdelete', mode = { 'n', 'i' } },
							},
						},
						list = { keys = { ['dd'] = 'bufdelete' } },
					},
				},
			},
		},
		notifier = { enabled = true },
		scope = { enabled = true },
		scroll = { enabled = false },
	},
}
