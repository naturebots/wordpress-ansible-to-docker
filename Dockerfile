FROM ubuntu:20.04

# apt update
#RUN apt-get update \
#      && apt-get install -y \
#      build-essential \
#      sudo \
#      curl \
#      vim \
#      net-tools \
#      iputils-ping \
#      less \
#      ssh


RUN echo "**** install openssh-server ****" && \
    apt update && \
    apt install -y openssh-server

RUN mkdir ~/.ssh
COPY ssh/authorized_keys /root/.ssh/

RUN sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config
RUN sed -i 's/#AuthorizedKeysFile\t.ssh\/authorized_keys .ssh\/authorized_keys2/AuthorizedKeysFile\t.ssh\/authorized_keys/' /etc/ssh/sshd_config

RUN mkdir /run/sshd
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
