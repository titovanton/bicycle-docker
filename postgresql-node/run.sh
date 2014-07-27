#!/bin/bash

sudo -u postgres /usr/lib/postgresql/$POSTGRES_VERSION/bin/postgres -D /var/lib/postgresql/$POSTGRES_VERSION/main -c config_file=/etc/postgresql/$POSTGRES_VERSION/main/postgresql.conf 
/etc/init.d/redis-server start
/etc/init.d/memcached start
