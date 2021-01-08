#!/bin/bash
echo $REMOTEPASS
cd /root/.ssh
chmod 600 lm_root
chmod 644 lm_root.pub
eval $(ssh-agent)
ssh-add lm_root
ssh -tt -o StrictHostKeyChecking=no github.com
ssh-keyscan github.com > /root/.ssh/know_host
cd /
git clone git@github.com:jplazaroalonso/AnsibleCMDB.git
cd /AnsibleCMDB
ansible-playbook ./Ansible/getconfiguration.yaml -i $INVENTARIO 
# sshpass -p $REMOTEPASS  ansible-playbook ./Ansible/getconfiguration.yaml -i $INVENTARIO -u $REMOTEUSER --ask-pass
git add -A
git config --global user.email "juanpablo@lazaroalonso.com"
git config --global user.name "jplazaro"
git commit -m "Actualize Inventory"
git push origin

