set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

let g:custom_path = '~/.config/nvim/'

func LoadConfig(name)
    exec 'source' g:custom_path . a:name . '.vim'
endfunc

call LoadConfig('plugins')
call LoadConfig('base')
call LoadConfig('plugin-settings')
call LoadConfig('keymap')
"call LoadConfig('colors')

set nocompatible

colorscheme arcolors
set termguicolors
set inccommand=split

let g:python_host_prg = '/usr/local/bin/python'
let g:python3_host_prg = '/usr/local/bin/python3'
