local dap = require 'dap'

-- Allow running custom command (build) before running adapter
dap.adapters.node2 = function(cb, config)
    if config.preLaunchTask then vim.fn.system(config.preLaunchTask) end
    local adapter = {
        type = 'executable',
        command = 'node',
        args = {
            os.getenv('HOME') .. '/Pkg/vscode-node-debug2/out/src/nodeDebug.js'
        },
        env = config.env or {}
    }
    cb(adapter)
end

vim.api.nvim_set_keymap("n", "<Leader>D", "[DAP]", {})
vim.api.nvim_set_keymap("n", "[DAP]b",
                        "<cmd>lua require'dap'.toggle_breakpoint()<CR>", {})
vim.api.nvim_set_keymap("n", "[DAP]B",
                        "<cmd>lua require'dap'.toggle_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
                        {})
vim.api.nvim_set_keymap("n", "[DAP]c", "<cmd>lua require'dap'.continue()<CR>",
                        {})
vim.api.nvim_set_keymap("n", "[DAP]s", "<cmd>lua require'dap'.step_over()<CR>",
                        {})
vim.api.nvim_set_keymap("n", "[DAP]S", "<cmd>lua require'dap'.step_into()<CR>",
                        {})
vim.api.nvim_set_keymap("n", "[DAP]r", "<cmd>lua require'dap'.repl.open()<CR>",
                        {})
vim.api
    .nvim_set_keymap("n", "[DAP]R", "<cmd>lua require'dap'.restart()<CR>", {})
vim.api.nvim_set_keymap("n", "[DAP]e", "<cmd>lua require'dap'.stop()<CR>", {})
