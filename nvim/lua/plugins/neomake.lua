vim.g.neomake_lerna_maker = {
    exe = 'lerna',
    args = {'run', 'build', '--parallel', '--no-bail'},
    process_output = function(context)
        local packages = vim.json.decode(
                             vim.fn['system'](
                                 'lerna list --json -a --loglevel error 2>/dev/null'))

        local packageMap = {}

        for i = 1, #packages do
            package = packages[i]
            packageMap[package.name] = package.location
        end

        local processed_errors = {}

        if context.source == 'stdout' then
            for _, value in ipairs(context.output) do
                local package, file, line, col, message =
                    string.match(value,
                                 "^([^ :]+): ([^(:]+)%((%d+),(%d+)%): (.+)")
                if package and #package > 0 then
                    local path = packageMap[package] .. '/' .. file

                    table.insert(processed_errors, {
                        text = message,
                        lnum = tonumber(line),
                        col = tonumber(col),
                        filename = path,
                        type = 'E'
                    })
                end
            end
        end

        return processed_errors
    end
}

vim.g.neomake_enabled_makers = {'lerna'}
vim.g.neomake_open_list = 2
