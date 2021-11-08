vim.cmd [[
  augroup rest_mapping
    autocmd!
    autocmd FileType http lua require 'plugins.rest-nvim'.bind()
  augroup END
]]

local m = {}

function m.setup()
    require("rest-nvim").setup({
        -- Open request results in a horizontal split
        result_split_horizontal = false,
        -- Skip SSL verification, useful for unknown certificates
        skip_ssl_verification = false,

        -- Highlight request on run
        highlight = {enabled = true, timeout = 150},

        -- Jump to request line on run

        jump_to_request = false
    })
end

function m.bind()
    vim.api.nvim_buf_set_keymap(0, 'n', '<Leader>r', '[rest]', {})
    vim.api.nvim_buf_set_keymap(0, 'n', '[rest]r', '<Plug>RestNvim', {})
    vim.api.nvim_buf_set_keymap(0, 'n', '[rest]p', '<Plug>RestNvimPreview', {})
end
return m
