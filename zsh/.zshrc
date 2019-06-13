# For zsh profiling, uncomment this and the last line
#zmodload zsh/zprof

bindkey "^[[3~" delete-char

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

for f in `find "$HOME" \( -iname \*.env -o -iname \*.alia \) -maxdepth 1 -type f`
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

# User configuration
#
switch_iterm_theme () {
  [[ -n $TMUX  ]] && printf "\033Ptmux;\033"
  echo -e "\033]50;SetProfile=$1\a" && export ITERM_PROFILE="$1"
  [[ -n $TMUX  ]] && printf "\033\\"
}
alias darktheme='switch_iterm_theme "Dark" && test $TMUX && tmux set -g status-bg black 2> /dev/null && tmux setw -g window-status-attr reverse'
alias lighttheme='switch_iterm_theme "Light" && test $TMUX && tmux set -g status-bg white 2> /dev/null && tmux setw -g window-status-attr default'

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
  if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='vim'
  else
    export EDITOR='mvim'
  fi

  test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

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
      # FZF completions
      # ==================================================
      [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
      complete -F _fzf_path_completion -o default -o bashdefault ag
      complete -F _fzf_dir_completion -o default -o bashdefault tree

# Brew installed plugins
#source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# ==================================================
# The following are disabled due to latency added
# ==================================================
# === Latency === | Plugin/Command
# 70 ms           | [ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh
# ==================================================

# Manually installed plugins
#source $HOME/zsh-plugin-repos/almostontop/almostontop.plugin.zsh
source $HOME/zsh-plugin-repos/appup/appup.plugin.zsh
#source $HOME/zsh-plugin-repos/auto-color-ls/auto-color-ls.plugin.zsh
source $HOME/zsh-plugin-repos/zsh-autopair/autopair.plugin.zsh
source $HOME/zsh-plugin-repos/enhancd/init.sh
source $HOME/zsh-plugin-repos/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source $HOME/zsh-plugin-repos/forgit/forgit.plugin.zsh
source $HOME/zsh-plugin-repos/k/k.plugin.zsh
source $HOME/zsh-plugin-repos/zjump/zjump.plugin.zsh
source $HOME/zsh-plugin-repos/oh-my-zsh/plugins/globalias/globalias.plugin.zsh
source $HOME/zsh-plugin-repos/zsh-history-substring-search/zsh-history-substring-search.plugin.zsh
if ! [ -f '/etc/os-release' ] || ! [[ $(cat /etc/os-release) =~ 'Raspbian' ]]; then
  source $HOME/zsh-plugin-repos/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
fi
# ==================================================
# The following are disabled due to latency added
# ==================================================
# === Latency === | Plugin/Command
# ==================================================
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# For zsh profiling
#zprof
