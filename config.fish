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
abbr -a swi git switch -
abbr -a py python3
abbr -a ipy ipython3
abbr -a pip pip3
abbr -a saws saml2aws exec --profile saml -- 

set -gx EDITOR hx
set -gx ERL_AFLAGS "-kernel shell_history enabled"
fish_add_path --path /usr/local/go/bin
fish_add_path --path $HOME/go/bin
source_if_present $HOME/.tmonly.fish

# Elixir things
abbr -a mdp mix deps.get
abbr -a mc mix compile
abbr -a mtw mix test.watch
abbr -a mcc mix credo
abbr -a mf mix format
abbr -a iex iex -S mix run --no-start
abbr -a phx iex -S mix phx.server
abbr -a md mix dialyzer
abbr -a mdf mix dialyzer --format ignore_file_strict
abbr -a tenv MIX_ENV=test 
abbr -a lgi LOGGER_LEVEL=info
abbr -a lgd LOGGER_LEVEL=debug
abbr -a lgw LOGGER_LEVEL=warn


# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
test -r '/Users/psilva/.opam/opam-init/init.fish' && source '/Users/psilva/.opam/opam-init/init.fish' > /dev/null 2> /dev/null; or true
# END opam configuration
