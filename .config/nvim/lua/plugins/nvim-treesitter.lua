return {
  'nvim-treesitter/nvim-treesitter',
  -- commit = 'df0f8cb58e0c38408d50bd18f6004408f04252eb',
  branch = 'main',
  build = ':TSUpdate',
  lazy = false,
  -- main = 'nvim-treesitter.configs',
  config = function()
    local tree_sitter = require('nvim-treesitter')
    vim.filetype.add({
      extension = {
        c3 = 'c3',
        c3i = 'c3',
        c3t = 'c3',
      },
    })

    require('nvim-treesitter.parsers').c3 = {
      install_info = {
        -- url = 'https://github.com/c3lang/tree-sitter-c3',
        url = '~/Pkg/tree-sitter-c3',
        files = { 'src/parser.c', 'src/scanner.c' },
        branch = 'main',
      },
      filetype = 'c3',
    }

    local languages = { 'c3', 'c', 'javascript', 'typescript', 'lua', 'elixir' }

    tree_sitter.install(languages):wait(300000)

    vim.api.nvim_create_autocmd('FileType', {
      pattern = languages,
      callback = function()
        vim.treesitter.start()

        vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        vim.wo[0][0].foldmethod = 'expr'
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
