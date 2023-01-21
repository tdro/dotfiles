FROM docker.io/voidlinux/voidlinux:latest@sha256:26ba972f0c06beadcec4796ec3037e0bec32af4d255edb68a528bd98304c74f4

RUN xbps-install -Syu xbps
RUN xbps-install -Syu
RUN xbps-install -y openssh dhcpcd iputils iproute2 socklog-void neofetch htop

RUN mkdir --parents /run/runit/runsvdir

RUN ln --symbolic --force bash /bin/sh
RUN ln --symbolic /etc/runit/runsvdir/current /run/runit/runsvdir/current
RUN ln --symbolic /etc/sv/sshd /var/service/
RUN ln --symbolic /etc/sv/dhcpcd-eth0 /var/service/
RUN ln --symbolic /etc/sv/socklog-unix /var/service/

RUN   printf 'neofetch\n' >> /etc/profile
RUN   printf 'export TERM=linux\n' >> /etc/profile

RUN   printf '{ [ "$(whoami)" = "root" ] && export PS1='\''(void) \[\\e[0;31m\]\W\[\\e[0m\] \[\\e[0;31m\]\$\[\\e[0m\] '\''; } || true\n' >> /etc/profile
RUN   printf '{ [ "$(whoami)" = "user" ] && export PS1='\''(void) \[\\e[0;32m\]\W\[\\e[0m\] \[\\e[0;32m\]\$\[\\e[0m\] '\''; } || true\n' >> /etc/profile

RUN   printf 'id --user 1000 > /dev/null 2>&1 || { useradd --uid 1000 --groups wheel --create-home --comment user user && printf ". ./etc/profile\n" >> /home/user/.bashrc; }\n' >> /etc/profile

RUN   usermod --password "$(uuidgen)" root


