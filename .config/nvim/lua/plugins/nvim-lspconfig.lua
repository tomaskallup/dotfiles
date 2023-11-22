vim.keymap.set('n', '<space>d', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('UserLspConfig', {}),
	callback = function(ev)
		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf }
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
		vim.keymap.set('n', 'gh', vim.lsp.buf.hover, opts)
		vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
		vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
		vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
		vim.keymap.set({ 'n', 'v' }, '<space>i', vim.lsp.buf.code_action, opts)
		vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
		vim.keymap.set('n', '<space>=', function()
			vim.lsp.buf.format({
				async = true,
				filter = function(client)
					return client.name ~= 'tsserver' and client.name ~= 'pyright' and client.name ~= 'eslint'
				end,
			})
		end, opts)
	end,
})

return {
	'neovim/nvim-lspconfig',
	config = function()
		local capabilities = require('cmp_nvim_lsp').default_capabilities()
		local lspconfig = require('lspconfig')
		local eslint = require('efmls-configs.linters.eslint_d')
		local prettier = require('efmls-configs.formatters.prettier_d')
		local stylua = require('efmls-configs.formatters.stylua')
		local jq = require('efmls-configs.formatters.jq')
		local languages = {
			typescript = { eslint, prettier },
			typescriptreact = { eslint, prettier },
			lua = { stylua },
			json = { jq },
		}

		lspconfig['efm'].setup({
			single_file_support = false,
			filetypes = vim.tbl_keys(languages),
			settings = {
				rootMarkers = { '.git/' },
				languages = languages,
			},
			init_options = {
				documentFormatting = true,
				documentRangeFormatting = true,
			},
			capabilities = capabilities,
		})

		lspconfig.tsserver.setup({
			capabilities = capabilities,
		})

		lspconfig.lua_ls.setup({
			capabilities = capabilities,
		})

		lspconfig.nil_ls.setup({
			capabilities = capabilities,
		})
	end,
	dependencies = { 'creativenull/efmls-configs-nvim' },
}
