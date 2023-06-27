#!/bin/bash

###################
# Install ansible #
if ! grep -q "ansible/ansible" /etc/apt/sources.list /etc/apt/sources.list.d/*; then
    echo "Adding Ansible PPA"
    sudo apt-add-repository ppa:ansible/ansible -y
fi

if ! hash ansible >/dev/null 2>&1; then
    echo "Installing Ansible..."
    sudo apt-get update
    sudo apt-get install software-properties-common ansible git -y
    sudo apt update
    sudo apt install python3-pip -y
else
    echo "Ansible already installed"
fi

ansible-galaxy install gantsign.visual-studio-code
ansible-galaxy install viasite-ansible.zsh
ansible-galaxy install 0x0I.tmux
ansible-galaxy install haxorof.docker_ce
#####################################
# Display real installation process #
ansible-playbook --ask-become-pass -i hosts ansible-desktop.yml
cp dotfiles/.zshrc ~/.zshrc
