eclim_version=2.7.0
if [[ -f "eclim_$eclim_version".jar ]];
then
  echo 'Eclim is in the directory'
else
  wget "https://github.com/ervandew/eclim/releases/download/$eclim_version/eclim_$eclim_version.jar"
fi

java -Dvim.files=$HOME/.vim -Declipse.home="$ECLIPSE_HOME" -jar "eclim_$eclim_version.jar" install
