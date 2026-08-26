return {
	'nvim-treesitter/nvim-treesitter',
	-- commit = 'df0f8cb58e0c38408d50bd18f6004408f04252eb',
	branch = 'main',
	build = ':TSUpdate',
	lazy = false,
	-- main = 'nvim-treesitter.configs',
	config = function()
		local tree_sitter = require('nvim-treesitter')
		vim.filetype.add({
			extension = {
				c3 = 'c3',
				c3i = 'c3',
				c3t = 'c3',
			},
		})

		vim.api.nvim_create_autocmd('User', {
			pattern = 'TSUpdate',
			callback = function()
				require('nvim-treesitter.parsers').c3.install_info = {
					path = '~/Pkg/c3-tooling/tree-sitter-c3/',
					queries = 'queries',
				}
			end,
		})

		local languages =
			{ 'c3', 'c', 'javascript', 'typescript', 'tsx', 'lua', 'elixir', 'haskell', 'markdown', 'heex', 'yaml' }
		local patterns = {
			'c3',
			'c',
			'javascript',
			'typescript',
			'typescriptreact',
			'lua',
			'elixir',
			'haskell',
			'markdown',
			'heex',
			'yaml',
		}

		tree_sitter.install(languages)

		vim.api.nvim_create_autocmd('FileType', {
			pattern = patterns,
			callback = function()
				vim.treesitter.start()

				vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
				vim.wo[0][0].foldmethod = 'expr'
				vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})
	end,
}
