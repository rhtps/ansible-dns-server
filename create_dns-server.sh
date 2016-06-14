#!/usr/bin/env bash

. ./env_aws.sh

read -p "RHN Username: " username
read -s -p "RHN Password: " password
export rhn_username="${username}"
export rhn_password="${password}"
echo

if [[ "$OSTYPE" == "darwin"* ]]; then
    export PYTHONPATH=/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/site-packages:/usr/local/lib/python2.7/site-packages
fi

# Temporary Ansible 2.2 setup
if [ ! -d ./ansible ]; then
    git clone --recursive https://github.com/ansible/ansible
else
    pushd ansible
    git pull
    popd
fi
. ./ansible/hacking/env-setup

# Grab the openshift-ansible repo
if [ ! -d ./openshift-ansible ]; then
    git clone https://github.com/openshift/openshift-ansible
else
    pushd openshift-ansible
    git pull
    popd
fi

ansible-playbook -v -i inventory/aws/hosts/ec2.py \
    --extra-vars "rhn_username=${rhn_username} rhn_password=${rhn_password} \
                  ec2_keypair=${ec2_keypair}" \
    dns-server.yml

printf "Refreshing EC2 cache..."
./inventory/aws/hosts/ec2.py --refresh-cache
printf "done\n"

# For security, wipe out the RHN password
unset rhn_password