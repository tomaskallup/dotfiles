"======================================="
"           Rooter settings             "
"======================================="
let g:rooter_patterns = ['.venv', '.git/', '.vim/']

"======================================="
"         Vimspector settings           "
"======================================="
let g:vimspector_enable_mappings = ''

"======================================="
"          Vimwiki settings             "
"======================================="
let g:vimwiki_list = [{}, {'path': './vimwiki/'}]
let g:vimwiki_map_prefix = '<leader>e'

"======================================="
"         Ansi esc settings             "
"======================================="
let g:no_cecutil_maps = 1

"======================================="
"          Nvim Treesitter              "
"======================================="
exec 'luafile' expand(g:custom_path . 'lua/treesitter.lua')

"======================================="
"          Nvim LSP config              "
"======================================="
exec 'luafile' expand(g:custom_path . 'lua/lsp-config.lua')

"======================================="
"            Nvim compe                 "
"======================================="
exec 'luafile' expand(g:custom_path . 'lua/nvim-compe.lua')

"======================================="
"             Nvim tree                 "
"======================================="
let g:nvim_tree_follow = 1
let g:nvim_tree_indent_markers = 1
let g:nvim_tree_git_hl = 1
let g:nvim_tree_width_allow_resize  = 0
let g:nvim_tree_show_icons = {
    \ 'git': 1,
    \ 'folders': 1,
    \ 'files': 1,
    \ }

" default will show icon by default if no icon is provided
" default shows no icon by default
let g:nvim_tree_icons = {
    \ 'default': '',
    \ 'symlink': '',
    \ 'git': {
    \   'unstaged': "✗",
    \   'staged': "✓",
    \   'unmerged': "",
    \   'renamed': "➜",
    \   'untracked': "★"
    \   },
    \ 'folder': {
    \   'default': "",
    \   'open': "",
    \   'empty': "",
    \   'empty_open': "",
    \   'symlink': "",
    \   }
    \ }

"======================================="
"              Nvim dap                 "
"======================================="
exec 'luafile' expand(g:custom_path . 'lua/dap.lua')


"======================================="
"           Nvim telescope              "
"======================================="
exec 'luafile' expand(g:custom_path . 'lua/telescope-nvim.lua')


"======================================="
"           vim terminator              "
"======================================="
let g:terminator_clear_default_mappings = 1


"======================================="
"            Gitsigns.nvim              "
"======================================="
exec 'luafile' expand(g:custom_path . 'lua/gitsigns.lua')
