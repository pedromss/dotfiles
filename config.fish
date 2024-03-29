starship init fish | source

abbr --add dotdot --regex '^\.\.+$' --function multicd
abbr -a b prevd
abbr -a f nextd
abbr -a c clear

if command -q xclip
    abbr -a cpp xclip -selection clipboard
    abbr -a pcp xclip -o
end

abbr -a gst git status -uall --branch -s
abbr -a glo git log --oneline --graph
abbr -a gloo git log --graph
abbr -a gcm git commit -S -m
abbr -a gau git add -u
abbr -a gaa git add --all
abbr -a gdc git diff --compact-summary
abbr -a gl git pull --rebase
abbr -a main git checkout main
abbr -a master git checkout master
abbr -a rmain git rebase main
abbr -a rmaster git rebase master
abbr -a gco git checkout 
abbr -a gnew git checkout -b 
abbr -a gsh git stash
abbr -a gsp git stash pop
abbr -a gp git push
abbr -a gd git diff

set -gx EDITOR hx
set -gx ERL_AFLAGS "-kernel shell_history enabled"
fish_add_path --path /usr/local/go/bin
fish_add_path --path $HOME/go/bin
source_if_present $HOME/.tmonly.fish
