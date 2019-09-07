FROM ubuntu:18.04

RUN apt-get update \
      && apt-get -y install git sudo

WORKDIR /home

RUN git clone https://github.com/pedromss/dotfiles 
WORKDIR /home/dotfiles
