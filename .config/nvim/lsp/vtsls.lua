return {
  cmd = { 'vtsls', '--stdio' },
  filetypes = {
    'javascript',
    'javascriptreact',
    'javascript.jsx',
    'typescript',
    'typescriptreact',
    'typescript.tsx',
  },
  capabilities = {
    textDocument = {
      formatting = false,
      rangeFormatting = false,
    },
  },
  root_markers = { 'yarn.lock', 'lerna.json', 'turbo.json', 'package.json' },
  settings = {
    documentFormatting = false,
    typescript = {
      tsserver = {
        maxTsServerMemory = 8192,
        log = '/home/armeeh/tsserver.log',
      },
    },
    vtsls = {
      autoUseWorkspaceTsdk = true,
    },
  },
  init_options = {
    hostInfo = 'neovim',
    provideFormatter = false,
    vtsls = {
      autoUseWorkspaceTsdk = true,
    },
    typescript = {
      tsserver = {
        maxTsServerMemory = 8192,
        log = '/home/armeeh/tsserver.log',
      },
    },
  },
}
