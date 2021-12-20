require'nvim-tree'.setup {
    update_focused_file = {enable = true},
    view = {width = 35}
}

vim.api.nvim_set_keymap("n", "<Leader>m", "[NvimTree]", {})
vim.api.nvim_set_keymap("n", "[NvimTree]t", "<cmd>NvimTreeToggle<CR>", {})
vim.api.nvim_set_keymap("n", "[NvimTree]f", "<cmd>NvimTreeFindFile<CR>", {})
vim.api.nvim_set_keymap("n", "[NvimTree]F", "<cmd>NvimTreeFocus<CR>", {})
