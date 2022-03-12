FROM  docker.io/library/oraclelinux:8-slim@sha256:9c3ca322d552af7f20c3b80eea42e854487bcc5983b0ad66928c00e16c49d5e8

RUN   microdnf install epel-release && microdnf --assumeyes update

RUN   microdnf install --assumeyes openssh-server network-scripts dhcp-client neofetch htop

RUN   systemctl enable sshd

RUN   systemctl mask sys-kernel-config.mount sys-kernel-debug.mount rdisc.service

RUN   printf 'neofetch\n' >> /etc/profile
RUN   printf 'export TERM=linux\n' >> /etc/profile
RUN   printf 'dhclient\n' >> /etc/rc.d/rc.local && chmod +x /etc/rc.d/rc.local

RUN   printf '{ [ "$(whoami)" = "root" ] && export PS1='\''(oracle) \[\\e[0;31m\]\W\[\\e[0m\] \[\\e[0;31m\]\$\[\\e[0m\] '\''; } || true\n' >> /etc/profile
RUN   printf '{ [ "$(whoami)" = "user" ] && export PS1='\''(oracle) \[\\e[0;32m\]\W\[\\e[0m\] \[\\e[0;32m\]\$\[\\e[0m\] '\''; } || true\n' >> /etc/profile
RUN   printf 'id --user 1000 > /dev/null 2>&1 || { adduser user --uid 1000 --groups wheel --create-home --user-group --password "$(uuidgen)" && printf ". /etc/profile\n" >> /home/user/.bashrc; }\n' >> /etc/profile

RUN   usermod --password "$(uuidgen)" root
