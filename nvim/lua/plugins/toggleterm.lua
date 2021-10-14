require'toggleterm'.setup{}


vim.api.nvim_set_keymap("n", "<Leader>t", "[term]", {})
vim.api.nvim_set_keymap("n", "[term]t",
                        '<cmd>exe v:count1 . "ToggleTerm"<CR>', {})
vim.api.nvim_set_keymap("n", "[term]f",
                        '<cmd>exe v:count1 . "ToggleTerm direction=float"<CR>', {})

-- Terminal mode mapping to close current terminal
vim.api.nvim_set_keymap("t", "<C-t>c",
                        "<cmd>ToggleTerm<CR>", {})
