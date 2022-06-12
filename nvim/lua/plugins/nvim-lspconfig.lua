local lspconfig = require 'lspconfig'
local null_ls = require 'null-ls'

-- vim.cmd [[autocmd CursorHoldI * silent! lua vim.lsp.buf.signature_help()]]

_G.lsp_formatting = function()
    vim.lsp.buf.format {
        filter = function(clients)
            -- filter out clients that you don't want to use
            return vim.tbl_filter(function(client)
                return client.name ~= 'tsserver'
            end, clients)
        end,
    }
end

-- Setup everything on lsp attach
local on_attach = function(client, bufnr)
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end

    -- require'lsp_signature'.on_attach()

    -- Mappings.
    local opts = { noremap = true, silent = true }
    buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'gh', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<space>rm', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    -- buf_set_keymap('n', '<space>rm',
    -- '<cmd>lua require\'lsp-ui.rename\'.rename()<CR>', opts)
    buf_set_keymap('n', '<space>rr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<space>d', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)

    buf_set_keymap('n', '<space>i', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)

    -- Set some keybinds conditional on server capabilities
    buf_set_keymap('n', '<space>=', '<cmd>call v:lua.lsp_formatting()<CR>', opts)
    if client.server_capabilities.document_range_formatting then
        buf_set_keymap('v', '<space>=', '<cmd>call v:lua.lsp_formatting()<CR>', opts)
    end
end

local handle_lsp = function(opts)
    return opts
end

--local ts_utils_attach = require 'plugins.lsp-ts-utils'

null_ls.setup {
    on_attach = on_attach,
    sources = {
        -- JS/TS formatting
        null_ls.builtins.formatting.prettierd,
        -- Spell check
        --null_ls.builtins.diagnostics.cspell,
        -- Python formatting
        null_ls.builtins.formatting.autopep8,
        -- Lua formatting
        null_ls.builtins.formatting.stylua,
        -- null_ls.builtins.formatting.prettier.with(
        -- {
        -- command = lspconfig.util.root_has_file("node_modules/.bin/prettier") and
        -- "node_modules/.bin/prettier" or "prettier"
        -- })
    },
    root_dir = lspconfig.util.root_pattern('yarn.lock', 'lerna.json', '.git'),
    -- log = {enabled = true, level = "trace"}
}

local capabilities = vim.lsp.protocol.make_client_capabilities()

local capabilitiesWithoutFomatting = vim.lsp.protocol.make_client_capabilities()
capabilitiesWithoutFomatting.textDocument.formatting = false
capabilitiesWithoutFomatting.textDocument.rangeFormatting = false
capabilitiesWithoutFomatting.textDocument.range_formatting = false

-- Tsserver setup
require('typescript').setup {
    disable_commands = false, -- prevent the plugin from creating Vim commands
    debug = false, -- enable debug logging for commands
    server = handle_lsp {
        root_dir = lspconfig.util.root_pattern('yarn.lock', 'lerna.json', '.git'),
        on_attach = function(client, bufnr)
            client.server_capabilities.document_formatting = false
            client.server_capabilities.document_range_formatting = false

            --ts_utils_attach(client)
            on_attach(client, bufnr)
        end,
        settings = { documentFormatting = false },
        init_options = { hostInfo = 'neovim', maxTsServerMemory = '4096' },
        capabilities = capabilitiesWithoutFomatting,
    },
}

local luadev = require('lua-dev').setup {
    lspconfig = {
        cmd = {
            '/usr/bin/lua-language-server',
            '-E',
            '/usr/share/lua-language-server/main.lua',
        },
        on_attach = on_attach,
        capabilities = capabilities,
    },
}
lspconfig.sumneko_lua.setup(handle_lsp(luadev))

-- Vim lsp
lspconfig.vimls.setup(handle_lsp {
    on_attach = on_attach,
    capabilities = capabilities,
})

-- JSON lsp
lspconfig.jsonls.setup(handle_lsp {
    on_attach = on_attach,
    settings = {
        json = {
            -- Schemas https://www.schemastore.org
            schemas = {
                {
                    fileMatch = { 'package.json' },
                    url = 'https://json.schemastore.org/package.json',
                },
                {
                    fileMatch = { 'tsconfig*.json' },
                    url = 'https://json.schemastore.org/tsconfig.json',
                },
                {
                    fileMatch = {
                        '.prettierrc',
                        '.prettierrc.json',
                        'prettier.config.json',
                    },
                    url = 'https://json.schemastore.org/prettierrc.json',
                },
                {
                    fileMatch = { '.eslintrc', '.eslintrc.json' },
                    url = 'https://json.schemastore.org/eslintrc.json',
                },
                {
                    fileMatch = {
                        '.babelrc',
                        '.babelrc.json',
                        'babel.config.json',
                    },
                    url = 'https://json.schemastore.org/babelrc.json',
                },
                {
                    fileMatch = { 'lerna.json' },
                    url = 'https://json.schemastore.org/lerna.json',
                },
                {
                    fileMatch = { 'now.json', 'vercel.json' },
                    url = 'https://json.schemastore.org/now.json',
                },
                {
                    fileMatch = {
                        '.stylelintrc',
                        '.stylelintrc.json',
                        'stylelint.config.json',
                    },
                    url = 'http://json.schemastore.org/stylelintrc.json',
                },
            },
        },
    },
    capabilities = capabilities,
})

lspconfig.eslint.setup(handle_lsp {
    root_dir = lspconfig.util.root_pattern('yarn.lock', 'lerna.json', '.git'),
    on_attach = on_attach,
})

lspconfig.prismals.setup(handle_lsp { on_attach = on_attach })

lspconfig.cssls.setup(handle_lsp {
    capabilities = capabilities,
    root_dir = lspconfig.util.root_pattern('yarn.lock', 'lerna.json', '.git'),
})

lspconfig.pyright.setup(handle_lsp {
    root_dir = lspconfig.util.root_pattern('.venv', '.git'),
    on_attach = on_attach,
    settings = { python = { venvPath = '/home/armeeh/.virtualenvs' } },
})
