return {
  'olimorris/codecompanion.nvim',
  opts = {
    adapters = {
      novita = function()
        return require('codecompanion.adapters').extend('novita', {
          schema = {
            model = {
              -- default = 'deepseek/deepseek-v3-turbo',
              -- default = 'deepseek/deepseek-r1-turbo',
              default = 'deepseek/deepseek-r1-distill-llama-8b',
            },
          },
        })
      end,
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
        enabled = true,
        provider = 'mini_diff',
      },
    },
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
}
