# Preset envs
[ -r ~/.config/shell/envs ] && source ~/.config/shell/envs

# Machine private envs
[ -r ~/.env ] && source ~/.env

# Aliases
[ -r ~/.config/shell/aliases ] && source ~/.config/shell/aliases

# LS_COLORS
[ -r ~/.local/share/lscolors.sh ] && source ~/.local/share/lscolors.sh

autoload -Uz promptinit
promptinit

# Plugin manager
source /usr/share/zsh/scripts/zplug/init.zsh

zplug "~/.config/zsh/themes/custom", from:local
zplug "zdharma-continuum/fast-syntax-highlighting", defer:2
zplug "MichaelAquilina/zsh-autoswitch-virtualenv"
zplug "buonomo/yarn-completion", defer:2
zplug "arzzen/calc.plugin.zsh"
zplug "b4b4r07/enhancd", use:init.sh

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load

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

zstyle ':completion:*' completer _complete _ignored _files

#alsi
#task long

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/opt/google-cloud-cli/path.zsh.inc' ]; then . '/opt/google-cloud-cli/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/opt/google-cloud-cli/completion.zsh.inc' ]; then . '/opt/google-cloud-cli/completion.zsh.inc'; fi

eval "$(direnv hook zsh)"
