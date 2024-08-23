return {
	'ahmedkhalf/project.nvim',
	main = 'project_nvim',
	opts = {
		patterns = { '.envrc', 'lerna.json', 'nx.json', '.git' },
    ignore_lsp = { 'ccls' },

    silent_chdir = true,
	},
}
