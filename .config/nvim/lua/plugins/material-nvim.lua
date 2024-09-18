vim.g.material_style = 'deep ocean'

return {
  'marko-cerovac/material.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    require('material').setup({
      contrast = {
        sidebars = true,
        terminal = true,
        floating_windows = true,
        cursor_line = true,
      },
      disable = {
        colored_cursor = true,
      },
      plugins = {
        'nvim-cmp',
        'nvim-tree',
        'nvim-web-devicons',
        'telescope',
        'gitsigns',
      },
      lualine_style = 'stealth',
      custom_highlights = {
        IncSearch = {
          link = 'CurSearch',
        },
      },
    })
    vim.cmd('colorscheme material')
  end,
}
