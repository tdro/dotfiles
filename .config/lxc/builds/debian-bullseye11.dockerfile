FROM  docker.io/library/debian:bullseye-slim@sha256:7c78fedca85eec82669ff06969250175edac0750cb883628dfe7be18cb906928

RUN   apt update

RUN   apt install --no-install-recommends --assume-yes \
      init uuid-runtime neofetch vim-tiny iproute2 dhcpcd5 xauth htop

RUN   systemctl mask sys-kernel-config.mount sys-kernel-debug.mount systemd-journald-audit.socket

RUN   ln --symbolic --force bash /bin/sh

RUN   printf 'export TERM=linux\n' >> /etc/profile
RUN   printf 'neofetch\n' >> /etc/profile

RUN   printf '{ [ "$(whoami)" = "root" ] && export PS1='\''(debian) \[\\e[0;31m\]\W\[\\e[0m\] \[\\e[0;31m\]\$\[\\e[0m\] '\''; } || true\n' >> /etc/profile
RUN   printf '{ [ "$(whoami)" = "user" ] && export PS1='\''(debian) \[\\e[0;32m\]\W\[\\e[0m\] \[\\e[0;32m\]\$\[\\e[0m\] '\''; } || true\n' >> /etc/profile
RUN   printf 'id --user 1000 > /dev/null 2>&1 || { adduser user --uid 1000 --gecos user --disabled-password && printf ". ./etc/profile\n" >> /home/user/.bashrc; }\n' >> /etc/profile

RUN   usermod --password "$(uuidgen)" root
