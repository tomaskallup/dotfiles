local lspconfig = require 'lspconfig'
local configs = require("lspconfig/configs") -- Make sure this is a slash (as theres some metamagic happening behind the scenes)

-- vim.cmd [[autocmd CursorHoldI * silent! lua vim.lsp.buf.signature_help()]]

-- Setup everything on lsp attach
local on_attach = function(client, bufnr)
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end

    require'lsp_signature'.on_attach()

    -- Mappings.
    local opts = {noremap = true, silent = true}
    buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'gh', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>',
                   opts)
    --buf_set_keymap('n', '<space>rm', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<space>rm', '<cmd>lua require\'lsp-ui.rename\'.rename()<CR>', opts)
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
    if client.resolved_capabilities.document_formatting then
        buf_set_keymap("n", "<space>=", "<cmd>lua vim.lsp.buf.formatting()<CR>",
                       opts)
    elseif client.resolved_capabilities.document_range_formatting then
        buf_set_keymap("v", "<space>=", "<cmd>lua vim.lsp.buf.formatting()<CR>",
                       opts)
    end
end

local ts_utils_attach = require 'plugins.lsp-ts-utils'

-- Tsserver setup
lspconfig.tsserver.setup {
    root_dir = lspconfig.util.root_pattern("yarn.lock", "lerna.json", ".git"),
    on_attach = function(client, bufnr)
        -- This makes sure tsserver is not used for formatting (I prefer prettier)
        client.resolved_capabilities.document_formatting = false

        ts_utils_attach(client)
        on_attach(client, bufnr)
    end,
    settings = {documentFormatting = false}
}

local luadev = require('lua-dev').setup({
    lspconfig = {
        cmd = {
            "/usr/bin/lua-language-server", "-E",
            "/usr/share/lua-language-server/main.lua"
        },
        on_attach = on_attach
    }
})
lspconfig.sumneko_lua.setup(luadev)

-- Vim lsp
lspconfig.vimls.setup {on_attach = on_attach}

-- JSON lsp
lspconfig.jsonls.setup {
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
    }
}

-- Formatting via efm
local prettier = require "efm/prettier"
local eslint = require "efm/eslint"
local luafmt = require "efm/luafmt"
local rustfmt = require "efm/rustfmt"
-- local autopep = require "efm/autopep8"

local languages = {
    lua = {luafmt},
    typescript = {prettier, eslint},
    javascript = {prettier, eslint},
    typescriptreact = {prettier, eslint},
    javascriptreact = {prettier, eslint},
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

lspconfig.rls.setup {
    root_dir = lspconfig.util.root_pattern("Cargo.toml", ".git"),
    settings = {
        rust = {
            unstable_features = true,
            build_on_save = false,
            all_features = true
        }
    },
    on_attach = on_attach
}

lspconfig.pyls.setup {
    root_dir = lspconfig.util.root_pattern(".git", ".venv", "requirements.txt"),
    on_attach = on_attach
}

if not lspconfig.prisma then
    configs.prisma = {
        default_config = {
            cmd = {"prisma-language-server", "--stdio"},
            filetypes = {"prisma"},
            root_dir = lspconfig.util.root_pattern("prisma", ".git"),
            settings = {}
        }
    }
end
lspconfig.prisma.setup {on_attach = on_attach}

-- Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

lspconfig.cssls.setup {
    capabilities = capabilities,
    root_dir = lspconfig.util.root_pattern("yarn.lock", "lerna.json", ".git")
}
