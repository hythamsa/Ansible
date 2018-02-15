# Ansible
You'll find my collection of some very basic Ansible YAML based linux node staging files to the more advanced examples configuring a multi-switched environment.

# gluster-staging.yml (Ansible 2.4)
Pretty basic YAML file that I leverage for staging my glusterfs network file system running on the phenomenal Pi 3 Model B leveraging Raspbian. I'll be adding more intelligence to it as time permits such as: reboot after dist-upgrade if firmware on Pi 3 dictates...etc.

# NXOS Staging (Ansible 2.4)
Configure feature sets, creates VLAN IDs and names, SVI interfaces and loopback interfaces with IP addresses, along with VPC configuration on a single site on a pair of 9K switches for my home lab within GNS3. Ansible server is running on a Raspberry Pi 3 Model B with Raspbian OS outside of the environment with access into my GNS3 environment via a bridged network adapter (see Network Diagram in directory). I'm well aware I could have used the network automation host within GNS3 as it comes pre-packaged with Ansible, but... I also have a GlusterFS system with an oVirt lab ready to go on several other Raspberry PIs and I figured why not just use a spare for an Ansible and Bind server.

Currently working on:
- Adding OSPF to interfaces
- Adding iBGP between 9Ks over separate physical link sourcing from lo0. eBGP to be configured outside of my lab to provide default route inbound simulating an ISP to customer environment.
- ASAv to provide (in/out)bound security

The plan is to break down each configuration into its own unique set of Ansible configuration files making it easier for individuals to acuiqre and tailor for their own needs.
