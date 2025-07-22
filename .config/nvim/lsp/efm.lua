local eslintd = require('efmls-configs.linters.eslint_d')
local eslintd_format = require('efmls-configs.formatters.eslint_d')
-- local eslint = require('efmls-configs.linters.eslint')
-- local eslint_format = require('efmls-configs.formatters.eslint')
local prettier = require('efmls-configs.formatters.prettier_d')
local stylua = require('efmls-configs.formatters.stylua')
local jq = require('efmls-configs.formatters.jq')

eslintd_format.rootMarkers = eslintd.rootMarkers

local languages = {
  typescript = { eslintd, eslintd_format },
  typescriptreact = { eslintd, eslintd_format },
  javascript = { eslintd, eslintd_format },
  lua = { stylua },
  json = { jq },
  css = { prettier },
  scss = { prettier },
  yaml = { prettier },
  html = { prettier },
  nix = {
    { formatCommand = 'nixfmt', formatStdin = true },
  },
}

return {
  cmd = { 'efm-langserver', '-logfile', '/home/armeeh/efm.log' },
  single_file_support = true,
  filetypes = vim.tbl_keys(languages),
  settings = {
    languages = languages,
  },
  init_options = {
    documentFormatting = true,
    documentRangeFormatting = true,
  },
}
