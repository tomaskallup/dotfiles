let s:path = '~/.vim/config/'

func LoadConfig(name)
    exec 'source' s:path . a:name . '.vim'
endfunc

call LoadConfig('plugins')
call LoadConfig('base')
call LoadConfig('plugin-settings')
call LoadConfig('keymap')
call LoadConfig('colors')
call LoadConfig('ui')

set nocompatible
