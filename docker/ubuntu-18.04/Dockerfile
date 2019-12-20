FROM ubuntu:18.04

RUN apt-get update && apt-get -y install git sudo curl wget

# fromhttps://stackoverflow.com/questions/25845538/how-to-use-sudo-inside-a-docker-container
RUN \
    groupadd -g 999 dummy && useradd -u 999 -g dummy -G sudo -m -s /bin/bash dummy && \
    sed -i /etc/sudoers -re 's/^%sudo.*/%sudo ALL=(ALL:ALL) NOPASSWD: ALL/g' && \
    sed -i /etc/sudoers -re 's/^root.*/root ALL=(ALL:ALL) NOPASSWD: ALL/g' && \
    sed -i /etc/sudoers -re 's/^#includedir.*/## **Removed the include directive** ##"/g' && \
    echo "dummy ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    echo "Customized the sudoers file for passwordless access to the dummy user!" && \
    echo "dummy user:";  su - dummy -c id

USER dummy
RUN git clone https://github.com/pedromss/dotfiles /home/dummy/dotfiles
WORKDIR /home/dummy/dotfiles
ARG branch
RUN git checkout $branch
