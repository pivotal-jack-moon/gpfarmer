#!/bin/bash

RANGE="61 65"
USER="jomoon"

for i in `seq $RANGE`
do
    ssh $USER@192.168.0.$i "
    sudo rpm -e greenplum-db ; sudo rm -rf /home/gpadmin/greenplum* /root/.ssh /home/gpadmin/.ssh /data/ /data/master /data/primary /data/mirror \
    /usr/local/greenplum-db /usr/local/greenplum-db-4.* /usr/local/greenplum-db-5.* /usr/local/greenplum-db-6.* /tmp/.s.PGSQL.* \
    /data/master/gpseg-1 /data/primary/gpseg{0..9} /data/mirror/gpseg{0..9};
    sudo killall postgres python;
    ls -al /home/gpadmin/greenplum* /root/.ssh /home/gpadmin/.ssh /data/ /data/master /data/primary /data/mirror \
    /usr/local/greenplum-db /usr/local/greenplum-db-4.* /usr/local/greenplum-db-5.* /usr/local/greenplum-db-6.* /tmp/.s.PGSQL.* \
    /tmp/.s.PGSQL.* /data/master/gpseg-1 /data/primary/gpseg{0..9} /data/mirror/gpseg{0..9};
    ps -ef | grep postgres;
"
done
