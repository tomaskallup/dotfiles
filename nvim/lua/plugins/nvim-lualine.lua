local lualine = require('lualine')

lualine.setup {
    options = {
        theme = 'material-nvim',
        icons_enabled = true,
        component_separators = {'', ''},
        section_separators = {'', ''},
        disabled_filetypes = {},
        globalstatus = true
    },
    --extensions = {'nvim-tree'},

    sections = {
        lualine_a = {'mode'},
        --lualine_b = {'branch', 'nvim_diagnostics'},
        lualine_c = {'filename'},
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_z = {'location'}
    },

    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
    },

    tabline = {}
}
