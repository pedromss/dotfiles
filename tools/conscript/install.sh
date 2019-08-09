#!/usr/bin/env bash

save-env "$CONSCRIPT_HOME" "$HOME/.conscript"
save-env "$CONSCRIPT_OPTS" "-XX:MaxPermSize=512M -Dfile.encoding=UTF-8"
save-env "$PATH" "$CONSCRIPT_HOME/bin:$PATH"

skip-if-installed 'cs'
conscript_version=${1:-'v0.5.0'}
echo 'Installing conscript...'
wget "https://raw.githubusercontent.com/foundweekends/conscript/${conscript_version}/setup.sh" -O - | sh 
echo 'Conscript installed. Try "cs --help"'
