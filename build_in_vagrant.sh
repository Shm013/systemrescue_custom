#! /bin/bash

vagrant up

PROJECT=$(dirname $(realpath $0))
ADDRESS=$(vagrant ssh -c "" 2>/dev/stdout | awk '{print $3}')
PRIVKEY="$PROJECT/.vagrant/machines/default/libvirt/private_key"
SOURCE="/vagrant"

mkdir -p $PROJECT/build/out
scp -r -i $PRIVKEY -o 'StrictHostKeyChecking no' vagrant@$ADDRESS:$SOURCE/out $PROJECT/build/out
