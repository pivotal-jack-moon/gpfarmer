#!/bin/bash

IP_RANGE="51 55"
for i in `seq $IP_RANGE`; do ssh cloud-user@192.168.0.$i sudo systemctl stop firewalld ; done
for i in `seq $IP_RANGE`; do ssh cloud-user@192.168.0.$i sudo systemctl disable firewalld ; done
