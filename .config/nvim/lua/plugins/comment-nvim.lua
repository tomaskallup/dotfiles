return {
	'numToStr/Comment.nvim',
	opts = function()
		return {
			toggler = {
				---Line-comment toggle keymap
				line = '<Leader>cc',
				---Block-comment toggle keymap
				block = '<Leader>cb',
			},
			---LHS of operator-pending mappings in NORMAL and VISUAL mode
			opleader = {
				---Line-comment keymap
				line = '<Leader>c',
				---Block-comment keymap
				block = '<Leader>cb',
			},
			---LHS of extra mappings
			extra = {
				---Add comment on the line above
				above = '<Leader>cO',
				---Add comment on the line below
				below = '<Leader>co',
				---Add comment at the end of line
				eol = '<Leader>cA',
			},
			{
				pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
			},
		}
	end,
	dependencies = {
		'JoosepAlviste/nvim-ts-context-commentstring',
	},
}
