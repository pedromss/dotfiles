#!/usr/bin/env bash

# --docker_rmi_dangling([$@ passed to docker rmi]) {
docker_rmi_dangling() {
  if command_exists docker ;
  then
    docker rmi "$(docker images -f dangling=true -q)" "$@"
  else
    echo "Docker doesn't seem to be installed"
  fi
}


# --function drmf([containerName | partial matches allowed]) {
function drmf() {
  command_exists 'docker'
  query=${1:-'.*'}
  docker rm -f "$(docker ps -a -q -f name=".*$query.*")"
}

# --function drmftls(remoteHost, [containerName | partial matches allowed]) {
function drmftls() {
  command_exists 'docker'
  query=${2:-'.*'}
  docker --tlsverify -H "$1" rm -f "$(docker --tlsverify -H "$1" ps -a -q -f name=".*$query.*")"
}

# --function dps([containerName | partial matches allowed]) {
function dps() {
  command_exists 'docker'
  query=${1:-'.*'}
  docker ps -a -f name=".*$query.*"
}

# --function dpsq([containerName | partial matches allowed]) {
function dpsq() {
  command_exists 'docker'
  query=${1:-'.*'}
  docker ps -a -q -f name=".*$query.*"
}

# --function dpstls(remoteHost, [containerName | partial matches allowed]) {
function dpstls() {
  command_exists 'docker'
  query=${2:-'.*'}
  docker --tlsverify -H "$1" ps -a -f name=".*$query.*"
}

# --function dpsqtls(remoteHost, [containerName | partial matches allowed]) {
function dpsqtls() {
  command_exists 'docker'
  query=${2:-'.*'}
  docker --tlsverify -H "$1" ps -a -q -f name=".*$query.*"
}

# --function dnetls([networkName | partial matches allowed]) {
function dnetls() {
  command_exists 'docker'
  query=${1:-'.*'}
  docker network ls -f name=".*$query.*"
}

# --function dnetlstls(remoteHost, [networkName | partial matches allowed]) {
function dnetlstls() {
  command_exists 'docker'
  query=${2:-'.*'}
  docker --tlsverify -H "$1" network ls -f name=".*$query.*"
}

# --function dnetrm([networkName | partial matches allowed]) {
function dnetrm() {
  command_exists 'docker'
  query=${1:-'.*'}
  docker network rm "$(docker network ls -f name=".*$query.*" -q)"
}

# --function dnetrmtls(remoteHost, [networkName]) {
function dnetrmtls() {
  command_exists 'docker'
  query=${2:-'.*'}
  docker --tlsverify -H "$1" network rm "$(docker network ls -f name=".*$query.*" -q)"
}

# --function din(containerName, [propertyToInspect]) {
function din() {
  command_exists 'gron'
  command_exists 'docker'
  command_exists 'ag'
  query=${2:-'.*'}
  docker inspect "$1" | gron | ag "$query" | gron --ungron
}

# --function dneti(networkName, [propertyToInspect]) {
function dneti() {
  command_exists 'gron'
  command_exists 'docker'
  command_exists 'ag'
  query=${2:-'.*'}
  docker network inspect "$1" | gron | ag "$query" | gron --ungron
}

# --function dnetiq([networkName], propertyToInspect) {
function dnetiq() {
  command_exists 'gron'
  command_exists 'docker'
  command_exists 'ag'
  network_filter=${1:-'.*'}
  query=${2:-'.*'}
  docker network inspect "$(docker network ls -f name=".*$network_filter.*" -q)" | gron | ag "$query" | gron --ungron
}

# --function dintls(remoteHost, containerName, [property]) {
function dintls() {
  command_exists 'gron'
  command_exists 'docker'
  command_exists 'ag'
  query=${3:-'.*'}
  docker --tlsverify -H "$1" inspect "$2" | gron | ag "$query" | gron --ungron
}

# --function dnetiqtls(remoteHost, [networkName], [property]) {
function dnetiqtls() {
  command_exists 'gron'
  command_exists 'docker'
  command_exists 'ag'
  network_filter=${2:-'.*'}
  query=${3:-'.*'}
  docker --tlsverify -H "$1" network inspect "$(docker network ls -f name=".*$network_filter.*" -q)" | gron | ag "$query" | gron --ungron
}

# --function dnetitls(remoteHost, networkName, [property]) {
function dnetitls() {
  command_exists 'gron'
  command_exists 'docker'
  command_exists 'ag'
  query=${3:-'.*'}
  docker --tlsverify -H "$1" network inspect "$2" | gron | ag "$query" | gron --ungron
}
