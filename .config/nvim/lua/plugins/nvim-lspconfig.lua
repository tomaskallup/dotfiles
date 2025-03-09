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
          return client.name ~= 'ts_ls' and client.name ~= 'pyright'
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
    local configs = require('lspconfig.configs')
    local util = require('lspconfig.util')
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
      css = { prettier },
      scss = { prettier },
      yaml = { prettier },
      html = { prettier },
      nix = {
        { formatCommand = 'nixfmt', formatStdin = true },
      },
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
        return configs.efm.config_def.default_config.root_dir(filename) or vim.fs.dirname(filename)
      end,
    })

    lspconfig.ts_ls.setup({
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

    --[[ lspconfig.ccls.setup({
      capabilities = capabilities,
    }) ]]

    lspconfig.clangd.setup({
      capabilities = capabilities,
    })

    lspconfig.nil_ls.setup({
      capabilities = capabilities,
      settings = {
        ['nil'] = {
          formatting = {
            command = { 'nixfmt' },
          },
        },
      },
    })

    lspconfig.cssls.setup({
      capabilities = capabilities,
    })

    lspconfig.prismals.setup({
      capabilities = capabilities,
    })

    -- Register c3-lsp
    if not configs.c3lsp then
      configs.c3lsp = {
        default_config = {
          -- cmd = { 'c3-lsp' },
          cmd = { '/home/armeeh/Pkg/c3-lsp/result/bin/c3lsp' },
          filetypes = { 'c3', 'c3i' },
          root_dir = function(fname)
            -- Do not run the LSP in c3c std lib, it just eats resources
            if string.find(fname, 'c3c/lib/') then
              return nil
            end
            return vim.fs.dirname(vim.fs.find('.git', { path = fname, upward = true })[1]);
          end,
          settings = {},
          name = 'c3lsp',
        },
      }
    end
    lspconfig.c3lsp.setup({})

    --Enable (broadcasting) snippet capability for completion
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    require'lspconfig'.jsonls.setup {
      capabilities = capabilities,
    }

    lspconfig.yamlls.setup({
      capabilities = capabilities,
      settings = {
        yaml = {
          schemas = {
            ['https://json.schemastore.org/github-workflow.json'] = '/.github/workflows/*',
            ['https://json.schemastore.org/workflows.json'] = '/gc-workflows/*.json',
          },
        },
      },
    })
  end,
  dependencies = { 'creativenull/efmls-configs-nvim', 'folke/neodev.nvim' },
}
