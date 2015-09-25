#!/bin/sh -eu

confd -onetime -backend env -log-level debug
/usr/bin/db-init
zabbix_server -c /usr/local/etc/zabbix_server.conf
tail -F /tmp/zabbix_server.log
