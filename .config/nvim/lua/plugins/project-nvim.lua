return {
  'DrKJeff16/project.nvim',
  opts = {
    patterns = { '.envrc', 'turbo.json', '.git' },
    ignore_lsp = { 'ccls' },

    silent_chdir = true,
  },
}
