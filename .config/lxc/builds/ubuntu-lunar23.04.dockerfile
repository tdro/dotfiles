FROM  docker.io/library/ubuntu:lunar@sha256:a40051efc6b591d38faffb11fdcef157103b9a4143edbc959c47e4b8c7d2e9eb

RUN   apt update

RUN   apt install --no-install-recommends --assume-yes \
      init uuid-runtime neofetch vim-tiny iproute2 xauth htop

RUN   systemctl mask sys-kernel-debug.mount
RUN   systemctl enable systemd-networkd

RUN   ln --symbolic --force bash /bin/sh

RUN   printf '[Match]\nName=eth0\n\n[Network]\nDHCP=yes' > /etc/systemd/network/20-wired.network
RUN   printf 'export TERM=linux\n' >> /etc/profile
RUN   printf 'neofetch\n' >> /etc/profile

RUN   printf '{ [ "$(whoami)" = "root" ] && export PS1='\''(ubuntu) \[\\e[0;31m\]\W\[\\e[0m\] \[\\e[0;31m\]\$\[\\e[0m\] '\''; } || true\n' >> /etc/profile
RUN   printf '{ [ "$(whoami)" = "user" ] && export PS1='\''(ubuntu) \[\\e[0;32m\]\W\[\\e[0m\] \[\\e[0;32m\]\$\[\\e[0m\] '\''; } || true\n' >> /etc/profile
RUN   printf 'id --user 1000 > /dev/null 2>&1 || { adduser user --uid 1000 --gecos user --disabled-password && printf ". ./etc/profile\n" >> /home/user/.bashrc; }\n' >> /etc/profile

RUN   usermod --password "$(uuidgen)" root
