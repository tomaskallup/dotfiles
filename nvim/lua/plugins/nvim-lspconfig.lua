local lspconfig = require("lspconfig")
local null_ls = require("null-ls")

local function format_buffer()
  vim.lsp.buf.format({
    filter = function(client)
      return client.name ~= "tsserver" and client.name ~= "pyright" and client.name ~= "eslint"
    end,
  })
end

-- Setup everything on lsp attach
local on_attach = function(client, bufnr)
  local function buf_set_keymap(mode, key, func)
    vim.keymap.set(mode, key, func, { buffer = bufnr, silent = true })
  end

  -- require'lsp_signature'.on_attach()

  -- Mappings.
  buf_set_keymap("n", "gD", vim.lsp.buf.declaration)
  buf_set_keymap("n", "gd", vim.lsp.buf.definition)
  buf_set_keymap("n", "gh", vim.lsp.buf.hover)
  buf_set_keymap("n", "gi", vim.lsp.buf.implementation)
  buf_set_keymap("n", "<C-k>", vim.lsp.buf.signature_help)
  buf_set_keymap("n", "<space>rm", vim.lsp.buf.rename)
  buf_set_keymap("n", "<space>rr", vim.lsp.buf.references)
  buf_set_keymap("n", "<space>d", vim.diagnostic.open_float)

  buf_set_keymap("n", "<space>i", vim.lsp.buf.code_action)
  buf_set_keymap("n", "[d", vim.diagnostic.goto_prev)
  buf_set_keymap("n", "]d", vim.diagnostic.goto_next)

  vim.keymap.set("n", "<leader>=", format_buffer, { buffer = bufnr })
  if client.server_capabilities.document_range_formatting then
    vim.keymap.set("v", "<leader>=", format_buffer, { buffer = bufnr })
  end
end

local handle_lsp = function(opts)
  return opts
end

--local ts_utils_attach = require 'plugins.lsp-ts-utils'

null_ls.setup({
  on_attach = on_attach,
  sources = {
    -- JS/TS formatting
    null_ls.builtins.formatting.prettierd,
    -- Spell check
    --null_ls.builtins.diagnostics.cspell,
    -- Python formatting
    null_ls.builtins.formatting.autopep8,
    -- Lua formatting
    null_ls.builtins.formatting.stylua,
  },
  root_dir = lspconfig.util.root_pattern("yarn.lock", "lerna.json", ".git"),
  --debug = true,
  log = { enabled = true, level = "trace" },
})

local capabilities = vim.lsp.protocol.make_client_capabilities()

local capabilitiesWithoutFomatting = vim.lsp.protocol.make_client_capabilities()
capabilitiesWithoutFomatting.textDocument.formatting = false
capabilitiesWithoutFomatting.textDocument.rangeFormatting = false
capabilitiesWithoutFomatting.textDocument.range_formatting = false

-- Tsserver setup
require("typescript").setup({
  disable_commands = false, -- prevent the plugin from creating Vim commands
  debug = false, -- enable debug logging for commands
  server = handle_lsp({
    root_dir = lspconfig.util.root_pattern("yarn.lock", "lerna.json", ".git"),
    on_attach = function(client, bufnr)
      client.server_capabilities.document_formatting = false
      client.server_capabilities.document_range_formatting = false

      --ts_utils_attach(client)
      on_attach(client, bufnr)
    end,
    settings = { documentFormatting = false },
    init_options = {
      hostInfo = "neovim",
      maxTsServerMemory = "4096",
      preferences = { quotePreference = "single", allowIncompleteCompletions = false },
    },
    capabilities = capabilitiesWithoutFomatting,
  }),
})

--local luadev = require("lua-dev").setup({
--lspconfig = {
--cmd = {
--"/usr/bin/lua-language-server",
--"-E",
--"/usr/share/lua-language-server/main.lua",
--},
--on_attach = on_attach,
--capabilities = capabilities,
--},
--})
--lspconfig.sumneko_lua.setup(handle_lsp(luadev))

-- Vim lsp
lspconfig.vimls.setup(handle_lsp({
  on_attach = on_attach,
  capabilities = capabilities,
}))

-- JSON lsp
lspconfig.jsonls.setup(handle_lsp({
  on_attach = on_attach,
  settings = {
    json = {
      -- Schemas https://www.schemastore.org
      schemas = {
        {
          fileMatch = { "package.json" },
          url = "https://json.schemastore.org/package.json",
        },
        {
          fileMatch = { "tsconfig*.json" },
          url = "https://json.schemastore.org/tsconfig.json",
        },
        {
          fileMatch = {
            ".prettierrc",
            ".prettierrc.json",
            "prettier.config.json",
          },
          url = "https://json.schemastore.org/prettierrc.json",
        },
        {
          fileMatch = { ".eslintrc", ".eslintrc.json" },
          url = "https://json.schemastore.org/eslintrc.json",
        },
        {
          fileMatch = {
            ".babelrc",
            ".babelrc.json",
            "babel.config.json",
          },
          url = "https://json.schemastore.org/babelrc.json",
        },
        {
          fileMatch = { "lerna.json" },
          url = "https://json.schemastore.org/lerna.json",
        },
        {
          fileMatch = { "now.json", "vercel.json" },
          url = "https://json.schemastore.org/now.json",
        },
        {
          fileMatch = {
            ".stylelintrc",
            ".stylelintrc.json",
            "stylelint.config.json",
          },
          url = "http://json.schemastore.org/stylelintrc.json",
        },
      },
    },
  },
  capabilities = capabilities,
}))

lspconfig.eslint.setup(handle_lsp({
  root_dir = lspconfig.util.root_pattern("yarn.lock", "lerna.json", ".git"),
  on_attach = on_attach,
}))

lspconfig.prismals.setup(handle_lsp({ on_attach = on_attach }))

lspconfig.cssls.setup(handle_lsp({
  capabilities = capabilities,
  root_dir = lspconfig.util.root_pattern("yarn.lock", "lerna.json", ".git"),
}))

lspconfig.pyright.setup(handle_lsp({
  root_dir = lspconfig.util.root_pattern(".venv", ".git"),
  on_attach = on_attach,
  settings = { python = { venvPath = "/home/armeeh/.virtualenvs" } },
}))
