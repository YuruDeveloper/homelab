#!/bin/bash

ansible-playbook -i ./ansible/inventory.yml ./ansible/playbooks/debian.yml --ask-vault-pass
