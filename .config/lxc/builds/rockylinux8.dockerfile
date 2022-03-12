FROM  docker.io/library/rockylinux:8.5@sha256:8a94380717b7e6b21c56f8333e0e8242e89a020c0c861d6346f59f179f096240

RUN   dnf install --assumeyes --setopt=install_weak_deps=False epel-release \
      && dnf --assumeyes update

RUN   dnf install --assumeyes --setopt=install_weak_deps=False \
      openssh-server network-scripts dhcp-client xauth vim htop

RUN   systemctl enable network sshd

RUN   sed --in-place 's/ens3/eth0/' /etc/sysconfig/network-scripts/ifcfg-ens3

RUN   systemctl mask sys-kernel-config.mount sys-kernel-debug.mount

RUN   curl --silent https://raw.githubusercontent.com/dylanaraps/neofetch/ccd5d9f52609bbdcd5d8fa78c4fdb0f12954125f/neofetch \
      --output /usr/bin/neofetch && chmod +x /usr/bin/neofetch
RUN   printf 'neofetch\n' >> /etc/profile
RUN   printf 'export TERM=linux\n' >> /etc/profile

RUN   printf '{ [ "$(whoami)" = "root" ] && export PS1='\''(rocky) \[\\e[0;31m\]\W\[\\e[0m\] \[\\e[0;31m\]\$\[\\e[0m\] '\''; } || true\n' >> /etc/profile
RUN   printf '{ [ "$(whoami)" = "user" ] && export PS1='\''(rocky) \[\\e[0;32m\]\W\[\\e[0m\] \[\\e[0;32m\]\$\[\\e[0m\] '\''; } || true\n' >> /etc/profile
RUN   printf 'id --user 1000 > /dev/null 2>&1 || { adduser user --uid 1000 --groups wheel --create-home --user-group --password "$(uuidgen)" && printf ". /etc/profile\n" >> /home/user/.bashrc; }\n' >> /etc/profile

RUN   usermod --password "$(uuidgen)" root
