"======================================="
"             Coc settings              "
"======================================="
let g:coc_filetype_map = {
  \ 'sass': 'scss',
  \ }

"======================================="
"           Rooter settings             "
"======================================="
let g:rooter_patterns = ['.venv', '.git/', '.vim/']

"======================================="
"           Ctrl-p settings             "
"======================================="
let g:ctrlp_clear_cache_on_exit = 1

let g:ctrlp_user_command = 'git ls-files . --exclude-standard'

"======================================="
"            Yats settings              "
"======================================="
let g:yats_host_keyword = 0

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
