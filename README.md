# Ansible
My collection of Ansible automation scripts for both Linux and NXOS environments. Some are incredibly rudimentary, while others are slightly more complex. Thanks for swinging on by.

# NXOS Staging (Ansible 2.4)
Configure feature sets, creates VLAN IDs and names, SVI interfaces and loopback interfaces with IP addresses, along with VPC configuration on a single site on a pair of 9K switches for my home lab within GNS3. This allows me to quickly reset the entire lab environment (sript will be completed shortly) and quickly turn it back up again allowing me to take on the next challenge.

Ansible server is running on a Raspberry Pi 3 Model B with Raspbian OS outside of the environment with access into my GNS3 environment via a bridged network adapter (see Network Diagram in directory). I'm well aware I could have used the network automation host within GNS3 as it comes pre-packaged with Ansible, but I also have a GlusterFS system with an oVirt lab ready to go on several other Raspberry PIs and I figured why not just use a spare for an Ansible and Bind server.

Please note:

- variables must be defined to match and meet your needs!
- username and password are currently set to admin:admin for the purpose of demonstration. Far more secure methods can be leveraged within Ansible (Please see: http://docs.ansible.com/ansible/2.4/vault.html. More specifically: ansible-vault encrypt_string command). I intend on using this in the future to secure scripts.

# Configure VPC Peer-Link (NXOS, Ansible 2.4)
Configure VPC Peer-Link between two N9K switches.

Please note:
- host_vars contains two files (for my particular case) defining the necessary input for the peer-keepalive configuration for each 9K switch host. You MUST modify both of these files (more accurately the "vpc_config" variable) to reflect the IP addressing in use within your environment prior to proceeding or peer-link establishment will fail (this assumes you're not magically using the exact same IP allocation as I am).

- group_vars has two variables, but please focus your attention on "phys_intf". You must adjust the ethernet interfaces in use (in my NXOSV 9K example I'm using 1G interfaces rather than the standard 10G), please be sure to modify the interfaces to correctly reflect your physical environment. If you do not, VPC peer-link establishment will surely fail.

- In vpc.yml there are additional parameters that have not been defined by a variable. These include: port-channel ID, and VPC domain ID. If these do not meet your internal standards, please be sure to change these values to reflect your environment.

- In vpc.yml the member ports for the port-channel are statically defined and if you are not using the same ports in your environment (lab, prod, virtual, physical...etc) you will need to modify these member ports accordingly.

# Configure OSPF (NXOS, Ansible 2.4)
Configure OSPF domain, assign OSPF parameters to interfaces defined rounding it up with a config write. As usual please make the necessary modifications to the username, password and host definitions. In group_vars/switches.yml you'll find the variable "ospf_interfaces" which will require modification to match the interfaces in your environment. 

# Backup NXOS and IOS Configs (Ansible 2.4)
Leverage Ansible nxos_config and ios_config network modules to perform a backup of your network inventory. Place "configs-backup.sh" into your /etc/cron.daily directory and voila... daily automated backups placed into a directory aptly named after today's date.

Of course before you go ahead and execute "configs-backup.sh" there are some base considerations... variables!

- variable basedir is configured for the stock /etc/ansible/backup directory. FYI: "backup" directory is created by the nxos_config and ios_config network modules automagically if it does not already exist. The script will execute /usr/bin/ansible-playbook against /etc/ansible/backup.yml... so... captain obvious statement ahead... if this is does not fit your directory structure, then you will need to modify it.

# Create VPC (NXOS, Ansible 2.4)
As the name heavily suggests... create a VPC. In this particular example configuration, I deployed only two port-channels each with a unique VPC ID

 - Port-Channel 20 = VPC 20
 - Port-Channel 30 = VPC 30
 
 Please make the necessary changes to the vpc.yml and group_vars/nexus.yml files to match your environment
 
# Raspberry Pi 3 Staging (Ansible 2.4)
Written to stage my Raspberry Pi 3 Model Bs before application staging is to take place (in the process of writing Kubernetes and GlusterFS Ansbile goodness...).

To provide ssh access into your Pi 3s after flashing your SD card, create a blank ssh file within /boot.
- touch /boot/ssh

This will allow ssh access into your systems using default creds:
- username: pi
- password: raspberry

You may receive the following error message if you have not yet ssh'd into each client have their host key installed in ~/.ssh/known_hosts.

fatal: [kubenode1]: FAILED! => {"msg": "Using a SSH password instead of a key is not possible because Host Key checking is enabled and sshpass does not support this.  Please add this host's fingerprint to your known_hosts file to manage this host."}

To mitigate this prior to execution, edit /etc/ansible/ansible.cfg (if executing from default location, if not add "ansible.cfg" into your local project directory) and comment out "host_key_checking = False"

When kicking off the playbook for the first time you will be required to supply a password via the "--ask-pass" argument.
- EG: ansible-playbook staging.yml --ask-pass

You will be prompted for the password before the script continues its execution.


 
Please note:
- PLEASE READ: I disable BOTH WIFI AND BLUETOOTH as I have absolutely no requirement for either one of them. If you require their use, please refer to lines 31 - 38 in staging.yml and comment out as necessary to retain functionality 
- All files found in host_vars will need to be modified to reflect the hostnames you select for you environment
- All "copy" are sourced directly from /etc/ansible/files folder on my local Ansible host. Modify as necessary
- I currently do not have Bind configured (for now) and leverage static entries in /etc/hosts for reachability
- /etc/default/ntpdate references one of my hosts on my network. Modify "NTPSERVERS= " to your host
- I round up the script with a "shutdown -r +1" meaning reboot after 1 minute to kick changes in (disable bluetooth and wifi among others)
