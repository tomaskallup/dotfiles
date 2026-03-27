return {
	'saghen/blink.cmp',
	dependencies = {
		-- 'echasnovski/mini.nvim',
		'moyiz/blink-emoji.nvim',
	},

	version = '1.*',

	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		keymap = {
			preset = 'default',
			['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
			['<C-e>'] = { 'hide', 'fallback' },

			['<S-Tab>'] = { 'select_prev', 'fallback_to_mappings' },
			['<Tab>'] = { 'select_next', 'fallback_to_mappings' },
			['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
			['<C-n>'] = { 'select_next', 'fallback_to_mappings' },

			['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
			['<C-f>'] = { 'scroll_documentation_down', 'fallback' },

			['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
		},

		appearance = {
			nerd_font_variant = 'mono',
		},

		-- (Default) Only show the documentation popup when manually triggered
		completion = {
			documentation = { auto_show = true },
			list = { selection = { preselect = false } },
			keyword = { range = 'prefix' },
		},

		sources = {
			-- defaults to `{ 'buffer' }`
			default = { 'lsp', 'buffer', 'path', 'emoji' },
			providers = {
				lsp = { fallbacks = {} },
				buffer = {
					opts = {
						-- or (recommended) filter to only "normal" buffers
						get_bufnrs = function()
							return vim.tbl_filter(function(bufnr)
								return vim.bo[bufnr].buftype == ''
							end, vim.api.nvim_list_bufs())
						end,
					},
				},
				emoji = {
					module = 'blink-emoji',
					name = 'Emoji',
					score_offset = 15, -- Tune by preference
					opts = {
						insert = true, -- Insert emoji (default) or complete its name
						---@type string|table|fun():table
						trigger = function()
							return { ':' }
						end,
					},
					should_show_items = function()
						return vim.tbl_contains(
							-- Enable emoji completion only for git commits and markdown.
							-- By default, enabled for all file-types.
							{ 'gitcommit', 'markdown' },
							vim.o.filetype
						)
					end,
				},
			},
		},

		signature = { enabled = true },

		-- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
		-- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
		-- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
		--
		-- See the fuzzy documentation for more information
		fuzzy = { implementation = 'prefer_rust_with_warning' },
	},
	opts_extend = { 'sources.default' },
}
