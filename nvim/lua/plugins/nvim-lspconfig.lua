local lspconfig = require 'lspconfig'
local configs = require("lspconfig/configs") -- Make sure this is a slash (as theres some metamagic happening behind the scenes)
local null_ls = require("null-ls")

-- vim.cmd [[autocmd CursorHoldI * silent! lua vim.lsp.buf.signature_help()]]

-- Setup everything on lsp attach
local on_attach = function(client, bufnr)
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end

    -- require'lsp_signature'.on_attach()

    -- Mappings.
    local opts = {noremap = true, silent = true}
    buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'gh', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>',
                   opts)
    -- buf_set_keymap('n', '<space>rm', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<space>rm',
                   '<cmd>lua require\'lsp-ui.rename\'.rename()<CR>', opts)
    buf_set_keymap('n', '<space>rr', '<cmd>lua vim.lsp.buf.references()<CR>',
                   opts)
    buf_set_keymap('n', '<space>d',
                   '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>',
                   opts)

    buf_set_keymap('n', '<space>i', '<cmd>lua vim.lsp.buf.code_action()<CR>',
                   opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>',
                   opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>',
                   opts)

    -- Set some keybinds conditional on server capabilities
    buf_set_keymap("n", "<space>=", "<cmd>lua vim.lsp.buf.formatting()<CR>",
                   opts)
    if client.resolved_capabilities.document_range_formatting then
        buf_set_keymap("v", "<space>=", "<cmd>lua vim.lsp.buf.formatting()<CR>",
                       opts)
    end
end

local handle_lsp = function(opts) return opts end

local ts_utils_attach = require 'plugins.lsp-ts-utils'

null_ls.config {debug = false}

lspconfig['null-ls'].setup(handle_lsp({}))

local capabilities = vim.lsp.protocol.make_client_capabilities()

-- Tsserver setup
lspconfig.tsserver.setup(handle_lsp({
    root_dir = lspconfig.util.root_pattern("yarn.lock", "lerna.json", ".git"),
    on_attach = function(client, bufnr)
        -- This makes sure tsserver is not used for formatting (I prefer prettier)
        client.resolved_capabilities.document_formatting = false

        ts_utils_attach(client)
        on_attach(client, bufnr)
    end,
    settings = {documentFormatting = false},
    init_options = {hostInfo = "neovim"},
    capabilities = capabilities
}))

local luadev = require('lua-dev').setup({
    lspconfig = {
        cmd = {
            "/usr/bin/lua-language-server", "-E",
            "/usr/share/lua-language-server/main.lua"
        },
        on_attach = on_attach,
        capabilities = capabilities
    }
})
lspconfig.sumneko_lua.setup(handle_lsp(luadev))

-- Vim lsp
lspconfig.vimls.setup(handle_lsp({
    on_attach = on_attach,
    capabilities = capabilities
}))

-- JSON lsp
lspconfig.jsonls.setup(handle_lsp({
    on_attach = on_attach,
    settings = {
        json = {
            -- Schemas https://www.schemastore.org
            schemas = {
                {
                    fileMatch = {"package.json"},
                    url = "https://json.schemastore.org/package.json"
                }, {
                    fileMatch = {"tsconfig*.json"},
                    url = "https://json.schemastore.org/tsconfig.json"
                }, {
                    fileMatch = {
                        ".prettierrc", ".prettierrc.json",
                        "prettier.config.json"
                    },
                    url = "https://json.schemastore.org/prettierrc.json"
                }, {
                    fileMatch = {".eslintrc", ".eslintrc.json"},
                    url = "https://json.schemastore.org/eslintrc.json"
                }, {
                    fileMatch = {
                        ".babelrc", ".babelrc.json", "babel.config.json"
                    },
                    url = "https://json.schemastore.org/babelrc.json"
                },
                {
                    fileMatch = {"lerna.json"},
                    url = "https://json.schemastore.org/lerna.json"
                }, {
                    fileMatch = {"now.json", "vercel.json"},
                    url = "https://json.schemastore.org/now.json"
                }, {
                    fileMatch = {
                        ".stylelintrc", ".stylelintrc.json",
                        "stylelint.config.json"
                    },
                    url = "http://json.schemastore.org/stylelintrc.json"
                }
            }
        }
    },
    capabilities = capabilities
}))

-- Formatting via efm
local prettier = require "efm/prettier"
-- local eslint = require "efm/eslint"
local luafmt = require "efm/luafmt"
local rustfmt = require "efm/rustfmt"
-- local autopep = require "efm/autopep8"

local languages = {
    lua = {luafmt},
    -- typescript = {prettier, eslint},
    -- javascript = {prettier, eslint},
    -- typescriptreact = {prettier, eslint},
    -- javascriptreact = {prettier, eslint},
    yaml = {prettier},
    json = {prettier},
    html = {prettier},
    scss = {prettier},
    css = {prettier},
    markdown = {prettier},
    rust = {rustfmt}
    -- python = {autopep}
}

lspconfig.efm.setup {
    root_dir = lspconfig.util.root_pattern("yarn.lock", "lerna.json", ".git"),
    filetypes = vim.tbl_keys(languages),
    init_options = {documentFormatting = true, codeAction = true},
    settings = {languages = languages, log_level = 1, log_file = '~/efm.log'},
    on_attach = on_attach
}

lspconfig.eslint.setup(handle_lsp({
    root_dir = lspconfig.util.root_pattern("yarn.lock", "lerna.json", ".git"),
    on_attach = on_attach
}))

lspconfig.prismals.setup(handle_lsp({on_attach = on_attach}))

lspconfig.cssls.setup(handle_lsp({
    capabilities = capabilities,
    root_dir = lspconfig.util.root_pattern("yarn.lock", "lerna.json", ".git")
}))
