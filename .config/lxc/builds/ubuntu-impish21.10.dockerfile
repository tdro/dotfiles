FROM  docker.io/library/ubuntu:impish@sha256:4e4222975b1673cbbff799934fa00dc0b3191d0c9a7711f5b1d0b81fdcbfe6aa

RUN   apt update

RUN   apt install --no-install-recommends --assume-yes \
      init uuid-runtime neofetch vim-tiny iproute2 dhcpcd5 xauth htop

RUN   systemctl mask sys-kernel-debug.mount

RUN   ln --symbolic --force bash /bin/sh

RUN   printf 'export TERM=linux\n' >> /etc/profile
RUN   printf 'neofetch\n' >> /etc/profile

RUN   printf '{ [ "$(whoami)" = "root" ] && export PS1='\''(ubuntu) \[\\e[0;31m\]\W\[\\e[0m\] \[\\e[0;31m\]\$\[\\e[0m\] '\''; } || true\n' >> /etc/profile
RUN   printf '{ [ "$(whoami)" = "user" ] && export PS1='\''(ubuntu) \[\\e[0;32m\]\W\[\\e[0m\] \[\\e[0;32m\]\$\[\\e[0m\] '\''; } || true\n' >> /etc/profile
RUN   printf 'id --user 1000 > /dev/null 2>&1 || { adduser user --uid 1000 --gecos user --disabled-password && printf ". ./etc/profile\n" >> /home/user/.bashrc; }\n' >> /etc/profile

RUN   usermod --password "$(uuidgen)" root
