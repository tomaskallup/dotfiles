# Preset envs
[ -r ~/.config/shell/envs ] && source ~/.config/shell/envs

# Machine private envs
[ -r ~/.env ] && source ~/.env

# Aliases
[ -r ~/.config/shell/aliases ] && source ~/.config/shell/aliases

# Nvm
[ -r /usr/share/nvm/init-nvm.sh ] && source /usr/share/nvm/init-nvm.sh
