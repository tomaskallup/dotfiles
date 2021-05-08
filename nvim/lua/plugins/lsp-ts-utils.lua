return function(client)
    local ts_utils = require("nvim-lsp-ts-utils")

    -- defaults
    ts_utils.setup {
        disable_commands = false,
        debug = false,
        enable_import_on_completion = false,
        import_on_completion_timeout = 5000,
        -- eslint
        eslint_bin = "eslint_d",
        eslint_args = {"-f", "json", "--stdin", "--stdin-filename", "$FILENAME"},
        eslint_enable_disable_comments = true,

        -- experimental settings!
        -- eslint diagnostics
        eslint_enable_diagnostics = false,
        eslint_diagnostics_debounce = 250,
        -- formatting
        enable_formatting = false,
        formatter = "prettier",
        formatter_args = {"--stdin-filepath", "$FILENAME"},
        format_on_save = false,
        no_save_after_format = false,
        -- parentheses completion
        complete_parens = false,
        signature_help_in_parens = false
    }

    -- required to enable ESLint code actions and formatting
    ts_utils.setup_client(client)
end
