#!/bin/bash


# Run Ansbile playbook backup.yml to backup configurations of all NXOS and IOS devices. Once completed, create a directory and move all files into it

basedir=/etc/ansible/backup
tdate=`date +%Y_%m_%d`

# Run Ansible backup
/usr/bin/ansible-playbook /etc/ansible/backup.yml

# Move files into today's date
cd $basedir

if [ ! -d $tdate ]
        then
                mkdir $tdate
fi

mv $basedir/*_config* $basedir/$tdate
