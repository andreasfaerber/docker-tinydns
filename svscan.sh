#!/bin/bash

cat >> /root/.ssh/config <<EOF
StrictHostKeyChecking no
EOF

cd /etc/service/axfrdns && make

if [ ! -d /etc/tinydns/root/.git ]; then
    cd /
    rm -rf /etc/tinydns/root/* /etc/tinydns/root/.git
    cd /etc/tinydns/root
    git clone $GIT_DNSDATA .
fi

# Runs git pull && make in a while loop to avoid cron installation
/dnsdata_update.sh 2>&1 &

svscan /etc/service
