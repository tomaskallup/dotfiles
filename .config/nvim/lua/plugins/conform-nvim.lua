return {
  'stevearc/conform.nvim',
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      javascript = { "eslint_d", stop_after_first = true },
      typescript = { "eslint_d", stop_after_first = true },
      typescriptreact = { "eslint_d", stop_after_first = true },
    },
    default_format_opts = {
      lsp_format = "fallback",
    },
  },
  keys = {
    {
      '<leader>=',
      function()
        require("conform").format()
      end,
      desc = 'Format buffer'
    },
  },
}
