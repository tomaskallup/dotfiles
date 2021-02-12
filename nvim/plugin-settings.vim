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
"             Nvim compe                "
"======================================="
exec 'luafile' expand(g:custom_path . 'lua/nvim-compe.lua')

"======================================="
"             CHAD tree                 "
"======================================="
let g:chadtree_settings = {
      \"theme.text_colour_set": "env",
      \"options": { "session": v:false }
      \}
