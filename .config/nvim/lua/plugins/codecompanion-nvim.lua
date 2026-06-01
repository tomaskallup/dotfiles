return {
	enabled = false,
	'olimorris/codecompanion.nvim',
	opts = {
		adapters = {
			acp = {
				claude_code = function()
					return require('codecompanion.adapters').extend('claude_code', {
						env = {
							CLAUDE_CODE_OAUTH_TOKEN = 'CLAUDE_CODE_API_KEY',
						},
					})
				end,
			},
			http = {
				novita = function()
					return require('codecompanion.adapters').extend('novita', {
						schema = {
							model = {
								-- default = 'deepseek/deepseek-v3-turbo',
								default = 'deepseek/deepseek-v3-0324',
								-- default = 'qwen/qwen3-coder-480b-a35b-instruct',
								-- default = 'zai-org/glm-5',
							},
						},
					})
				end,
				openai = function()
					return require('codecompanion.adapters').extend('openai', {
						env = {
							api_key = 'REAS_OPENAI_NVIM_SECRET',
						},
					})
				end,
			},
		},
		strategies = {
			chat = {
				adapter = 'claude_code',
			},
			inline = {
				adapter = 'novita',
			},
			cmd = {
				adapter = 'novita',
			},
		},
		display = {
			diff = {
				provider_opts = {
					inline = {
						layout = 'float',
						opts = {
							context_lines = 3,
							dim = 25,
							full_width_removed = true,
							show_keymap_hints = true,
							show_removed = true,
						},
					},
				},
			},
		},
	},
	dependencies = {
		'nvim-lua/plenary.nvim',
		'nvim-treesitter/nvim-treesitter',
	},
}
