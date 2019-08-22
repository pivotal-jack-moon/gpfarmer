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
$ git clone https://github.com/pivotal-jack-moon/gpfarmer

$ cd gpfarmer

$ vi ansible-hosts
~~~
[all:vars]
ssh_key_filename="id_rsa"
remote_machine_username="gpadmin"
remote_machine_password="changeme"

[master]
mdw6 ansible_ssh_host=192.168.0.61

[standby]
smdw6 ansible_ssh_host=192.168.0.62

[segments]
sdw6-1 ansible_ssh_host=192.168.0.63
sdw6-2 ansible_ssh_host=192.168.0.64
sdw6-3 ansible_ssh_host=192.168.0.65
~~~

$ vi role/gpdb/var/main.yml
~~~
---
google_cloud: false

# number of Greenplum Database segments
gpdb_number_segments: 2
gpdb_mirror_enable: true
gpdb_spread_mirrors: "-S"

# if you change the version, Ansible will attempt a database upgrade
# greenplum-db-4.3.9.0-build-1-RHEL5-x86_64.zip
gpdb_major_version: 5
gpdb_minor_version: 21.0
gpdb_build_version:
gpdb_rhel_name: 'rhel7'
gpdb_binary_type: 'zip'

smdw_hostname: "smdw6"
seg_serialized_install: False
gpdb_initdb_single: False
gpdb_initdb_with_standby: True
gpdb_network_range: "192.168.0.0"
gpdb_admin_password: "changeme"
~~~

$ vi role/gpcc/var/main.yml
~~~
---
# greenplum-cc-web-6.0.0-beta.5-rhel7_x86_64.zip
# greenplum-cc-web-4.7.0-LINUX-x86_64.zip
gpcc_major_version: 4
gpcc_minor_version: 7.0
gpcc_build_version:
gpcc_rhel_name: LINUX-
# gpcc_rhel_name: rhel7_
gpdb_initdb_only_single: false
gpdb_initdb_with_standby: true
gpcc_network_range: "192.168.0.0/24"
gpcc_subnet_range: 24
gpcc_password: "changeme"
~~~

$ vi role/gptext/var/main.yml
~~~
---
gptext_major_version: 3
gptext_minor_version: 3.0
gptext_patch_version:
gptext_build_version:
gptext_gpdb_version:
gptext_java_version: 1.8.0
gptext_rhel_name: rhel6
gptext_database_name: testdb
gptext_all_hosts: "mdw6 smdw6 sdw6-1 sdw6-2 sdw6-3"
~~~

$ vi role/madlib/var/main.yml
~~~
---
madlib_major_version: 1
madlib_minor_version: 15
madlib_patch_version: 1
madlib_gpdb_version: gp5
madlib_rhel_version: rhel7
madlib_database_name: testdb
madlib_mdw_hostname: mdw6
# madlib-1.15.1-gp5-rhel6-x86_64.tar.gz
# madlib-1.15.1-gp4.3orca-rhel5-x86_64.tar.gz
~~~

$ vi role/postgis/var/mail.yml
~~~
---
postgis_prefix_major_version:
postgis_major_version: 2
postgis_minor_version: 1
postgis_patch_version: .5+pivotal.2
postgis_gpdb_version: gp5
postgis_rhel_version: rhel7
postgis_database_name: testdb
# postgis-2.1.5+pivotal.2-gp5-rhel7-x86_64.gppkgg
# postgis-ossv2.0.3_pv2.0.2_gpdb4.3orca-rhel5-x86_64.gppkg
~~~

$ vi install-host.yml
~~~
---
- hosts: all
  become: yes
  roles:
    - gpdb
    - gptext

- hosts: mdw6
  become: yes
  roles:
    - gpcc
    - madlib
    - postgis
~~~

$ make init

$ make install


# Planning
Playbook to remove GPDB and other extensions

Playbook to update GPDB and other extensions
