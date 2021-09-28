local parser_configs = require('nvim-treesitter.parsers').get_parser_configs()

parser_configs.norg = {
    install_info = {
        url = "https://github.com/vhyrro/tree-sitter-norg",
        files = {"src/parser.c", "src/scanner.cc"},
        branch = "main"
    }
}

require'nvim-treesitter.configs'.setup {
    ensure_installed = {"typescript", "javascript", "python", "norg"},
    indent = {enable = true},
    highlight = {enable = true}
}
