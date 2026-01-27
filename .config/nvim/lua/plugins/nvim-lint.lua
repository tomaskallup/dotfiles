local root_patterns_by_ft = {
  typescript = {
    '.eslintrc',
    '.eslintrc.cjs',
    '.eslintrc.js',
    '.eslintrc.json',
    '.eslintrc.yaml',
    '.eslintrc.yml',
    'package.json',
    --- Eslint v9
    'eslint.config.cjs',
    'eslint.config.mjs',
    'eslint.config.js',
  },
  typescriptreact = {
    '.eslintrc',
    '.eslintrc.cjs',
    '.eslintrc.js',
    '.eslintrc.json',
    '.eslintrc.yaml',
    '.eslintrc.yml',
    'package.json',
    --- Eslint v9
    'eslint.config.cjs',
    'eslint.config.mjs',
    'eslint.config.js',
  },
}
---Get cwd for linters specified by root_patterns_by_ft[filetype]
local function get_linters_cwd()
  local root_patterns = root_patterns_by_ft[vim.bo.filetype]
  if root_patterns then
    local root_path = root_patterns and vim.fs.root(0, root_patterns)

    return root_path
  end

  return nil
end

return {
  'mfussenegger/nvim-lint',
  enabled = true,
  config = function()
    require('lint').linters_by_ft = {
      typescript = { 'eslint_d' },
      javascript = { 'eslint_d' },
      typescriptreact = { 'eslint_d' },
    }

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
      callback = function()
        require('lint').try_lint(nil, { cwd = get_linters_cwd() })
      end,
    })
  end,
  lazy = false,
}
