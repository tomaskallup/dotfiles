return function(client)
    local ts_utils = require("nvim-lsp-ts-utils")

    -- defaults
    ts_utils.setup {
        debug = false,
        disable_commands = false,
        enable_import_on_completion = false,

        -- import all
        import_all_timeout = 5000, -- ms
        import_all_priorities = {
            buffers = 4, -- loaded buffer names
            buffer_content = 3, -- loaded buffer content
            local_files = 2, -- git files or files with relative path markers
            same_file = 1 -- add to existing import statement
        },
        import_all_scan_buffers = 100,
        import_all_select_source = false,

        -- eslint
        eslint_enable_code_actions = false,
        eslint_enable_disable_comments = false,
        eslint_bin = "eslint_d",
        eslint_config_fallback = nil,
        eslint_enable_diagnostics = false,
        eslint_show_rule_id = true,

        -- formatting
        enable_formatting = true,
        formatter = "prettierd",
        formatter_config_fallback = nil,

        -- update imports on file move
        update_imports_on_move = true,
        require_confirmation_on_move = true,
        watch_dir = '.',

        -- filter diagnostics
        filter_out_diagnostics_by_severity = {},
        filter_out_diagnostics_by_code = {}
    }

    -- required to enable ESLint code actions and formatting
    ts_utils.setup_client(client)
end
