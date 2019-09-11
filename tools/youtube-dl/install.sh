#!/usr/bin/env bash 

# shellcheck disable=SC1090
. "$DOTFILES_FULL_PATH/funcs.sh"

skip-if-os-is 'youtube-dl' 'rpi'
mkdir -p ~/music

save-alias 'ydl' 'youtube-dl -x --audio-format mp3 --audio-quality 0 --no-playlist -o "$HOME/music/youtube-dl/%(title)s.%(ext)s"'
save-alias 'ydl-list' 'youtube-dl -x --audio-format mp3 --audio-quality 0 --yes-playlist -o "$HOME/music/youtube-dl/%(title)s.%(ext)s"'
