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
        config = function()
            require('nvim-ts-autotag').setup()
        end,
        ft = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
    }

    -- =======================================--
    --               UI plugins              --
    -- =======================================--
    use { -- Nice bar
        'hoob3rt/lualine.nvim',
        config = function()
            require 'plugins.nvim-lualine'
        end,
    }
    -- use 'tomaskallup/arcolors' -- Colorscheme
    use { -- Colorscheme
        'marko-cerovac/material.nvim',
        branch = 'main',
        config = function()
            vim.g.material_style = 'deep ocean'
            require('material').setup {
                contrast = {
                    sidebars = true, -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
                    floating_windows = true, -- Enable contrast for floating windows
                    line_numbers = true, -- Enable contrast background for line numbers
                    sign_column = true, -- Enable contrast background the sign column
                    cursor_line = false, -- Enable darker background for the cursor line
                    non_current_windows = false, -- Enable darker background for non-current windows
                    popup_menu = true, -- Enable lighter background for the popup menu
                },

                contrast_filetypes = {
                    'terminal', -- Darker terminal background
                    'term', -- Darker terminal background
                    'packer', -- Darker packer background
                    'qf', -- Darker qf list background
                },

                disable = {
                    term_colors = true,
                    borders = false,
                    colored_cursor = true,
                },

                custom_highlights = {
                    DiffAdd = { bg = '#002500' },
                    DiffDelete = { bg = '#250000' },
                    DiffChange = { bg = 'None' },
                    DiffText = { bg = 'None', fg = '#999900' },
                    NvimTreeNormal = { fg = '#A6ACCD' },
                    NeomakeVirtualtextErrorDefault = { fg = '#AF111A' },
                },
            }
            vim.cmd [[colorscheme material]]
        end,
    }
    use 'kyazdani42/nvim-web-devicons' -- Icons
    use { -- For icons in completion
        'onsails/lspkind-nvim',
        -- Config is done in cmp configuration
        -- config = function() require 'plugins.lspkind-nvim' end
    }
    use { -- Show git changes in signcolumn
        'lewis6991/gitsigns.nvim',
        branch = 'main',
        config = function()
            require 'plugins.gitsigns'
        end,
    }
    use 'kevinhwang91/nvim-bqf' -- Enhanced quickfix

    use { -- Terminal enhancements
        'akinsho/toggleterm.nvim',
        branch = 'main',
        config = function()
            require 'plugins.toggleterm'
        end,
    }

    use { -- Overall UI enhancements
        'stevearc/dressing.nvim',
        config = function()
            require 'plugins.dressing'
        end,
    }

    use { -- Notifications
        'rcarriga/nvim-notify',
        config = function()
            vim.notify = require 'notify'
        end,
    }

    -- =======================================--
    --             Syntax plugins            --
    -- =======================================--
    use { -- Ensure ansi color codes are handled
        'powerman/vim-plugin-AnsiEsc',
        config = function()
            vim.g.no_cecutil_maps = 1
        end,
    }
    use { -- Unified highlight for all filetypes
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function()
            require 'plugins.treesitter'
        end,
    }
    -- use 'nvim-treesitter/playground'
    use { 'aklt/plantuml-syntax' } -- Plant uml syntax
    use { -- Show colors in neovim (Red, Green, Blue, etc.)
        'norcalli/nvim-colorizer.lua',
        config = function()
            require('colorizer').setup()
        end,
    }
    use 'pantharshit00/vim-prisma'
    use 'chr4/nginx.vim'

    -- =======================================--
    --      IDE (completion, debugging)      --
    -- =======================================--
    use { -- Debugging, not yet ready
        'mfussenegger/nvim-dap',
        config = function()
            require 'plugins.nvim-dap'
        end,
    }
    use { -- UI for DAP
        'rcarriga/nvim-dap-ui',
        config = function()
            require('dapui').setup()
        end,
    }
    use 'plytophogy/vim-virtualenv' -- Virtual env

    use {
        'airblade/vim-rooter',
        config = function() -- Automatically set pwd when opening a file
            vim.g.rooter_patterns = { '.venv', '.git/', '.nvim/' }
        end,
    }

    use { -- LSP configurations for builtin LSP client
        'neovim/nvim-lspconfig',
        config = function()
            require 'plugins.nvim-lspconfig'
        end,
    }
    use 'L3MON4D3/LuaSnip' -- Snippets plugin
    use { -- Completion
        'hrsh7th/nvim-cmp',
        config = function()
            require 'plugins.nvim-cmp'
        end,
        requires = {
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-path',
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-nvim-lsp-signature-help',
            'tzachar/cmp-tabnine',
            'hrsh7th/cmp-copilot',
        },
    }
    --use { -- Typescript LSP enhancements (configured in LSP)
    --'jose-elias-alvarez/nvim-lsp-ts-utils',
    --branch = 'main'
    --}
    use { -- Typescript LSP enhancements (configured in LSP)
        'jose-elias-alvarez/typescript.nvim',
        branch = 'main',
    }
    use { -- Support for non-LSP stuff via LSP (configured in LSP)
        'jose-elias-alvarez/null-ls.nvim',
        branch = 'main',
    }
    use { -- Show signature help when typing
        'ray-x/lsp_signature.nvim',
    }
    -- use { -- Simple lsp enhancements
    -- 'nvim-lua/lsp_extensions.nvim',
    -- config = function() require 'plugins.lsp_extensions' end
    -- }

    -- =======================================--
    --           Workflow plugins            --
    -- =======================================--
    use {
        'kyazdani42/nvim-tree.lua',
        config = function()
            require 'plugins.nvim-tree'
        end,
    }

    use { -- Better than fzf, amazing search
        'nvim-telescope/telescope.nvim',
        requires = { 'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim' },
        config = function()
            require 'plugins.telescope'
        end,
    }
    use { -- Dap integration for telescope
        'nvim-telescope/telescope-dap.nvim',
    }
    use { -- Better sorting in telescope
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make',
    }
    use { -- Telescope fie browser
        'nvim-telescope/telescope-file-browser.nvim',
    }

    use { 'moll/vim-bbye', cmd = 'Bdelete' } -- Better buffer management

    -- =======================================--
    --    Experimental (testing plugins)     --
    -- =======================================--
    use { 'folke/lua-dev.nvim' }

    use {
        'theHamsta/nvim-dap-virtual-text',
        config = function()
            require('nvim-dap-virtual-text').setup()
        end,
    }

    use {
        'beauwilliams/focus.nvim',
        config = function()
            require 'plugins.focus'
        end,
        event = 'VimEnter',
    }

    -- use {
    -- 'simrat39/rust-tools.nvim',
    -- config = function() require('rust-tools').setup({}) end
    -- }

    use {
        'neomake/neomake',
        config = function()
            require 'plugins.neomake'
        end,
        cmd = 'Neomake',
    }

    use {
        'iamcco/markdown-preview.nvim',
        run = 'cd app && yarn install',
        cmd = 'MarkdownPreview',
        ft = { 'markdown' },
    }

    -- use 'github/copilot.vim'

    use {
        'pwntester/octo.nvim',
        config = function()
            require('octo').setup()
        end,
    }
end)
