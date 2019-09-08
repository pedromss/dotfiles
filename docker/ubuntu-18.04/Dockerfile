FROM ubuntu:18.04

RUN apt-get update \
      && apt-get -y install git sudo

RUN useradd -ms /bin/bash pedromss
USER pedromss
WORKDIR /home/pedromss

RUN git clone https://github.com/pedromss/dotfiles 
WORKDIR /home/pedromss/dotfiles
