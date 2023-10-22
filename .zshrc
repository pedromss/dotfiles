#zmodload zsh/zprof
[ -f ~/dotboot/configure ] && source ~/dotboot/configure
bindkey "^[[3~" delete-char
bindkey '[C' beginning-of-line
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=50
ZSH_AUTOSUGGEST_USE_ASYNC=yes
HISTSIZE=15000
SAVEHIST=10000
HISTFILE=~/.zhistory
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
fpath=( /usr/local/share/zsh-completions "$DFILES_DIR_ASDF"/completions $fpath )
# ==================================================
# Completions
# ==================================================
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' menu select=2
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle :compinstall filename ~/dotfiles/.zshrc

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' cache-path ~/dotfiles/bin/zsh-cache
autoload -Uz compinit
compinit
# The following 2 lines are needed for compatiblity with bash
autoload -U bashcompinit
bashcompinit

#autoload -U +X bashcompinit && bashcompinit
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
setopt PUSHD_SILENT
# 16.2.2 Completion
setopt ALWAYS_TO_END
setopt AUTO_LIST
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
# 16.2.7 Job control
setopt CHECK_JOBS
setopt HUP
setopt MONITOR
# 16.2.12 ZLE
setopt ZLE
# ================================================== 
# Completions
# ================================================== 
complete -F _fzf_path_completion -o default -o bashdefault ag
complete -F _fzf_dir_completion -o default -o bashdefault tree
autoload -U promptinit; promptinit
# ================================================== 
# Plugins
# ================================================== 
if [ -d ~/dotfiles/repos/zsh-plugins ] ; then
  for plugin_folder in ~/dotfiles/repos/zsh-plugins/* ; do
    if [[ "$plugin_folder" =~ .*ohmyzsh$ ]] ; then
      . "$plugin_folder/plugins/globalias/globalias.plugin.zsh"
      # . "$plugin_folder/plugins/vi-mode/vi-mode.plugin.zsh"
    else 
      for plugin_file in "$plugin_folder"/*.plugin.zsh ; do
        if [ -f "$plugin_file" ] ; then
          . "$plugin_file"
        fi
      done
    fi
  done
fi
plugins=(fzf-zsh-plugin)
# ================================================== 
# Plugin configs
# ==================================================
eval "$(starship init zsh)"
bindkey '^[k' history-substring-search-up
bindkey '^[j' history-substring-search-down
# shellcheck disable=1090
if [ -f ~/dotfiles/repos/fzf/shell/completion.zsh ] ; then
  source ~/dotfiles/repos/fzf/shell/completion.zsh
fi
# shellcheck disable=1090
if [ -f ~/dotfiles/repos/fzf/shell/key-bindings.zsh ] ; then
  source ~/dotfiles/repos/fzf/shell/key-bindings.zsh
fi
if command_exists kubectl ; then
  source <(kubectl completion zsh) 2>/dev/null
fi

[ -f ~/dotboot/configure ] && _load_at_the_end
zvm_after_init_commands+=('[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh')
[ -f ~/.tmonly ] && . ~/.tmonly

#zprof
