require'toggleterm'.setup{}


vim.api.nvim_set_keymap("n", "<Leader>t", "[term]", {})
vim.api.nvim_set_keymap("n", "[term]t",
                        '<cmd>exe v:count1 . "ToggleTerm"<CR>', {})
vim.api.nvim_set_keymap("n", "[term]f",
                        '<cmd>exe v:count1 . "ToggleTerm direction=float"<CR>', {})
vim.api.nvim_set_keymap("n", "[term]v",
                        '<cmd>exe v:count1 . "ToggleTerm direction=horizontal"<CR>', {})
vim.api.nvim_set_keymap("n", "[term]s",
                        '<cmd>exe v:count1 . "ToggleTerm direction=vertical"<CR>', {})

-- Terminal mode mapping to close current terminal
vim.api.nvim_set_keymap("t", "<C-t>c",
                        "<cmd>ToggleTerm<CR>", {})
