#!/bin/bash
echo $REMOTEPASS
cd /root/.ssh
# Ensure the correct permission of keys
chmod 600 $GitSSHKEY
chmod 644 $GitSSHKEY
chmod 600 $SSHKEYANS
chmod 644 $GitSSHKEY

eval $(ssh-agent)
ssh-add $GitSSHKEY
ssh -tt -o StrictHostKeyChecking=no github.com
ssh-keyscan github.com > /root/.ssh/know_host
cd /
git clone git@github.com:jplazaroalonso/AnsibleCMDB.git
cd /AnsibleCMDB
# If  $REMOTEPASS is the default, the script use the SSHKEY to connect with the servers in the inventory
# The idea is not use the security conetxt on the Ansible Inventory and pass the credentials when is executed
# the container (for example retrieve the user and pasword using a vault)
if [ $REMOTEPASS == "NOPASS"]

    eval $(ssh-agent)
    ssh-add $SSHKEYANS
    ansible-playbook ./Ansible/getconfiguration.yaml -i $INVENTARIO 
else
    # use sshpass to connect without interaction when use the --ask-pass flags
    sshpass -p $REMOTEPASS  ansible-playbook ./Ansible/getconfiguration.yaml -i $INVENTARIO -u $REMOTEUSER --ask-pass
fi
eval $(ssh-agent)
ssh-add $GitSSHKEY
# Send to Git repository the changes
git add -A
# Change the next lines with your git data 
git config --global user.email "xxxx@domain.com"
git config --global user.name "gitusr"
git commit -m "Actualize Inventory"
git push origin


