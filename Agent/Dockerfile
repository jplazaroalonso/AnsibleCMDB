FROM centos:latest
WORKDIR /
# If you use user/password to connect with the servers in the inventory when run the container 
# add the user and Password as environment variables
ENV REMOTEUSER="root" 
ENV REMOTEPASS="NOPASS"
# Use this EWnvironment variable to indicate the inventory file used with ansible
ENV INVENTARIO="servers"
# this file is the shell script to execute when run the container
COPY ./Agent/Execute.sh /
RUN dnf install -y epel-release wget && \
    dnf install -y python3 && \
    dnf install -y  ansible && \
    dnf install -y openssh && \
    dnf install -y git && \
    chmod u+x Execute.sh && \
    dnf install -y sshpass && \
    dnf install -y dos2unix && \
    dos2unix /Execute.sh
# Use his environment variable to indicate the name of ssh-key used to connect with ansible    
ENV SSHKEYANS="ansibleremotekey"
# Use his environment variable to indicate the name of ssh-key used to connect with Git 
ENV GitSSHKEY="gitremotekey"
COPY  ./.ssh/*  /root/.ssh/
COPY  ./.ssh/*  /root/.ssh/
CMD ["bash","./Execute.sh"]
