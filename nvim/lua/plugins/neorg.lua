require('neorg').setup {
    -- Tell Neorg what modules to load
    load = {
        ["core.defaults"] = {}, -- Load all the default modules
        ["core.norg.concealer"] = {}, -- Allows for use of icons
        ["core.norg.dirman"] = { -- Manage your directories with Neorg
            config = {workspaces = {default = "~/neorg"}}
        },
        ["core.neorgcmd"]= {}, -- Load the :Neorg command
    }
}
