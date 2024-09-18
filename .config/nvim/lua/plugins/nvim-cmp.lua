return {
  'hrsh7th/nvim-cmp',
  lazy = false,
  -- these dependencies will only be loaded when cmp loads
  -- dependencies are always lazy-loaded unless specified otherwise
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-nvim-lsp-signature-help',
    'saadparwaiz1/cmp_luasnip',
    'L3MON4D3/LuaSnip',
    {
      'Exafunction/codeium.nvim',
      enabled = false,
      dependencies = {
        'nvim-lua/plenary.nvim',
      },
      config = function()
        require('codeium').setup({
          tools = {
            language_server = '/home/armeeh/.nix-profile/bin/codeium_language_server',
          },
        })
      end,
    },
    'onsails/lspkind.nvim',
    --[[ { 'supermaven-inc/supermaven-nvim', opts = {
      disable_keymaps = true,
      disable_inline_completion = true
    } }, ]]
  },
  config = function()
    local cmp = require('cmp')
    local luasnip = require('luasnip')
    local compare = cmp.config.compare;

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
      }),
      sources = cmp.config.sources({
        { name = 'luasnip', priority = 3 },
        { name = 'nvim_lsp_signature_help' , priority = 1},
        { name = 'path',    priority = 4 },
        -- { name = 'codeium' },
        -- { name = 'supermaven' },
        {
          name = 'buffer',
          option = {
            -- Index all visible buffers
            get_bufnrs = function()
              local bufs = {}
              for _, win in ipairs(vim.api.nvim_list_wins()) do
                bufs[vim.api.nvim_win_get_buf(win)] = true
              end
              return vim.tbl_keys(bufs)
            end,
          },
          priority = 9,
        },
        { name = 'nvim_lsp', priority = 10 },
      }),
      sorting = {
        priority_weight = 1.0,
        comparators = {
          -- compare.score_offset, -- not good at all
          compare.locality,
          compare.recently_used,
          compare.score, -- based on :  score = score + ((#sources - (source_index - 1)) * sorting.priority_weight)
          compare.offset,
          compare.order,
          -- compare.scopes, -- what?
          -- compare.sort_text,
          -- compare.exact,
          -- compare.kind,
          -- compare.length, -- useless
        }
      },
      formatting = {
        expandable_indicator = true,
        fields = { 'abbr', 'kind', 'menu' },
        format = require('lspkind').cmp_format({
          mode = 'symbol',
          maxwidth = 50,
          ellipsis_char = '...',
          symbol_map = { Codeium = '', Supermaven = '' },
        }),
      },
    })

    -- Ensure parens get inserted after completing function
    local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
  end,
}
