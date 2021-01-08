FROM centos:latest
WORKDIR /
ENV REMOTEUSER="root"
ENV REMOTEPASS="NOPASS"
ENV INVENTARIO="servers"
COPY ./Agent/Execute.sh /
RUN dnf install -y epel-release && dnf install -y  ansible && dnf install -y wget && \
    dnf install -y openssh && \
    dnf install -y git && \
    chmod u+x Execute.sh && \
    dnf install -y sshpass && \
    dnf install -y dos2unix && \
    dos2unix /Execute.sh
COPY  ./.ssh/lm_root  /root/.ssh/
COPY  ./.ssh/lm_root.pub  /root/.ssh/
CMD ["bash","./Execute.sh"]
