FROM  docker.io/library/archlinux:base-devel-20230115.0.118859@sha256:d363f036cbbe40976a3b5883712fa56637a7245c24eca278d9afe71d64a93aea

RUN   pacman --noconfirm -Syu wget

RUN   printf '\
[options]                                                                                                                                             \n\
ParallelDownloads = 5                                                                                                                                 \n\
Architecture      = auto                                                                                                                              \n\
HoldPkg           = pacman glibc                                                                                                                      \n\
XferCommand       = /usr/bin/wget --quiet --passive-ftp --show-progress --tries=1 --waitretry=1 --read-timeout=1 --continue --output-document %%o %%u \n\
                                                                                                                                                      \n\
Color                                                                                                                                                 \n\
VerbosePkgLists                                                                                                                                       \n\
LocalFileSigLevel = Optional                                                                                                                          \n\
SigLevel          = Required DatabaseOptional                                                                                                         \n\
                                                                                                                                                      \n\
[core]                                                                                                                                                \n\
Include = /etc/pacman.d/mirrorlist                                                                                                                    \n\
                                                                                                                                                      \n\
[extra]                                                                                                                                               \n\
Include = /etc/pacman.d/mirrorlist                                                                                                                    \n\
                                                                                                                                                      \n\
[community]                                                                                                                                           \n\
Include = /etc/pacman.d/mirrorlist                                                                                                                    \n\
                                                                                                                                                      \n\
[options]                                                                                                                                             \n\
NoExtract = usr/share/help/* !usr/share/help/en*                                                                                                      \n\
NoExtract = usr/share/gtk-doc/html/* usr/share/doc/*                                                                                                  \n\
NoExtract = usr/share/locale/* usr/share/X11/locale/* usr/share/i18n/*                                                                                \n\
NoExtract = !*locale*/en*/* !usr/share/i18n/charmaps/UTF-8.gz !usr/share/*locale*/locale.*                                                            \n\
NoExtract = !usr/share/*locales/en_?? !usr/share/*locales/i18n* !usr/share/*locales/iso*                                                              \n\
NoExtract = !usr/share/*locales/trans*                                                                                                                \n\
NoExtract = usr/share/man/* usr/share/info/*                                                                                                          \n\
NoExtract = usr/share/vim/vim*/lang/*                                                                                                                 \n\
' > /etc/pacman.conf

RUN   pacman --noconfirm -Syu neofetch vim htop dhcpcd git go

RUN   cd /tmp \
      && curl --remote-name  https://aur.archlinux.org/cgit/aur.git/snapshot/yay.tar.gz \
      && tar --extract --file yay.tar.gz \
      && chmod o+w yay

RUN   su -s /bin/sh -c 'cd /tmp/yay && export GOCACHE=/tmp/yay && makepkg --syncdeps --noconfirm --skippgpcheck' - nobody \
      && pacman --noconfirm -U /tmp/yay/*.zst

RUN   pacman --noconfirm -Rns go gcc sudo

RUN   rm --recursive --force /tmp/yay /tmp/yay.tar.gz /var/cache/pacman/pkg

RUN   systemctl enable dhcpcd
RUN   systemctl mask \
      sys-kernel-config.mount \
      sys-kernel-debug.mount \
      systemd-journald-audit.socket \
      systemd-firstboot.service \
      tmp.mount

RUN   printf 'permit :wheel\npermit nopass keepenv root\n' > /etc/doas.conf && chmod 400 /etc/doas.conf

RUN   printf 'export TERM=linux\n' >> /etc/profile
RUN   printf 'neofetch\n' >> /etc/profile

RUN   printf '{ [ "$(whoami)" = "root" ] && export PS1='\''(arch) \[\\e[0;31m\]\w\[\\e[0m\] \[\\e[0;31m\]\$\[\\e[0m\] '\''; } || true\n' >> /etc/profile
RUN   printf '{ [ "$(whoami)" = "user" ] && export PS1='\''(arch) \[\\e[0;32m\]\w\[\\e[0m\] \[\\e[0;32m\]\$\[\\e[0m\] '\''; } || true\n' >> /etc/profile

RUN   printf 'id --user 1000 > /dev/null 2>&1 || { useradd --uid 1000 --groups wheel --create-home --comment user user && printf ". ./etc/profile\n" >> /home/user/.bashrc; }\n' >> /etc/profile

RUN   usermod --password "$(uuidgen)" root
