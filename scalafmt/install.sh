source ../runcom/.functions

if ! command_exists ng;
then
  echo "Installing dependency nailgun..."
  brew install nailgun
fi

scalafmt_version=1.2.0
scalafmt_location=/usr/local/bin/scalafmt
scalafmt_ng_location=/usr/local/bin/scalafmt_ng

if [[ ! -f "$scalafmt_location" ]];
then
  echo 'Preparing standalone scalafmt...'
  coursier bootstrap "com.geirsson:scalafmt-cli_2.12:$scalafmt_version" \
    -o "$scalafmt_location" --standalone --main org.scalafmt.cli.Cli
fi

scalafmt --version

if [[ ! -f "$scalafmt_ng_location" ]];
then
  echo 'Preparing standalone scalafmt ng...'
  coursier bootstrap --standalone "com.geirsson:scalafmt-cli_2.12:$scalafmt_version" \
    -o "$scalafmt_ng_location" -f --main com.martiansoftware.nailgun.NGServer

  scalafmt_ng & # start nailgun in background
  ng ng-alias scalafmt org.scalafmt.cli.Cli
fi



ng scalafmt --version # should be 1.2.0
