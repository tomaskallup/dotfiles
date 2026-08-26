return {
	'stevearc/conform.nvim',
	opts = {
		formatters_by_ft = {
			lua = { 'stylua' },
			javascript = { 'eslint_d', stop_after_first = true },
			typescript = { 'eslint_d', stop_after_first = true },
			typescriptreact = { 'eslint_d', stop_after_first = true },
			sql = { 'pg_format' },
      c3 = { 'c3fmt' },
		},
		formatters = {
			eslint_d = {
				cwd = function(self, ctx)
					return require('conform.util').root_file({ 'package.json' })(self, ctx)
				end,
			},
			c3fmt = {
        command = '/home/armeeh/Pkg/c3-tooling/c3fmt/build/c3fmt',
        args = { "--stdout", "--stdin", "--stdin-filepath=$FILENAME" },
				cwd = function(self, ctx)
					return require('conform.util').root_file({ 'project.json' })(self, ctx)
				end,
			},
		},
		default_format_opts = {
			lsp_format = 'fallback',
		},
	},
	keys = {
		{
			'<leader>=',
			function()
				require('conform').format({ async = true })
			end,
			desc = 'Format buffer',
		},
	},
}
