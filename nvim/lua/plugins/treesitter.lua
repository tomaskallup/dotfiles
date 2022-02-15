local parser_configs = require('nvim-treesitter.parsers').get_parser_configs()

parser_configs.norg = {
    install_info = {
        url = "https://github.com/vhyrro/tree-sitter-norg",
        files = {"src/parser.c", "src/scanner.cc"},
        branch = "main"
    }
}

parser_configs.http = {
    install_info = {
        url = "https://github.com/NTBBloodbath/tree-sitter-http",
        files = {"src/parser.c"},
        branch = "main"
    }
}

require'nvim-treesitter.configs'.setup {
    ensure_installed = {
        "typescript", "tsx", "javascript", "python", "norg", "http"
    },
    indent = {enable = true, disable = {"python"}},
    highlight = {enable = true}
}
