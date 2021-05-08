local lspconfig = require 'lspconfig'
local configs = require("lspconfig/configs") -- Make sure this is a slash (as theres some metamagic happening behind the scenes)

-- Use ehanced LSP stuff
vim.lsp.handlers['textDocument/codeAction'] =
    require'lsputil.codeAction'.code_action_handler
vim.lsp.handlers['textDocument/references'] =
    require'lsputil.locations'.references_handler
vim.lsp.handlers['textDocument/definition'] =
    require'lsputil.locations'.definition_handler
vim.lsp.handlers['textDocument/declaration'] =
    require'lsputil.locations'.declaration_handler
vim.lsp.handlers['textDocument/typeDefinition'] =
    require'lsputil.locations'.typeDefinition_handler
vim.lsp.handlers['textDocument/implementation'] =
    require'lsputil.locations'.implementation_handler
vim.lsp.handlers['textDocument/documentSymbol'] =
    require'lsputil.symbols'.document_handler
vim.lsp.handlers['workspace/symbol'] =
    require'lsputil.symbols'.workspace_handler
vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics,
                 {underline = true, virtual_text = false})

vim.cmd [[autocmd CursorHoldI * silent! lua vim.lsp.buf.signature_help()]]

-- Setup completion labels
require('lspkind').init({with_text = true})

-- Setup everything on lsp attach
local on_attach = function(client, bufnr)
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end

    -- Mappings.
    local opts = {noremap = true, silent = true}
    buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'gh', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>',
                   opts)
    buf_set_keymap('n', '<space>rm', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
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

local util = require 'lspconfig/util'
lspconfig.sumneko_lua.setup {
    cmd = {
        "/usr/bin/lua-language-server", "-E",
        "/usr/share/lua-language-server/main.lua"
    },
    on_attach = on_attach,
    root_dir = function(fname)
        return util.find_git_ancestor(fname) or util.path.dirname(fname)
    end,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                -- Setup your lua path
                path = vim.split(package.path, ';')
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {'vim'}
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = {
                    [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                    [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true
                }
            }
        }
    }
}

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
--local autopep = require "efm/autopep8"

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
    rust = {rustfmt},
    --python = {autopep}
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

if not lspconfig.teal then
    configs.teal = {
        default_config = {
            cmd = {
                "teal-language-server"
                -- "logging=on", use this to enable logging in /tmp/teal-language-server.log
            },
            filetypes = {"teal"},
            root_dir = lspconfig.util.root_pattern("tlconfig.lua", ".git"),
            settings = {}
        }
    }
end
lspconfig.teal.setup {}

if not lspconfig.tailwindcss then
    configs.tailwindcss = {
        default_config = {
            cmd = {"tailwindcss-language-server", "--stdio"},
            filetypes = {
                -- html
                'aspnetcorerazor', 'blade', 'django-html', 'edge', 'ejs',
                'eruby', 'gohtml', 'haml', 'handlebars', 'hbs', 'html',
                'html-eex', 'jade', 'leaf', 'liquid', 'markdown', 'mdx',
                'mustache', 'njk', 'nunjucks', 'php', 'razor', 'slim', 'twig', -- css
                'css', 'less', 'postcss', 'sass', 'scss', 'stylus', 'sugarss',
                -- js
                'javascript', 'javascriptreact', 'reason', 'rescript',
                'typescript', 'typescriptreact', -- mixed
                'vue', 'svelte'
            },
            init_options = {userLanguages = {eruby = "html"}},
            root_dir = function(fname)
                return util.root_pattern('tailwind.config.js',
                                         'tailwind.config.ts')(fname) or
                           util.root_pattern('postcss.config.js',
                                             'postcss.config.ts')(fname) or
                           util.find_package_json_ancestor(fname) or
                           util.find_node_modules_ancestor(fname) or
                           util.find_git_ancestor(fname)
            end,
            handlers = {
                -- 1. tailwindcss lang server uses this instead of workspace/configuration
                -- 2. tailwindcss lang server waits for this repsonse before providing hover
                ["tailwindcss/getConfiguration"] = function(err, _, params,
                                                            client_id, bufnr, _)
                    -- params = { _id, languageId? }

                    local client = vim.lsp.get_client_by_id(client_id)
                    if not client then return end
                    if err then error(vim.inspect(err)) end

                    local configuration =
                        vim.lsp.util.lookup_section(client.config.settings,
                                                    "tailwindCSS") or {}
                    configuration._id = params._id
                    configuration.tabSize =
                        vim.lsp.util.get_effective_tabstop(bufnr) -- used for the CSS preview
                    vim.lsp.buf_notify(bufnr,
                                       "tailwindcss/getConfigurationResponse",
                                       configuration)
                end
            }
        }
    }
end
lspconfig.tailwindcss.setup {}
