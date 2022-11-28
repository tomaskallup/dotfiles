require'nvim-treesitter.configs'.setup {
    ensure_installed = {
        "typescript", "tsx", "javascript", "python"
    },
    indent = {enable = true, disable = {"python"}},
    highlight = {enable = true}
}
