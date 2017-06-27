#!/bin/sh

sudo rm -f production-repo.key.asc staging-repo.key.asc

sudo apt install apt-transport-https

# production repo:
sudo sh -c "wget https://images.validation.linaro.org/production-repo/production-repo.key.asc \
            && apt-key add production-repo.key.asc \
            && echo 'deb http://images.validation.linaro.org/production-repo/ sid main' > /etc/apt/sources.list.d/lava.list"

# staging repo:
#sudo sh -c "wget https://images.validation.linaro.org/staging-repo/staging-repo.key.asc \
#            && apt-key add staging-repo.key.asc \
#            && echo 'deb https://images.validation.linaro.org/staging-repo sid main' > /etc/apt/sources.list.d/lava.list"

sudo sh -c "apt-get clean && apt update \
            && apt-cache show lava | grep Depends:"

sudo sh -c "echo \"deb http://ftp.debian.org/debian/ jessie-backports main contrib non-free\" > /etc/apt/sources.list.d/backports.list && \
            echo \"deb http://ftp.debian.org/debian/ jessie main contrib non-free\"           > /etc/apt/sources.list && \
            echo \"deb http://ftp.debian.org/debian/ jessie-updates main contrib non-free\"   >> /etc/apt/sources.list &&\
            echo \"deb http://security.debian.org jessie/updates main contrib non-free\"      >> /etc/apt/sources.list "

sudo sh -c "apt-get clean && apt update \
            && apt-cache show lava | grep Depends:" 

sudo apt install -t $(lsb_release -sc)-backports -y lava

sudo apt list --upgradable

sudo apt update && sudo apt upgrade 

sudo sh -c "a2enmod proxy proxy_http \
            && a2dissite 000-default \
            && a2ensite lava-server \
            && service apache2 reload \
           "

sudo sh -c "useradd -m -G plugdev lava \
            && echo 'lava ALL = NOPASSWD: ALL' > /etc/sudoers.d/lava \
            && chmod 0440 /etc/sudoers.d/lava \
            && mkdir -p /var/run/sshd /home/lava/bin /home/lava/.ssh \
            && chmod 0700 /home/lava/.ssh \
            && chown -R lava:lava /home/lava/bin /home/lava/.ssh
          "


sudo apt install -t $(lsb_release -sc)-backports -y qemu-kvm qemu-system \
              qemu-system-arm \
              qemu-system-i386 \
              qemu-system-x86 \
              qemu-kvm


sudo apt list --upgradable



sudo rm -f production-repo.key.asc staging-repo.key.asc
