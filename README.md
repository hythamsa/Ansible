# Ansible
My collection of Ansible automation scripts for both Linux and NXOS environments. Some are incredibly rudimentary, while others are slightly more complex. Thanks for swinging on by.

# gluster-staging.yml (Ansible 2.4)
Pretty basic YAML file that I leverage for staging my glusterfs network file system running on the phenomenal Pi 3 Model B with Raspbian OS. I'll be adding more intelligence to the staging over time

# NXOS Staging (Ansible 2.4)
Configure feature sets, creates VLAN IDs and names, SVI interfaces and loopback interfaces with IP addresses, along with VPC configuration on a single site on a pair of 9K switches for my home lab within GNS3. This allows me to quickly reset the entire lab environment (sript will be completed shortly) and quickly turn it back up again allowing me to take on the next challenge.

Ansible server is running on a Raspberry Pi 3 Model B with Raspbian OS outside of the environment with access into my GNS3 environment via a bridged network adapter (see Network Diagram in directory). I'm well aware I could have used the network automation host within GNS3 as it comes pre-packaged with Ansible, but I also have a GlusterFS system with an oVirt lab ready to go on several other Raspberry PIs and I figured why not just use a spare for an Ansible and Bind server.

Please note:

- variables must be defined to match and meet your needs!
- username and password are currently set to admin:admin for the purpose of demonstration. Far more secure methods can be leveraged within Ansible (Please see: http://docs.ansible.com/ansible/2.4/vault.html. More specifically: ansible-vault encrypt_string command). I intend on using this in the future to secure scripts.

# Configure VPC Peer-Link (Ansible 2.4)
Configure VPC Peer-Link between two N9K switches.

Please note:
- host_vars contains two files (for my particular case) defining the necessary input for the peer-keepalive configuration for each 9K switch host. You MUST modify both of these files (more accurately the "vpc_config" variable) to reflect the IP addressing in use within your environment prior to proceeding or peer-link establishment will fail (this assumes you're not magically using the exact same IP allocation as I am).

- group_vars has two variables, but please focus your attention on "phys_intf". You must adjust the ethernet interfaces in use (in my NXOSV 9K example I'm using 1G interfaces rather than the standard 10G), please be sure to modify the interfaces to correctly reflect your physical environment. If you do not, VPC peer-link establishment will surely fail.

- In vpc.yml there are additional parameters that have not been defined by a variable. These include: port-channel ID, and VPC domain ID. If these do not meet your internal standards, please be sure to change these values to reflect your environment.

- In vpc.yml the member ports for the port-channel are statically defined and if you are not using the same ports in your environment (lab, prod, virtual, physical...etc) you will need to modify these member ports accordingly.

# Configure OSPF (Ansible 2.4)
Configure OSPF domain, assign OSPF parameters to interfaces defined rounding it up with a config write. As usual please make the necessary modifications to the username, password and host definitions. In group_vars/switches.yml you'll find the variable "ospf_interfaces" which will require modification to match the interfaces in your environment. 
