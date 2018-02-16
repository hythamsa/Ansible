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

The plan is to break down each configuration into its own unique set of Ansible configuration files making it easier for individuals to acquire and tailor for their own needs.


# Configure VPC Peer-Link (Ansible 2.4)
Configure VPC Peer-Link between two N9K switches.

Please note:
- host_vars contains two files (for my particular case) defining the necessary input for the peer-keepalive configuration for each 9K switch host. You MUST modify both of these files (more accurately the "vpc_config" variable) to reflect the IP addressing in use within your environment prior to proceeding or peer-link establishment will fail (this assumes you're not magically using the exact same IP allocation as I am).

- group_vars has two variables, but please focus your attention on "phys_intf". You must adjust the ethernet interfaces in use (in my NXOSV 9K example I'm using 1G interfaces rather than the standard 10G), please be sure to modify the interfaces to correctly reflect your physical environment. If you do not, VPC peer-link establishment will surely fail.

- In vpc.yml there are additional parameters that have not been defined by a variable. These include: port-channel ID, and VPC domain ID. If these do not meet your internal standards, please be sure to change these values to reflect your environment.
