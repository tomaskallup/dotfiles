vim.g.firenvim_config = {
    globalSettings = {alt = 'all'},
    localSettings = {
        ['https://console.cloud.google.com/'] = {
            takeover = 'never',
            priority = 20
        }
    }
}

vim.cmd([[
au BufEnter app.zenhub.com_*.txt set filetype=markdown
]])
