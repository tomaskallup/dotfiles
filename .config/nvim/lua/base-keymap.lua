vim.g.mapleader = ' '

vim.keymap.set('i', 'jk', '<esc>')
vim.keymap.set('i', 'kj', '<esc>')

vim.keymap.set('v', 'v', '<esc>')

vim.keymap.set('n', '<leader>w', '<cmd>write<cr>', { desc = 'Save' })
vim.keymap.set('n', '<leader>q', '<cmd>quit<cr>', { desc = 'Quit' })
vim.keymap.set('n', '<leader>x', '<cmd>xit<cr>', { desc = 'Save & Quit' })

vim.keymap.set('n', '<leader>h', '<C-w>h')
vim.keymap.set('n', '<leader>j', '<C-w>j')
vim.keymap.set('n', '<leader>k', '<C-w>k')
vim.keymap.set('n', '<leader>l', '<C-w>l')

vim.keymap.set('n', '<leader>bp', '<cmd>bp<cr>')
vim.keymap.set('n', '<leader>bn', '<cmd>bn<cr>')
vim.keymap.set('n', '<leader>bd', '<cmd>bp|bd #<cr>')
vim.keymap.set('n', '<leader>bD', '<cmd>bd<cr>')

vim.keymap.set('n', '<leader>cp', '<cmd>cp<cr>')
vim.keymap.set('n', '<leader>cn', '<cmd>cn<cr>')
