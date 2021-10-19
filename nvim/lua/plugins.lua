local packer = require 'packer'
local use = packer.use
return packer.startup(function()
    use 'wbthomason/packer.nvim'

    -- =======================================--
    --     Movement & editation plugins      --
    -- =======================================--
    use 'tpope/vim-repeat' -- Use `.` to repeat surround and other commands
    use 'tpope/vim-surround' -- (o_o) -> ca([ -> [o_o]
    use 'scrooloose/nerdcommenter' -- Comments
    use 'jiangmiao/auto-pairs' -- Matching parens, quotes etc.
    use { -- Add matching HTML tag
        'windwp/nvim-ts-autotag',
        config = function() require'nvim-ts-autotag'.setup() end
    }

    -- =======================================--
    --               UI plugins              --
    -- =======================================--
    use { -- Nice bar
        'hoob3rt/lualine.nvim',
        config = function() require 'plugins.lualine' end
    }
    -- use 'tomaskallup/arcolors' -- Colorscheme
    use { -- Colorscheme
        'marko-cerovac/material.nvim',
        branch = 'main',
        config = function()
            vim.g.material_style = 'deep ocean'
            require'material'.setup({
                contrast = true,
                borders = true,

                contrast_windows = {
                    "terminal", -- Darker terminal background
                    "term", -- Darker terminal background
                    "packer", -- Darker packer background
                    "qf" -- Darker qf list background
                },

                disable = {term_colors = true},

                custom_highlights = {
                    DiffAdd = {bg = '#002500'},
                    DiffDelete = {bg = '#250000'}
                }
            })
            vim.cmd [[colorscheme material]]
        end
    }
    use 'kyazdani42/nvim-web-devicons' -- Icons
    use { -- For icons in completion
        'onsails/lspkind-nvim',
        config = function() require 'plugins.lspkind-nvim' end
    }
    use { -- Show git changes in signcolumn
        'lewis6991/gitsigns.nvim',
        branch = 'main',
        config = function() require 'plugins.gitsigns' end
    }
    use 'kevinhwang91/nvim-bqf' -- Enhanced quickfix

    -- =======================================--
    --             Syntax plugins            --
    -- =======================================--
    use { -- Ensure ansi color codes are handled
        'powerman/vim-plugin-AnsiEsc',
        config = function() vim.g.no_cecutil_maps = 1 end
    }
    use { -- Unified highlight for all filetypes
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function() require 'plugins.treesitter' end
    }
    use 'nvim-treesitter/playground'
    use {'aklt/plantuml-syntax'} -- Plant uml syntax
    use { -- Show colors in neovim (Red, Green, Blue, etc.)
        'norcalli/nvim-colorizer.lua',
        config = function() require'colorizer'.setup() end
    }
    use 'pantharshit00/vim-prisma'
    use 'chr4/nginx.vim'

    -- =======================================--
    --      IDE (completion, debugging)      --
    -- =======================================--
    use { -- Debugging, not yet ready
        'mfussenegger/nvim-dap',
        config = function() require 'plugins.nvim-dap' end
    }
    use { -- UI for DAP
        'rcarriga/nvim-dap-ui',
        config = function() require'dapui'.setup() end
    }
    use 'plytophogy/vim-virtualenv' -- Virtual env

    use {
        'airblade/vim-rooter',
        config = function() -- Automatically set pwd when opening a file
            vim.g.rooter_patterns = {'.venv', '.git/', '.nvim/'}
        end
    }

    use { -- LSP configurations for builtin LSP client
        'neovim/nvim-lspconfig',
        config = function() require 'plugins.nvim-lspconfig' end
    }
    use 'L3MON4D3/LuaSnip' -- Snippets plugin
    use { -- Completion
        'hrsh7th/nvim-cmp',
        config = function() require 'plugins.nvim-cmp' end,
        requires = {
            'hrsh7th/cmp-buffer', 'hrsh7th/cmp-nvim-lsp',
            'saadparwaiz1/cmp_luasnip'
        }
    }
    use { -- Typescript LSP enhancements (configured in LSP)
        'jose-elias-alvarez/nvim-lsp-ts-utils',
        branch = 'main'
    }
    use { -- Support for non-LSP stuff via LSP (configured in LSP)
        'jose-elias-alvarez/null-ls.nvim',
        branch = 'main'
    }
    use { -- Show signature help when typing
        'ray-x/lsp_signature.nvim'
    }
    use { -- Simple lsp enhancements
        'nvim-lua/lsp_extensions.nvim',
        config = function() require 'plugins.lsp_extensions' end
    }

    -- =======================================--
    --           Workflow plugins            --
    -- =======================================--
    use {
        'kyazdani42/nvim-tree.lua',
        config = function() require'plugins.nvim-tree' end
    }

    use { -- Better than fzf, amazing search
        'nvim-telescope/telescope.nvim',
        requires = {'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim'},
        config = function() require 'plugins.telescope' end
    }
    use { -- Dap integration for telescope
        'nvim-telescope/telescope-dap.nvim'
    }
    use {
        'nvim-telescope/telescope-project.nvim',
        requires = {'nvim-telescope/telescope.nvim'}
    }
    use { -- Better sorting in telescope
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make'
    }

    use 'moll/vim-bbye' -- Better buffer management

    -- =======================================--
    --    Experimental (testing plugins)     --
    -- =======================================--
    use {'folke/lua-dev.nvim'}

    use {
        'vhyrro/neorg',
        config = function() require 'plugins.neorg' end,
        requires = "nvim-lua/plenary.nvim"
    }

    use { -- Terminal enhancements
        'akinsho/toggleterm.nvim',
        config = function() require 'plugins.toggleterm' end
    }

    use {
        'theHamsta/nvim-dap-virtual-text',
        config = function() vim.g.dap_virtual_text = true end
    }

    use '~/Pkg/nvim-lsp-ui'
end)
