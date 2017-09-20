#! /usr/bin/env bash

source ./common.sh $1

echo 'Deleting symlinks...'

all_links=($(find $user_home -maxdepth 4 -type l))
for link in "${all_links[@]}"
do
  if [[ $(readlink $link) == *".dotfiles"* ]]
  then
    echo "Deleting link: ${link[*]}"
    rm $link
  fi
done

