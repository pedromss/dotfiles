#!/usr/bin/env bash

function gaa () {
  git add -A
}

function gau () {
  git add -u
}

function gcm () {
  git commit -m "$1"
}

function gaacm () {
  gaa
  gcm "$1"
}

function gaucm () {
  gau
  gcm "$1"
}

function gaucmp () {
  gaucm "$1"
  git push
}

function gaacmp () {
  gaacm "$1"
  git push
}


