local hop = require("hop")

hop.setup({})

vim.api.nvim_set_keymap("n", "<Leader>H", "[hop]", {})
vim.keymap.set("n", "[hop]h", function()
  hop.char2()
end, {})
vim.keymap.set("n", "[hop]s", function()
  hop.pattern()
end, {})
