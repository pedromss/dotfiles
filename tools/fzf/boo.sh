#!/usr/bin/env bash 

if [[ 'kubectl -n fm-prod --context prod logs -f' =~ kubectl[\ ]+-n[\ ]+([^\ ]+).* ]] ; then
  echo 'Matches'
else
  echo 'Does not match'
fi
a='kubectl asd asd asdhj'
for word in $a ; do
  echo "Word: $word"
done
#kubectl -n fm-prod --context prod logs -f
#kubectl -n fm-prod --context prod logs -f
#kubectl --namespace fm-prod --context prod.aws.dev.com logs -f


