#!/bin/bash

exec /sbin/setuser nobody python /opt/couchpotato/CouchPotato.py --data_dir=/config
