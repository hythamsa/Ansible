# Ansible
You'll find my collection of some very basic Ansible YAML based linux node staging files to the more advanced examples configuring a multi-switched environment.

# gluster-staging.yml (Ansible 2.4)
Pretty basic YAML file that I leverage for staging my glusterfs network file system running on the phenomenal Pi 3 Model B leveraging Raspbian. I'll be adding more intelligence to it as time permits such as: reboot after dist-upgrade if firmware on Pi 3 dictates...etc.

# NXOS Staging
Configures feature sets, creates VLAN IDs and names, SVI interfaces, and loopback interfaces with IP addresses on a single site on a pair of 9K switches.

Currently working on:
Adding VPC fucntionality
Adding OSPF
Adding BGP (both i and e) with redistribution into OSPF

Future revisions will include MPLS environment to simulate global WAN.
