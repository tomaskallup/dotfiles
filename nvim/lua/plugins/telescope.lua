require('telescope').setup {
    defaults = {
        vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
        },
        prompt_prefix = '> ',
        selection_caret = '> ',
        entry_prefix = '  ',
        initial_mode = 'insert',
        selection_strategy = 'reset',
        sorting_strategy = 'descending',
        layout_strategy = 'horizontal',
        layout_config = {
            horizontal = { mirror = false },
            vertical = { mirror = false },
            prompt_position = 'bottom',
        },
        file_sorter = require('telescope.sorters').get_fuzzy_file,
        file_ignore_patterns = {},
        generic_sorter = require('telescope.sorters').get_generic_fuzzy_sorter,
        winblend = 0,
        border = {},
        borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
        color_devicons = true,
        use_less = true,
        set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
        file_previewer = require('telescope.previewers').vim_buffer_cat.new,
        grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
        qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,

        -- Developer configurations: Not meant for general override
        buffer_previewer_maker = require('telescope.previewers').buffer_previewer_maker,
    },
    pickers = { buffers = { mappings = { i = { ['<c-d>'] = 'delete_buffer' } } } },
    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
        },
    },
}

require('telescope').load_extension 'dap'
require('telescope').load_extension 'fzf'
require('telescope').load_extension 'file_browser'

vim.api.nvim_set_keymap('n', '<Leader>f', '[tele]', {})
vim.api.nvim_set_keymap('n', '[tele]f', '<cmd>Telescope find_files theme=get_dropdown<CR>', {})
vim.api.nvim_set_keymap('n', '[tele]g', '<cmd>Telescope live_grep theme=get_dropdown<CR>', {})
vim.api.nvim_set_keymap(
    'n',
    '[tele]G',
    '<cmd>Telescope live_grep theme=get_dropdown vimgrep_arguments=rg,--no-heading,--with-filename,--line-number,--column<CR>',
    {}
)
vim.api.nvim_set_keymap('n', '[tele]b', '<cmd>Telescope buffers theme=get_dropdown<CR>', {})
vim.api.nvim_set_keymap('n', '[tele]r', '<cmd>Telescope lsp_references theme=get_dropdown<CR>', {})
vim.api.nvim_set_keymap('n', '[tele]q', '<cmd>Telescope quickfix theme=get_dropdown<CR>', {})
vim.api.nvim_set_keymap('n', '[tele]d', '<cmd>Telescope lsp_definitions theme=get_dropdown<CR>', {})
vim.api.nvim_set_keymap(
    'n',
    '[tele]n',
    '<cmd>Telescope find_files theme=get_dropdown cwd=~/Documents/Notes/markdown<CR>',
    {}
)
vim.api.nvim_set_keymap('n', '[tele]B', '<cmd>Telescope file_browser theme=get_dropdown<CR>', {})

-- Grep in specific directory (defaults to current buffer dir)
vim.keymap.set('n', '[tele]G', function()
    vim.ui.input({ prompt = 'Enter directory: ', completion = 'dir', default = vim.fn.expand '%:h' }, function(input)
        if input ~= nil then
            require('telescope.builtin').live_grep { search_dirs = { input } }
        end
    end)
end, {})

-- Find files in specific directory (defaults to current buffer dir)
vim.keymap.set('n', '[tele]F', function()
    vim.ui.input({ prompt = 'Enter directory: ', completion = 'dir', default = vim.fn.expand '%:h' }, function(input)
        if input ~= nil then
            require('telescope.builtin').find_files { cwd = input }
        end
    end)
end, {})
