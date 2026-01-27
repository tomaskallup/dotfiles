return {
	'norcalli/nvim-colorizer.lua',
	config = function()
		require('colorizer').setup({
			'css',
			'scss',
			'javascript',
			html = {
				mode = 'foreground',
			},
		})
	end,
}
