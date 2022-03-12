FROM  docker.io/library/almalinux:8.5-20220306@sha256:cd49d7250ed7bb194d502d8a3e50bd775055ca275d1d9c2785aea72b890afe6a

RUN   dnf install --assumeyes --setopt=install_weak_deps=False epel-release \
      && dnf --assumeyes update

RUN   dnf install --assumeyes --setopt=install_weak_deps=False \
      openssh-server dhcp-client xauth vim htop

RUN   systemctl enable sshd

RUN   curl --silent https://raw.githubusercontent.com/dylanaraps/neofetch/ccd5d9f52609bbdcd5d8fa78c4fdb0f12954125f/neofetch \
      --output /usr/bin/neofetch && chmod +x /usr/bin/neofetch

RUN   printf 'neofetch\n' >> /etc/profile
RUN   printf 'export TERM=linux\n' >> /etc/profile
RUN   printf 'dhclient\n' >> /etc/rc.d/rc.local && chmod +x /etc/rc.d/rc.local

RUN   printf '{ [ "$(whoami)" = "root" ] && export PS1='\''(alma) \[\\e[0;31m\]\W\[\\e[0m\] \[\\e[0;31m\]\$\[\\e[0m\] '\''; } || true\n' >> /etc/profile
RUN   printf '{ [ "$(whoami)" = "user" ] && export PS1='\''(alma) \[\\e[0;32m\]\W\[\\e[0m\] \[\\e[0;32m\]\$\[\\e[0m\] '\''; } || true\n' >> /etc/profile
RUN   printf 'id --user 1000 > /dev/null 2>&1 || { adduser user --uid 1000 --groups wheel --create-home --user-group --password "$(uuidgen)" && printf ". /etc/profile\n" >> /home/user/.bashrc; }\n' >> /etc/profile

RUN   usermod --password "$(uuidgen)" root
