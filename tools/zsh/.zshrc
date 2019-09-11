# For zsh profiling, uncomment this and the last line
#zmodload zsh/zprof

bindkey "^[[3~" delete-char
bindkey '[C' beginning-of-line

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

for f in `find "$HOME" -maxdepth 1 \( -iname \*.env -o -iname \*.alia \) -type f`
do
  source $f > /dev/null
done

source "$HOME/dotfiles/runcom/.custom_profile"

ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=50
ZSH_AUTOSUGGEST_USE_ASYNC=yes

HISTSIZE=15000
SAVEHIST=10000
HISTFILE=$HOME/.zhistory


ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

ZSH_CUSTOM=$HOME/.zsh/custom

fpath=(/usr/local/share/zsh-completions $fpath)
fpath=( "$HOME/.zfunctions" $fpath )
autoload -U promptinit; promptinit
PURE_GIT_PULL=0
prompt pure
PROMPT='%F{white}%* '$PROMPT
#prompt_newline='%666v'
#PROMPT=" $PROMPT"
precmd_pipestatus() {
  RPROMPT="${(j.|.)pipestatus}"
}
add-zsh-hook precmd precmd_pipestatus
ZSH_THEME=""

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# ==================================================
# Performance improvements. Lazy loading
# ==================================================
alias loadrvm='[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"'
alias loadnvm='[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" && [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"'
alias loadsdk='[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"'
# ==================================================
# Completions
# ==================================================
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' menu select=2
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle :compinstall filename "$HOME/.zshrc"

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' cache-path ~/.zshcache
autoload -Uz compinit
compinit
# The following 2 lines are needed for compatiblity with bash
autoload bashcompinit
bashcompinit

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/vault vault
# ==================================================
# 16. Options - http://zsh.sourceforge.net/Doc/Release/Options.html
# ==================================================
setopt print_exit_value
setopt PROMPT_SUBST
setopt NO_BEEP
# 16.2.1 Changing directories
setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
# 16.2.2 Completion
setopt ALWAYS_TO_END
setopt COMPLETE_ALIASES
setopt COMPLETE_IN_WORD
setopt GLOB_COMPLETE
# 16.2.3 Expansion and globbing
setopt NOMATCH
setopt EXTENDED_GLOB
# 16.2.4 History
setopt APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt SHARE_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_LEX_WORDS # may make things slow depending on the size of the history file
setopt HIST_NO_STORE
setopt HIST_REDUCE_BLANKS
setopt HIST_SAVE_NO_DUPS
# 16.2.6 Input / Output
setopt ALIASES
setopt CORRECT
setopt HASH_CMDS
setopt HASH_DIRS
setopt RM_STAR_WAIT
# ==================================================
# plugins
# ==================================================
source $HOME/zsh-plugin-repos/appup/appup.plugin.zsh
source $HOME/zsh-plugin-repos/zsh-autopair/autopair.plugin.zsh
source $HOME/zsh-plugin-repos/enhancd/init.sh
source $HOME/zsh-plugin-repos/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source $HOME/zsh-plugin-repos/forgit/forgit.plugin.zsh
source $HOME/zsh-plugin-repos/k/k.plugin.zsh
source $HOME/zsh-plugin-repos/oh-my-zsh/plugins/globalias/globalias.plugin.zsh
source $HOME/zsh-plugin-repos/oh-my-zsh/plugins/vi-mode/vi-mode.plugin.zsh
source $HOME/zsh-plugin-repos/zsh-history-substring-search/zsh-history-substring-search.plugin.zsh
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
if ! [ -f '/etc/os-release' ] || ! [[ $(cat /etc/os-release) =~ 'Raspbian' ]]; then
  source $HOME/zsh-plugin-repos/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
fi
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
complete -F _fzf_path_completion -o default -o bashdefault ag
complete -F _fzf_dir_completion -o default -o bashdefault tree
source $HOME/zsh-plugin-repos/zjump/zjump.plugin.zsh
# For zsh profiling
#zprof

# Added by Krypton
export GPG_TTY=$(tty)
