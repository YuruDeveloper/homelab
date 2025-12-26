#!/bin/bash

ansible-playbook -i ./ansible/inventory.yml ./ansible/playbooks/alpine.yml --ask-vault-pass
