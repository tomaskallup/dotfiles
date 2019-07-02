set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

colorscheme custom
set inccommand=split

let g:python_host_prg = '/usr/local/bin/python'
let g:python3_host_prg = '/usr/local/bin/python3'
