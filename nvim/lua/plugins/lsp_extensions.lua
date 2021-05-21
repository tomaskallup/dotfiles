vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(require('lsp_extensions.workspace.diagnostic').handler,
                 {signs = {severity_limit = "Error"}})
