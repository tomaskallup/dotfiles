local dap = require("dap")
local Job = require("plenary.job")
local vscodeJsAdapter = require("dap-vscode-js.adapter")
local vscodeJsConfig = require("dap-vscode-js.config")

require("dap-vscode-js").setup({
  node_path = "node",
  adapters = {}, -- which adapters to register in nvim-dap
})

-- Allow running custom command (build) before running adapter
dap.adapters.node2 = function(cb, config)
  if config.preLaunchTask then
    vim.fn.system(config.preLaunchTask)
  end
  local adapter = {
    type = "executable",
    command = "node",
    args = {
      os.getenv("HOME") .. "/Pkg/vscode-node-debug2/out/src/nodeDebug.js",
    },
    env = config.env or {},
  }
  cb(adapter)
end
dap.adapters["pwa-node"] = function(cb, config)
  local adapter = vscodeJsAdapter.generate_adapter("pwa-node", vscodeJsConfig)
  local isDone = false

  if config.preLaunchTask then
    local notification = vim.notify("Running preLaunchTask", vim.log.levels.INFO, { keep = function () return not isDone end })

    local Terminal = require("toggleterm.terminal").Terminal

    local term = Terminal:new({
      dir = config.cwd,
      on_exit = function(t, job, exit_code)
        print(exit_code)
        if exit_code ~= 0 then
          vim.notify(
            "preLaunchTask failed",
            vim.log.levels.ERROR,
            { replace = notification, keep = false }
          )
        else
          vim.notify(
            "preLaunchTask successful, starting debugger",
            vim.log.levels.INFO,
            { replace = notification, keep = false }
          )
          t:close()
          adapter(cb)
        end
        isDone = true;
      end,
      cmd = config.preLaunchTask,
    })

    term:open()
  else
    adapter(cb)
  end
end

vim.api.nvim_set_keymap("n", "<Leader>D", "[DAP]", {})
vim.api.nvim_set_keymap("n", "[DAP]b", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", {})
vim.api.nvim_set_keymap(
  "n",
  "[DAP]B",
  "<cmd>lua require'dap'.toggle_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
  {}
)
vim.api.nvim_set_keymap("n", "[DAP]c", "<cmd>lua require'dap'.continue()<CR>", {})
vim.api.nvim_set_keymap("n", "[DAP]s", "<cmd>lua require'dap'.step_over()<CR>", {})
vim.api.nvim_set_keymap("n", "[DAP]S", "<cmd>lua require'dap'.step_into()<CR>", {})
vim.api.nvim_set_keymap("n", "[DAP]r", "<cmd>lua require'dap'.repl.toggle()<CR>", {})
vim.api.nvim_set_keymap("n", "[DAP]R", "<cmd>lua require'dap'.restart()<CR>", {})
vim.api.nvim_set_keymap(
  "n",
  "[DAP]e",
  "<cmd>lua require'dap'.disconnect({ terminateDebuggee = true })<CR><cmd>lua require'dap'.close()<CR>",
  {}
)

vim.api.nvim_set_keymap("n", "[DAP]h", "<cmd>lua require'dap.ui.widgets'.hover()<CR>", {})

vim.api.nvim_set_keymap("n", "[DAP]U", "<cmd>lua require'dapui'.toggle()<CR>", {})
