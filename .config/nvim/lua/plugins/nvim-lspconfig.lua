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
          return client.name ~= 'tsserver' and client.name ~= 'pyright'
        end,
      })
    end, opts)
  end,
})

return {
  'neovim/nvim-lspconfig',
  config = function()
    require('neodev').setup({
      override = function(root_dir, library)
        if root_dir:find('/home/armeeh/Pkg/dotfiles/.config/nvim', 1, true) == 1 then
          library.enabled = true
          library.plugins = true
        end
      end,
    }) -- Setup lua development for neovim (completion etc.)

    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    local capabilitiesWithoutFomatting = require('cmp_nvim_lsp').default_capabilities({
      textDocument = {
        formatting = false,
        rangeFormatting = false,
        range_formatting = false,
      },
    })
    local lspconfig = require('lspconfig')
    local eslint = require('efmls-configs.linters.eslint_d')
    local eslint_format = require('efmls-configs.formatters.eslint_d')
    local prettier = require('efmls-configs.formatters.prettier_d')
    local stylua = require('efmls-configs.formatters.stylua')
    local jq = require('efmls-configs.formatters.jq')
    local languages = {
      typescript = { eslint, eslint_format, prettier },
      typescriptreact = { eslint, eslint_format, prettier },
      javascript = { eslint, eslint_format, prettier },
      lua = { stylua },
      json = { jq },
    }

    lspconfig['efm'].setup({
      cmd = { 'efm-langserver', '-logfile', '/home/armeeh/efm.log' },
      single_file_support = true,
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
      root_dir = function(filename)
        if string.find(filename, 'node_modules/') then
          return nil
        end
        return require('lspconfig.server_configurations.efm').default_config.root_dir(filename)
            or lspconfig.util.path.dirname(filename)
      end,
    })

    lspconfig.tsserver.setup({
      capabilities = capabilitiesWithoutFomatting,
      root_dir = lspconfig.util.root_pattern('yarn.lock', 'lerna.json', '.git'),
      settings = {
        documentFormatting = false,
        typescript = {
          inlayHints = {
            includeInlayParameterNameHints = 'all',
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          },
        },
      },
      init_options = {
        hostInfo = 'neovim',
        maxTsServerMemory = '8192',
        preferences = { quotePreference = 'single', allowIncompleteCompletions = false },
      },
    })

    lspconfig.lua_ls.setup({
      capabilities = capabilities,
    })

    lspconfig.cmake.setup({
      capabilities = capabilities,
    })

    lspconfig.ccls.setup({
      capabilities = capabilities,
    })

    lspconfig.nil_ls.setup({
      capabilities = capabilities,
    })
  end,
  dependencies = { 'creativenull/efmls-configs-nvim', 'folke/neodev.nvim' },
}
