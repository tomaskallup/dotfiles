require('dressing').setup({
    select = {
        -- Priority list of preferred vim.select implementations
        backend = {"builtin"},

        -- Options for built-in selector
        builtin = {
            -- These are passed to nvim_open_win
            anchor = "NW",
            relative = "cursor",
            border = "rounded",

            -- Window transparency (0-100)
            winblend = 10,
            -- Change default highlight groups (see :help winhl)
            winhighlight = "",

            -- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
            width = nil,
            max_width = 0.8,
            min_width = 40,
            height = nil,
            max_height = 0.9,
            min_height = 10
        },

        -- Used to override format_item. See :help dressing-format
        format_item_override = {},

        -- see :help dressing_get_config
        get_config = nil
    }
})
