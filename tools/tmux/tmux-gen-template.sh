#!/usr/bin/env bash

session_name='basic'

tmux -2 new-session -d -s "$session_name"
tmux rename-window -t "${session_name}:0" 'dotfiles'
tmux new-window -t "${session_name}:1" 'nvim'
tmux select-window -t "${session_name}:0"
tmux send-keys -t "${session_name}:0" 'cd ~/dotfiles' Enter

tmux attach -t "${session_name}:0"

tmux select-pane -t 0

tmux select-window -t "${session_name}:0"
