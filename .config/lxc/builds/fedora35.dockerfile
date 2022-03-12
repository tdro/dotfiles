FROM  docker.io/library/fedora@sha256:762d7c5766839057fd9f96a0f2cedf143e2b818feb7767dc1bb70c00c4c3890a

RUN   dnf --assumeyes update

RUN   dnf install --assumeyes --setopt=install_weak_deps=False \
      openssh-server iproute neofetch dhcp-client xauth htop

RUN   systemctl enable sshd
RUN   systemctl mask sys-kernel-config.mount sys-kernel-debug.mount systemd-journald-audit.socket

RUN   mkdir --parents /etc/rc.d
RUN   printf '#!/bin/sh -eu\ndhclient\n' > /etc/rc.d/rc.local && chmod +x /etc/rc.d/rc.local

RUN   printf 'neofetch\n' >> /etc/profile
RUN   printf 'export TERM=linux\n' >> /etc/profile

RUN   printf '{ [ "$(whoami)" = "root" ] && export PS1='\''(fedora) \[\\e[0;31m\]\W\[\\e[0m\] \[\\e[0;31m\]\$\[\\e[0m\] '\''; } || true\n' >> /etc/profile
RUN   printf '{ [ "$(whoami)" = "user" ] && export PS1='\''(fedora) \[\\e[0;32m\]\W\[\\e[0m\] \[\\e[0;32m\]\$\[\\e[0m\] '\''; } || true\n' >> /etc/profile
RUN   printf 'id --user 1000 > /dev/null 2>&1 || { adduser user --uid 1000 --groups wheel --create-home --user-group --password "$(uuidgen)" && printf ". ./etc/profile\n" >> /home/user/.bashrc; }\n' >> /etc/profile

RUN   usermod --password "$(uuidgen)" root
