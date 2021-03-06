# Preset envs
[ -r ~/.config/shell/envs ] && source ~/.config/shell/envs

# Machine private envs
[ -r ~/.env ] && source ~/.env

# Aliases
[ -r ~/.config/shell/aliases ] && source ~/.config/shell/aliases

# Nvm
[ -r /usr/share/nvm/init-nvm.sh ] && source /usr/share/nvm/init-nvm.sh

# LS_COLORS
[ -r ~/.local/share/lscolors.sh ] && source ~/.local/share/lscolors.sh

autoload -Uz promptinit
promptinit

autoload -Uz compinit
compinit


# Plugin manager
source /usr/share/zsh/share/zgen.zsh

# if the init script doesn't exist
if ! zgen saved; then

  # specify plugins here
  # zgen oh-my-zsh plugins/vi-mode

  zgen load ~/.config/zsh/themes/custom
  zgen load owenstranathan/pipenv.zsh
  zgen load zdharma/fast-syntax-highlighting
  zgen load MichaelAquilina/zsh-autoswitch-virtualenv
  zgen load buonomo/yarn-completion
  zgen load arzzen/calc.plugin.zsh

  # generate the init script from plugins above
  zgen save
fi

ZSH_THEME='custom'

# Better arrow search
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey -e
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down

# Edit current command in editor
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line

# Allow shift-tab for backwards complete
bindkey '^[[Z' reverse-menu-complete

# Run-help for figuring stuff out!
autoload -Uz run-help
(( $+aliases[run-help] )) && unalias run-help

zle_highlight+=(paste:none)

# History setup
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_ALL_DUPS # delete old dups when saving
setopt HIST_IGNORE_SPACE # ignore empty spaces
setopt HIST_FIND_NO_DUPS # dont show duplicates
setopt HIST_SAVE_NO_DUPS # dont save duplicates
setopt HIST_REDUCE_BLANKS # remove superfluous blanks from history items
setopt INC_APPEND_HISTORY # save history entries as soon as they are entered

setopt auto_cd # cd by typing directory name if it's not a command

# Autojump
source /etc/profile.d/autojump.zsh

alsi

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/armeeh/Pkg/google-cloud-sdk/path.zsh.inc' ]; then . '/home/armeeh/Pkg/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/armeeh/Pkg/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/armeeh/Pkg/google-cloud-sdk/completion.zsh.inc'; fi
