#!/usr/bin/env bash

function gaacmp () {
  git add -A && git commit -m "$1" && git push
}

function gaucmp () {
  git add -u && git commit -m "$1" && git push
}

