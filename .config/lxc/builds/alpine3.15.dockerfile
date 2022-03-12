FROM  docker.io/library/alpine:3.15@sha256:e7d88de73db3d3fd9b2d63aa7f447a10fd0220b7cbf39803c803f2af9ba256b3

RUN   apk update

RUN   apk add openrc neofetch xauth openssh vim htop

RUN   rc-update add networking
RUN   rc-update add sshd

RUN   printf 'auto lo\niface lo inet loopback\n\nauto eth0\niface eth0 inet dhcp\n' > /etc/network/interfaces

RUN   printf 'export TERM=xterm-256color\n' >> /etc/profile
RUN   printf 'id -u user > /dev/null 2>&1 || { adduser -u 1000 -g user user -D; }\n' >> /etc/profile

RUN   printf '. /etc/profile && neofetch\n' > /etc/profile.d/neofetch

RUN   printf "export ENV='/etc/profile.d/neofetch'\n" >> /etc/profile

RUN   printf '{ [ "$(whoami)" = "root" ] && export PS1='\''(alpine) \[\\e[0;31m\]\w\[\\e[0m\] \[\\e[0;31m\]\$\[\\e[0m\] '\''; } || true\n' >> /etc/profile
RUN   printf '{ [ "$(whoami)" = "user" ] && export PS1='\''(alpine) \[\\e[0;32m\]\w\[\\e[0m\] \[\\e[0;32m\]\$\[\\e[0m\] '\''; } || true\n' >> /etc/profile
