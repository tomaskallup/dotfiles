return {
  enabled = true,
  'olimorris/codecompanion.nvim',
  opts = {
    adapters = {
      http = {
        novita = function()
          return require('codecompanion.adapters').extend('novita', {
            schema = {
              model = {
                -- default = 'deepseek/deepseek-v3-turbo',
                default = 'qwen/qwen3-coder-480b-a35b-instruct',
              },
            },
          })
        end,
      },
    },
    strategies = {
      chat = {
        adapter = 'novita',
      },
      inline = {
        adapter = 'novita',
      },
      cmd = {
        adapter = 'novita',
      },
    },
    display = {
      diff = {
        provider_opts = {
          inline = {
            layout = 'float',
            opts = {
              context_lines = 3,
              dim = 25,
              full_width_removed = true,
              show_keymap_hints = true,
              show_removed = true,
            },
          },
        },
      },
    },
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
}
