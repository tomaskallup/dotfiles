require'nvim-treesitter.configs'.setup {
  ensure_installed = {"typescript", "javascript", "python"},
  indent = {
    enable = true,
  },
  highlight = {
    enable = true,
  }
}
