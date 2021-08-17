local neogit = require('neogit')

neogit.setup{
  integrations = {
    disable_signs = false,
    diffview = false
  }
}

vim.api.nvim_set_keymap('n', '<Leader>G', '[neogit]', {})
vim.api.nvim_set_keymap('n', '[neogit]s', '<cmd>Neogit<CR>', { silent = true })
