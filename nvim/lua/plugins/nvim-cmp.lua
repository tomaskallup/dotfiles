local cmp = require 'cmp'
local luasnip = require 'luasnip'

local formatting = {}

if packer_plugins['lspkind-nvim'] then
    formatting['format'] = require 'plugins.lspkind-nvim'
end

cmp.setup({
    snippet = {
        expand = function(args) require('luasnip').lsp_expand(args.body) end
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-y>'] = cmp.mapping.confirm({
            select = true,
            behavior = cmp.ConfirmBehavior.Replace
        }),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end,
        ['<S-Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end
    }),
    sources = {
        {name = 'nvim_lsp'}, {name = 'luasnip'}, {name = 'buffer'},
        {name = 'path'}, {name = 'nvim_lsp_signature_help'},
        --{name = 'copilot'}
        {name = 'cmp_tabnine'}
    },
    formatting = formatting
})

require 'plugins.nvim-cmp-tabnine'

cmp.setup.cmdline('/', {sources = {{name = 'buffer'}}})
