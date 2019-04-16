#!/bin/bash
# wget -O - https://raw.githubusercontent.com/pcdlynn/bootstrap/master/bootstrap.sh | bash

# Bootstrap minimum needed to get going with ansible on localhost
#  - install ansible and add localhost to ansible hosts

# Not root
if [ "$EUID" -eq 0 ]; then
    echo "DO NOT run this script as root. You will be asked for sudo password."
    exit 1
fi

echo "######## Installs"
sudo apt-get install software-properties-common -y -qq
sudo apt-add-repository ppa:ansible/ansible -y
sudo apt-get update -qq
sudo apt-get install ansible -y  -qq
sudo apt-get update -qq

echo "######## Versions"
python --version
ansible --version

echo "######## Configure Ansible"
if [ -e /etc/ansible/hosts ]; then
    sudo cp /etc/ansible/hosts "/etc/ansible/`date --iso`_hosts"
    echo "localhost ansible_connection=local" | sudo tee /etc/ansible/hosts > /dev/null
fi

echo "######## Cat hosts file"
cat /etc/ansible/hosts
echo "######## Get bootstrap playbook"
wget -O - https://raw.githubusercontent.com/pcdlynn/bootstrap/master/playbook-t570.yml

# cd $HOME/"$BOOTSTRAPDIR"
# read -p "Press [Enter] key to start deploying..."
# ansible-playbook -i hosts playbook64.yml -c local -K -vvv

