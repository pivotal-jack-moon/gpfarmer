# What is GPFarmer?

# Where is GPFarmer from?
https://github.com/andreasscherbaum/gpdb-ansible

# Supported GPDB and extension version
GPDB 4.x/5.x/6.x

GPCC 1/2

GPTEXT 3.x.x

madlib 1.1.x

postgis 2.x


# Supported Platform and OS
Virtual Machines

Cloud Infrastructure

Baremetal

RHEL and CentOS 5/6/7


# Prerequisite
MacOS or Fedora/CentOS/RHEL installed with ansible.

At least three supported OS should be prepared with yum repository configured.


# Prepare ansible host to run gpfarmer
* MacOS

$ sudo brew install ansible

* Fedora/CentOS/RHEL

$ sudo yum install ansible


# Download / configure run gpfarmer
git clone https://github.com/pivotal-jack-moon/gpfarmer

$ cd gpfarmer

$ vi ansible-hosts

$ vi role/gpdb/var/mail.yml

$ vi role/gpcc/var/mail.yml

$ vi role/gptext/var/mail.yml

$ vi role/postgis/var/mail.yml

$ vi role/madlib/var/mail.yml

$ make init

$ make install


# Planning
Playbook to remove GPDB and other extensions

Playbook to update GPDB and other extensions

