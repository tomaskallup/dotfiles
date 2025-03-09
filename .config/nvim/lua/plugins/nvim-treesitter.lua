return {
  'nvim-treesitter/nvim-treesitter',
  -- commit = 'df0f8cb58e0c38408d50bd18f6004408f04252eb',
  build = function()
    vim.cmd('TSUpdate')
  end,
  main = 'nvim-treesitter.configs',
  config = function()
    local tree_sitter = require('nvim-treesitter.configs')
    tree_sitter.setup({
      ensure_installed = { 'c', 'javascript', 'typescript', 'lua' },
      sync_install = false,
      auto_install = false,
      ignore_install = {},
      modules = {},
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
    })
    vim.filetype.add({
      extension = {
        c3 = 'c3',
        c3i = 'c3',
        c3t = 'c3',
      },
    })

    local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
    parser_config.c3 = {
      install_info = {
        -- url = 'https://github.com/c3lang/tree-sitter-c3',
        url = '~/Pkg/tree-sitter-c3',
        files = { 'src/parser.c', 'src/scanner.c' },
        branch = 'main',
      },
      filetype = 'c3',
    }
  end,
}
