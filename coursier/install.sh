source ../runcom/.functions
if $(command_exists coursier);
then
  echo 'Coursier already installed!'
  exit 0
else
  echo "Downloading coursier..."
  dest="/usr/local/bin/coursier"
  curl -L -o "$dest" https://git.io/vgvpD && chmod +x "$dest"
fi

add_plugin_txt='addSbtPlugin("io.get-coursier" % "sbt-coursier" % "1.0.0-RC12")'

for sbtversion in $HOME/.sbt/[0-9]*
do
  echo "Adding coursier to $sbtversion"
  plugin_dir="$sbtversion/plugins"
  current_plugin_file="$plugin_dir/coursier.sbt"
  if [[ -f "$current_plugin_file" ]];
  then
    echo "$sbtversion already has coursier"
  else
    echo "Installing coursier in $sbtversion"
    mkdir -p "$plugin_dir"
    touch "$current_plugin_file"
    add_plugin_txt >> "$current_plugin_file"
  fi
done

echo '\n\n'
coursier --help
