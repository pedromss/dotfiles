#! /usr/bin/env bash

set -e

while [[ $# -gt 0 ]]
do
	key="$1"
	case $key in
		--user)
			user="$2"
			shift 2
			;;
		-h|--user-home|--home|--dotfiles-home)
			user_home="$2"
			shift 2
			;;
		-u|--uninstall)
			uninstall=1
			shift
			;;
		-t|--tool|--tools)
			tool="$2"
			shift 2
			;;
		--no-*)
			name="${1##*-}"
			export "DOTFILES_REQUESTED_TO_SKIP_${name^^}"=0
			shift
			;;
		--verbose)
			verbose=1
			shift
			;;
		*)
			POSITIONAL+=("$1")
			shift
			;;
	esac
done

(( ${verbose:-0} )) && set -x

set -- "$@" "${POSITIONAL[@]}"

# Expose env variables with all tools that are meant to be skipped
while IFS='=' read -r name value ; do
	if [[ $name == *'DOTFILES_REQUESTED_TO_SKIP'*  ]]; then
		echo "$name=$value"
	fi
done < <(env)

if [ -n "$user_home" ]; then
	echo "Setting dotfiles user home to $user_home"
	export DOTFILES_USER="$user"
	export DOTFILES_USER_HOME="$user_home"
fi

. common.sh
. funcs.sh

find-os

touch-dotfiles
# ==================================================
# Check single tool?
# ==================================================
if [ -n "$tool" ]; then
	# when installing a single tool we make copies of the configs
	# because only a subset of them will be overwritten.
	# In or not to lose the configs of the tools we won't install,
	# we back then up first
	copy-dotfiles-configs
	action='install'
	if ((${uninstall:-0})); then
		action='uninstall'
	fi

	file_to_eval="tools/$tool/$action.sh"

	set +e
	eval "$file_to_eval $*"
	set -e

	# shellcheck disable=SC2181
	if [[ "$?" != 0 ]]; then
		echo "__FAIL: $tool"
	else
		echo "Finished $action $tool"
	fi

	if ! (("${uninstall:-0}")); then
		cleanup
	fi
	exit 0
fi
# ==================================================
# Make links
# ==================================================
create-link-at-home 'runcom/.custom_profile'
create-link-at-home 'runcom/.bash_profile'
# ==================================================
# Package managers
# ==================================================
# ==================================================
# Tools
# ==================================================
#install-tool 'java'
install-tool 'rustup'
install-tool 'cargo'

install-tool 'llvm'
install-tool 'python-pip'
install-tool 'python3-pip'
install-tool 'shellcheck'
install-tool 'tpm'
install-tool 'tmux'

install-tool 'zsh'

install-tool 'exa'
install-tool 'bat'
install-tool 'mdcat'

install-tool 'go' "$@"
install-tool 'gomplate' "$@"
install-tool 'vault' "$@"

install-tool 'nvim' "$@"

cleanup
# ==================================================
# Shutdown
# ==================================================
echo 'Be sure to checkout:'
echo ' - https://github.com/ryanoasis/nerd-fonts'
echo ' - https://github.com/so-fancy/diff-so-fancy'
echo ' - Do C-x + i to install tpm inside tmux!'

echo 'All done!'
