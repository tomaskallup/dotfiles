return {
  capabilities = {
    textDocument = {
      formatting = false,
      rangeFormatting = false,
    },
  },
  root_markers = { 'yarn.lock', 'lerna.json' },
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
    maxTsServerMemory = '8192',
    preferences = { quotePreference = 'single', allowIncompleteCompletions = false },
    provideFormatter = false,
  },
}
