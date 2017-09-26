if $(command_exists cs)
then
  echo 'Conscript already installed. Skipping!'
  exit 0
fi

echo 'Installing conscript...'

java -jar conscript_*.jar
