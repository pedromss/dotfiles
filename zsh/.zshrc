# For zsh profiling, uncomment this and the last line
#zmodload zsh/zprof

bindkey "^[[3~" delete-char

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

#dotfiles_folder=~/dotfiles/zsh/custom
source ~/.bash_profile

# Path to your oh-my-zsh installation.
#export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME=""

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
#DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM=$HOME/.zsh/custom

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git fzf-zsh docker)

#source $ZSH/oh-my-zsh.sh
fpath=(/usr/local/share/zsh-completions $fpath)
fpath=( "$HOME/.zfunctions" $fpath )
autoload -U promptinit; promptinit
prompt pure

# User configuration
#
switch_iterm_theme () {
  [[ -n $TMUX  ]] && printf "\033Ptmux;\033"
  echo -e "\033]50;SetProfile=$1\a" && export ITERM_PROFILE="$1"
  [[ -n $TMUX  ]] && printf "\033\\"
}
alias darktheme='switch_iterm_theme "Dark" && test $TMUX && tmux set -g status-bg black 2> /dev/null && tmux setw -g window-status-attr reverse'
alias lighttheme='switch_iterm_theme "Light" && test $TMUX && tmux set -g status-bg white 2> /dev/null && tmux setw -g window-status-attr default'
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
 if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
 else
   export EDITOR='mvim'
 fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

alias loadrvm='[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"'
alias loadnvm='[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" && [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"'
alias loadsdk='[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"'


# The following lines were added by compinstall
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' list-colors ''
#zstyle ':completion:*' matcher-list '' '' '' 'r:|[._-]=** r:|=**'
zstyle ':completion:*' menu select=2
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle :compinstall filename "$HOME/.zshrc"

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' cache-path ~/.zshcache

# End of lines added by compinstall
autoload -Uz compinit
compinit
# The following 2 lines are needed for compatiblity with bash
autoload bashcompinit
bashcompinit

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
complete -F _fzf_path_completion -o default -o bashdefault ag
complete -F _fzf_dir_completion -o default -o bashdefault tree

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/vault vault

setopt print_exit_value
setopt COMPLETE_ALIASES
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt SHARE_HISTORY
setopt COMPLETE_IN_WORD
setopt ALWAYS_TO_END
setopt PROMPT_SUBST
setopt HIST_IGNORE_DUPS
setopt CORRECT
setopt EXTENDED_GLOB
setopt NO_BEEP
setopt NOMATCH
setopt AUTO_PUSHD

# Brew installed plugins
#source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# ==================================================
# The following are disabled due to latency added
# ==================================================
# === Latency === | Plugin/Command
# 70 ms           | [ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh
# ==================================================

# Manually installed plugins
source $HOME/zsh-plugin-repos/almostontop/almostontop.plugin.zsh
source $HOME/zsh-plugin-repos/appup/appup.plugin.zsh
source $HOME/zsh-plugin-repos/auto-color-ls/auto-color-ls.plugin.zsh
source $HOME/zsh-plugin-repos/zsh-autopair/autopair.plugin.zsh
source $HOME/zsh-plugin-repos/enhancd/init.sh
source $HOME/zsh-plugin-repos/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source $HOME/zsh-plugin-repos/forgit/forgit.plugin.zsh
source $HOME/zsh-plugin-repos/k/k.plugin.zsh
source $HOME/zsh-plugin-repos/tipz/tipz.zsh
source $HOME/zsh-plugin-repos/zjump/zjump.plugin.zsh
# ==================================================
# The following are disabled due to latency added
# ==================================================
# === Latency === | Plugin/Command
# ==================================================

# For zsh profiling
#zprof
