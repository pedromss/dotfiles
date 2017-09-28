coursier bootstrap com.geirsson:scalafmt-cli_2.12:1.2.0 \
 -o /usr/local/bin/scalafmt --standalone --main org.scalafmt.cli.Cli>&1

scalafmt --version
