local list_extend = function(where, what)
  return vim.list_extend(vim.deepcopy(where), what)
end

local list_filter = function(where, what)
  -- stylua: ignore
  return vim.iter(where):filter(function(val) return not vim.list_contains(what, val) end):totable()
end

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
	---@class snacks.Picker
	---@field [string] unknown
	---@class snacks.picker.Config
	---@field [string] unknown
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
				grep = {
					case_sens = false,
					toggles = {
						case_sens = 's',
					},
					finder = function(opts, ctx)
						local args_extend = { '--case-sensitive' }
						opts.args = list_filter(opts.args or {}, args_extend)
						if opts.case_sens then
							opts.args = list_extend(opts.args, args_extend)
						end
						return require('snacks.picker.source.grep').grep(opts, ctx)
					end,
					actions = {
						toggle_live_case_sens = function(picker) -- [[Override]]
							picker.opts.case_sens = not picker.opts.case_sens
							picker:find()
						end,
					},
					win = {
						input = {
							keys = {
								['<C-i>'] = { 'toggle_live_case_sens', mode = { 'i' } },
							},
						},
					},
				},
			},
		},
		notifier = { enabled = true },
		scope = { enabled = true },
		scroll = { enabled = false },
	},
}
