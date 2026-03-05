return {
  'DrKJeff16/project.nvim',
  opts = {
    patterns = { '.envrc', 'turbo.json', '.git' },
    lsp = {
      ignore = { 'ccls' }
    },

    silent_chdir = true,
  },
}
