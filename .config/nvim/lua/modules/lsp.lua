vim.lsp.enable({
  'c3lsp',
  'cssls',
  'clangd',
  'efm',
  'jsonls',
  'lua_ls',
  'nil_ls',
  'prismals',
  -- 'ts_ls',
  'vtsls',
  'yamlls',
  'elixirls'
})

vim.lsp.config('vtsls', {
  root_markers = { 'yarn.lock', 'lerna.json', 'turbo.json' },
})

vim.diagnostic.config({
  severity_sort = true,
  virtual_lines = false,
  underline = true,
  float = true,
  jump = {
    float = true,
  }
})

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
    vim.keymap.set('n', '<C-w>gd', function () vim.cmd('vsplit') vim.lsp.buf.definition({ reuse_win = true }) end, opts)
    vim.keymap.set('n', 'gh', function () vim.lsp.buf.hover({ border = 'rounded' }) end, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)

    vim.keymap.set('n', '<space>d', vim.diagnostic.open_float)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>i', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>=', function()
      vim.lsp.buf.format({
        async = true,
        filter = function(client)
          return client.name ~= 'ts_ls' and client.name ~= 'pyright' and client.name ~= 'vtsls'
        end,
      })
    end, opts)
  end,
})

local capabilities = require('blink.cmp').get_lsp_capabilities()
-- local capabilities = require('cmp_nvim_lsp').default_capabilities()
vim.lsp.config('*', {
  capabilities = capabilities,
  root_markers = { '.git/' },
})
