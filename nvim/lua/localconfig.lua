local loadedConfigs = {}

local M = {}

M.check = function()
    local pwd = vim.fn.getcwd()

    if pwd == nil then return end

    local configDirPath = pwd .. '/.nvim'
    local configDir = vim.loop.fs_stat(configDirPath)

    if configDir ~= nil then
        local configPath = configDirPath .. '/init.lua'
        local config = vim.loop.fs_stat(configPath)

        if config ~= nil then
            if not loadedConfigs[configPath] then
                print('Loading config', configPath)
                vim.cmd('luafile ' .. configPath)
                loadedConfigs[configPath] = true
            end
        end
    end
end

return M
