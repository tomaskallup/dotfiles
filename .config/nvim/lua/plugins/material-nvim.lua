vim.g.material_style = 'deep ocean'

return {
	'marko-cerovac/material.nvim',
	lazy = false,
	priority = 1000,
	config = function()
		require('material').setup({
			contrast = {
				sidebars = true,
				terminal = true,
				floating_windows = true,
			},
			disable = {
				colored_cursor = true,
			},
			plugins = {
				'nvim-cmp',
				'nvim-tree',
				'nvim-web-devicons',
				'telescope',
				'gitsigns',
			},
			lualine_style = 'stealth',
		})
		vim.cmd('colorscheme material')
	end,
}
