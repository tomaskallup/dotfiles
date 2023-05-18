require("nvim-tree").setup({
  view = {
    adaptive_size = true,
  },
})

local api = require("nvim-tree.api")

vim.api.nvim_set_keymap("n", "<Leader>m", "[NvimTree]", {})
vim.keymap.set("n", "[NvimTree]t", function()
  api.tree.toggle({ focus = true })
end)
vim.keymap.set("n", "[NvimTree]f", function()
  api.tree.find_file({ focus = true, open = true })
end)
vim.keymap.set("n", "[NvimTree]F", api.tree.focus)
